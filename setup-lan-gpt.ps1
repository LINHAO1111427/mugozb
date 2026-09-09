#requires -Version 5.1

[CmdletBinding()]
param(
    [ValidateSet('Auto', 'Enable', 'Client', 'Disable', 'Status', 'SelfTest')]
    [string]$Mode = 'Auto',
    [string]$ListenAddress = '192.168.18.17',
    [ValidateRange(1, 65535)]
    [int]$Port = 8088,
    [string]$BackendAddress = '127.0.0.1'
)

$ErrorActionPreference = 'Stop'
$script:FirewallName = "Sub2API LAN $ListenAddress`:$Port"
$script:BaseUrl = "http://$ListenAddress`:$Port/v1"

function Write-Step([string]$Message) {
    Write-Host "[+] $Message" -ForegroundColor Cyan
}

function Write-Ok([string]$Message) {
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Start-Elevated([string]$Action) {
    $arguments = @(
        '-NoProfile',
        '-ExecutionPolicy', 'Bypass',
        '-File', $PSCommandPath,
        '-Mode', $Action,
        '-ListenAddress', $ListenAddress,
        '-Port', [string]$Port,
        '-BackendAddress', $BackendAddress
    )
    $quoted = $arguments | ForEach-Object { '"' + ($_ -replace '"', '\"') + '"' }
    Write-Step 'Requesting administrator privileges.'
    $process = Start-Process -FilePath 'powershell.exe' -Verb RunAs -Wait -PassThru -ArgumentList ($quoted -join ' ')
    exit $process.ExitCode
}

function Test-ListenAddressIsLocal {
    $addresses = @(Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | ForEach-Object { $_.IPAddress })
    return ($addresses -contains $ListenAddress)
}

function Assert-ListenAddressIsLocal {
    if (-not (Test-ListenAddressIsLocal)) {
        $addresses = @(Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | ForEach-Object { $_.IPAddress })
        throw "This PC does not own IPv4 address $ListenAddress. Available addresses: $($addresses -join ', ')"
    }
}

function Get-HealthStatus([string]$Address) {
    try {
        $response = Invoke-WebRequest -UseBasicParsing -Uri "http://$Address`:$Port/health" -TimeoutSec 5
        return [int]$response.StatusCode
    }
    catch {
        return 0
    }
}

function Wait-LanEndpoint {
    for ($attempt = 1; $attempt -le 15; $attempt++) {
        $status = Get-HealthStatus -Address $ListenAddress
        if ($status -eq 200) {
            return
        }
        Start-Sleep -Seconds 1
    }
    throw "LAN endpoint did not become reachable: http://$ListenAddress`:$Port/health"
}

function Remove-PortProxy {
    & netsh.exe interface portproxy delete v4tov4 listenaddress=$ListenAddress listenport=$Port protocol=tcp 2>$null | Out-Null
}

function Enable-LanRelay {
    Assert-ListenAddressIsLocal
    $backendStatus = Get-HealthStatus -Address $BackendAddress
    if ($backendStatus -ne 200) {
        throw "The existing relay is not healthy at http://$BackendAddress`:$Port/health (HTTP $backendStatus)."
    }
    if (-not (Test-IsAdministrator)) {
        Start-Elevated -Action 'Enable'
    }

    $ipHelper = Get-Service -Name iphlpsvc -ErrorAction Stop
    if ($ipHelper.Status -ne 'Running') {
        Start-Service -Name iphlpsvc
    }

    Write-Step "Forwarding $ListenAddress`:$Port to $BackendAddress`:$Port."
    Remove-PortProxy
    & netsh.exe interface portproxy add v4tov4 listenaddress=$ListenAddress listenport=$Port connectaddress=$BackendAddress connectport=$Port protocol=tcp | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "netsh portproxy failed with exit code $LASTEXITCODE."
    }

    Get-NetFirewallRule -DisplayName $script:FirewallName -ErrorAction SilentlyContinue | Remove-NetFirewallRule
    New-NetFirewallRule `
        -DisplayName $script:FirewallName `
        -Direction Inbound `
        -Action Allow `
        -Protocol TCP `
        -LocalAddress $ListenAddress `
        -LocalPort $Port `
        -RemoteAddress LocalSubnet `
        -Profile Any | Out-Null

    Wait-LanEndpoint
    Write-Ok "LAN relay is ready: $script:BaseUrl"
    Write-Host 'The other PC only needs this Base URL and an existing Sub2API key.'
}

function Test-ClientConnection {
    Write-Step "Testing the relay at http://$ListenAddress`:$Port/health."
    $status = Get-HealthStatus -Address $ListenAddress
    if ($status -ne 200) {
        throw "Cannot reach the relay at http://$ListenAddress`:$Port/health (HTTP $status)."
    }
    Write-Ok 'This PC can reach the Sub2API relay.'
    Write-Output "base_url=$script:BaseUrl"
    Write-Output 'api_key=use an existing key from the Sub2API admin page'
}

function Disable-LanRelay {
    if (-not (Test-IsAdministrator)) {
        Start-Elevated -Action 'Disable'
    }
    Remove-PortProxy
    Get-NetFirewallRule -DisplayName $script:FirewallName -ErrorAction SilentlyContinue | Remove-NetFirewallRule
    Write-Ok "Removed LAN forwarding for $ListenAddress`:$Port."
}

function Show-Status {
    $backendStatus = Get-HealthStatus -Address $BackendAddress
    $lanStatus = Get-HealthStatus -Address $ListenAddress
    Write-Output "backend=http://$BackendAddress`:$Port/health http_status=$backendStatus"
    Write-Output "lan=http://$ListenAddress`:$Port/health http_status=$lanStatus"
    Write-Output "base_url=$script:BaseUrl"
    & netsh.exe interface portproxy show v4tov4
}

function Invoke-SelfTest {
    $parsedAddress = $null
    if (-not [Net.IPAddress]::TryParse($ListenAddress, [ref]$parsedAddress)) {
        throw "Invalid ListenAddress: $ListenAddress"
    }
    if ($parsedAddress.AddressFamily -ne [Net.Sockets.AddressFamily]::InterNetwork) {
        throw 'ListenAddress must be IPv4.'
    }
    $backendStatus = Get-HealthStatus -Address $BackendAddress
    if ($backendStatus -ne 200) {
        throw "Existing relay health check failed with HTTP $backendStatus."
    }
    Write-Output 'SELFTEST PASS'
    Write-Output "backend=http://$BackendAddress`:$Port/health http_status=$backendStatus"
    Write-Output "forward=$ListenAddress`:$Port->$BackendAddress`:$Port"
    Write-Output "base_url=$script:BaseUrl"
}

try {
    switch ($Mode) {
        'Auto' {
            if (Test-ListenAddressIsLocal) {
                Enable-LanRelay
            }
            else {
                Test-ClientConnection
            }
        }
        'Enable' { Enable-LanRelay }
        'Client' { Test-ClientConnection }
        'Disable' { Disable-LanRelay }
        'Status' { Show-Status }
        'SelfTest' { Invoke-SelfTest }
    }
}
catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
