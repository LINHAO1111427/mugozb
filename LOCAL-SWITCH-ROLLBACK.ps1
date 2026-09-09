$ErrorActionPreference = 'Stop'

$backupDir = Join-Path $PSScriptRoot '.rollback\local-switch-20260905-remote'
$codexHome = Join-Path $HOME '.codex'
$configBackup = Join-Path $backupDir 'config.toml.before'
$envBackup = Join-Path $backupDir 'codex.env.before'
$userEnvBackup = Join-Path $backupDir 'user-env.dpapi.clixml'

foreach ($path in @($configBackup, $envBackup, $userEnvBackup)) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Rollback input not found: $path"
    }
}

Copy-Item -LiteralPath $configBackup -Destination (Join-Path $codexHome 'config.toml') -Force
Copy-Item -LiteralPath $envBackup -Destination (Join-Path $codexHome '.env') -Force

foreach ($item in @(Import-Clixml -LiteralPath $userEnvBackup)) {
    if ($item.Exists) {
        $pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($item.Value)
        try {
            $value = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
            [Environment]::SetEnvironmentVariable($item.Name, $value, 'User')
        }
        finally {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
        }
    }
    else {
        [Environment]::SetEnvironmentVariable($item.Name, $null, 'User')
    }
}

& docker start sub2api-postgres sub2api | Out-Host
if ($LASTEXITCODE -ne 0) {
    throw "docker start failed with exit code $LASTEXITCODE"
}

$configHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $codexHome 'config.toml')).Hash.ToLower()
$envHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $codexHome '.env')).Hash.ToLower()
Write-Host 'ROLLBACK PASS'
Write-Host "config_sha256=$configHash"
Write-Host "codex_env_sha256=$envHash"
Write-Host 'local_containers_started=True'
