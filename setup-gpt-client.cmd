@echo off
setlocal EnableExtensions

set "SUB2API_SETUP_SELF=%~f0"
set "SUB2API_SETUP_BASE_URL=http://192.168.18.17:8088/v1"
set "SUB2API_SETUP_MODEL=gpt-5.6-sol"
set "SUB2API_SETUP_HEALTH_ONLY=0"
set "SUB2API_SETUP_SAVE=1"

if /I "%~1"=="--health-only" set "SUB2API_SETUP_HEALTH_ONLY=1"
if /I "%~1"=="--verify-only" set "SUB2API_SETUP_SAVE=0"
if not "%~1"=="" if /I not "%~1"=="--health-only" if /I not "%~1"=="--verify-only" set "SUB2API_SETUP_BASE_URL=%~1"
if not "%~2"=="" set "SUB2API_SETUP_MODEL=%~2"

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$raw=[IO.File]::ReadAllText($env:SUB2API_SETUP_SELF); $marker='# POWER'+'SHELL_PAYLOAD'; $index=$raw.IndexOf($marker); if($index -lt 0){throw 'PowerShell payload marker not found.'}; $code=$raw.Substring($index+$marker.Length); & ([ScriptBlock]::Create($code))"
set "SETUP_EXIT=%ERRORLEVEL%"

echo.
if not "%SETUP_EXIT%"=="0" echo Client setup failed with exit code %SETUP_EXIT%.
if "%~1"=="" pause
exit /b %SETUP_EXIT%

# POWERSHELL_PAYLOAD
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

function ConvertTo-TomlString([string]$Value) {
    $escaped = $Value.Replace('\', '\\').Replace('"', '\"')
    return '"' + $escaped + '"'
}

function Get-PreferredNewLine([string]$Content) {
    if ($Content.Contains("`r`n")) {
        return "`r`n"
    }
    return "`n"
}

function Set-CodexConfiguration([string]$BaseUrl, [string]$Model, [string]$ApiKey) {
    if ([string]::IsNullOrWhiteSpace($env:CODEX_HOME)) {
        $codexHome = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.codex'
    }
    else {
        $codexHome = $env:CODEX_HOME
    }
    $codexHome = [IO.Path]::GetFullPath($codexHome)
    New-Item -ItemType Directory -Path $codexHome -Force | Out-Null

    $utf8NoBom = New-Object Text.UTF8Encoding($false)
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmssfff'
    $configPath = Join-Path $codexHome 'config.toml'
    $configOriginal = if (Test-Path -LiteralPath $configPath) {
        [IO.File]::ReadAllText($configPath)
    }
    else {
        ''
    }
    $newline = Get-PreferredNewLine -Content $configOriginal

    # Remove only the provider block managed by this script.
    $providerPattern = '(?ms)^[ \t]*\[model_providers\.sub2api\][ \t]*(?:\r?\n|$).*?(?=^[ \t]*\[|\z)'
    $config = [Text.RegularExpressions.Regex]::Replace($configOriginal, $providerPattern, '')

    # model and model_provider must be TOML root keys, before the first table.
    $firstTable = [Text.RegularExpressions.Regex]::Match($config, '(?m)^[ \t]*\[')
    if ($firstTable.Success) {
        $preamble = $config.Substring(0, $firstTable.Index)
        $tables = $config.Substring($firstTable.Index)
    }
    else {
        $preamble = $config
        $tables = ''
    }
    $rootKeyPattern = '(?m)^[ \t]*(?:model|model_provider)[ \t]*=.*(?:\r?\n|$)'
    $preamble = [Text.RegularExpressions.Regex]::Replace($preamble, $rootKeyPattern, '')

    $managedRoot = @(
        'model = ' + (ConvertTo-TomlString $Model)
        'model_provider = "sub2api"'
    ) -join $newline
    $provider = @(
        '[model_providers.sub2api]'
        'name = "Sub2API LAN"'
        'base_url = ' + (ConvertTo-TomlString $BaseUrl)
        'wire_api = "responses"'
        'env_key = "SUB2API_API_KEY"'
        'requires_openai_auth = false'
    ) -join $newline

    $configParts = @($managedRoot)
    if (-not [string]::IsNullOrWhiteSpace($preamble)) {
        $configParts += $preamble.Trim()
    }
    if (-not [string]::IsNullOrWhiteSpace($tables)) {
        $configParts += $tables.Trim()
    }
    $configParts += $provider
    $configUpdated = ($configParts -join ($newline + $newline)) + $newline

    $configBackup = $null
    if ($configUpdated -ne $configOriginal) {
        if (Test-Path -LiteralPath $configPath) {
            $configBackup = $configPath + '.sub2api-backup-' + $stamp
            Copy-Item -LiteralPath $configPath -Destination $configBackup -Force
        }
        [IO.File]::WriteAllText($configPath, $configUpdated, $utf8NoBom)
    }

    if ($ApiKey.Contains("`r") -or $ApiKey.Contains("`n")) {
        throw 'API key cannot contain line breaks.'
    }
    $envPath = Join-Path $codexHome '.env'
    $envOriginal = if (Test-Path -LiteralPath $envPath) {
        [IO.File]::ReadAllText($envPath)
    }
    else {
        ''
    }
    $envNewline = Get-PreferredNewLine -Content $envOriginal
    $envWithoutKey = [Text.RegularExpressions.Regex]::Replace(
        $envOriginal,
        '(?m)^[ \t]*SUB2API_API_KEY=.*(?:\r?\n|$)',
        ''
    ).Trim()
    $envUpdated = 'SUB2API_API_KEY=' + $ApiKey + $envNewline
    if (-not [string]::IsNullOrWhiteSpace($envWithoutKey)) {
        $envUpdated += $envWithoutKey + $envNewline
    }

    $envBackup = $null
    if ($envUpdated -ne $envOriginal) {
        if (Test-Path -LiteralPath $envPath) {
            $envBackup = $envPath + '.sub2api-backup-' + $stamp
            Copy-Item -LiteralPath $envPath -Destination $envBackup -Force
        }
        [IO.File]::WriteAllText($envPath, $envUpdated, $utf8NoBom)
    }

    Write-Host ('[OK] Codex config: ' + $configPath) -ForegroundColor Green
    Write-Host ('[OK] Codex key file: ' + $envPath) -ForegroundColor Green
    if ($configBackup) {
        Write-Host ('    Config backup: ' + $configBackup)
    }
    if ($envBackup) {
        Write-Host ('    Key file backup: ' + $envBackup)
    }
}

try {
    $base = $env:SUB2API_SETUP_BASE_URL.Trim().TrimEnd('/')
    if (-not $base.EndsWith('/v1')) {
        $base += '/v1'
    }
    $root = $base.Substring(0, $base.Length - 3)
    $healthUrl = $root + '/health'

    Write-Host ('[+] Testing ' + $healthUrl)
    $health = Invoke-WebRequest -UseBasicParsing -Uri $healthUrl -TimeoutSec 10 -Proxy $null
    if ([int]$health.StatusCode -ne 200) {
        throw ('Health check returned HTTP ' + $health.StatusCode)
    }
    Write-Host '[OK] Relay connection succeeded.' -ForegroundColor Green
    Write-Host ('Base URL: ' + $base)

    if ($env:SUB2API_SETUP_HEALTH_ONLY -eq '1') {
        exit 0
    }

    $key = $env:SUB2API_API_KEY
    if ([string]::IsNullOrWhiteSpace($key)) {
        $secure = Read-Host 'Enter the Sub2API API key' -AsSecureString
        $pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
        try {
            $key = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
        }
        finally {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
        }
    }
    if ([string]::IsNullOrWhiteSpace($key)) {
        throw 'API key cannot be empty.'
    }

    $headers = @{ Authorization = 'Bearer ' + $key }
    Write-Host '[+] Validating API key and loading models.'
    $models = Invoke-RestMethod -Method Get -Uri ($base + '/models') -Headers $headers -TimeoutSec 20 -Proxy $null
    $modelNames = @()
    foreach ($item in @($models.data)) {
        if ($item.id) {
            $modelNames += [string]$item.id
        }
    }
    if ($modelNames.Count -eq 0) {
        throw 'The relay returned no models.'
    }

    $model = $env:SUB2API_SETUP_MODEL
    if ($modelNames -notcontains $model) {
        foreach ($name in $modelNames) {
            if ($name -like 'gpt-*') {
                $model = $name
                break
            }
        }
    }
    Write-Host ('[OK] API key accepted; models returned: ' + $modelNames.Count) -ForegroundColor Green

    Write-Host ('[+] Calling GPT model ' + $model)
    $payload = @{
        model = $model
        input = 'Reply with exactly: CLIENT_OK'
    }
    $body = ConvertTo-Json -InputObject $payload -Compress
    $response = Invoke-RestMethod `
        -Method Post `
        -Uri ($base + '/responses') `
        -Headers $headers `
        -ContentType 'application/json' `
        -Body $body `
        -TimeoutSec 120 `
        -Proxy $null

    $text = [string]$response.output_text
    if ([string]::IsNullOrWhiteSpace($text)) {
        $parts = @()
        foreach ($output in @($response.output)) {
            foreach ($content in @($output.content)) {
                if ($content.text) {
                    $parts += [string]$content.text
                }
            }
        }
        $text = $parts -join ''
    }
    if ([string]::IsNullOrWhiteSpace($text)) {
        throw 'GPT returned no text.'
    }
    Write-Host ('[OK] GPT response: ' + $text.Trim()) -ForegroundColor Green

    if ($env:SUB2API_SETUP_SAVE -ne '1') {
        Write-Host '[OK] Verification completed; user environment was not changed.' -ForegroundColor Green
        exit 0
    }

    Write-Host '[+] Configuring Codex.'
    Set-CodexConfiguration -BaseUrl $base -Model $model -ApiKey $key

    if ($env:SUB2API_SETUP_SKIP_USER_ENV -ne '1') {
        [Environment]::SetEnvironmentVariable('OPENAI_BASE_URL', $base, 'User')
        [Environment]::SetEnvironmentVariable('OPENAI_API_BASE', $base, 'User')
        [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', $key, 'User')
        [Environment]::SetEnvironmentVariable('SUB2API_API_KEY', $key, 'User')
        [Environment]::SetEnvironmentVariable('OPENAI_MODEL', $model, 'User')
        [Environment]::SetEnvironmentVariable('SUB2API_MODEL', $model, 'User')
    }

    Write-Host '[OK] Client configuration completed.' -ForegroundColor Green
    Write-Host 'Fully close Codex and all terminal windows, then start Codex again.'
    exit 0
}
catch {
    Write-Host ('[ERROR] ' + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
