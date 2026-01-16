# Quickstrap - Developer Mode Activation (Windows)
# Activates the virtual environment and sets up environment variables.
#
# Usage: Dot-source this script to activate the environment:
#   . .\quickstrap\activate.ps1
#
# Note: You must dot-source (.) this script, not run it directly,
# for the environment changes to persist in your shell session.

# Function to read INI file values using Python (guaranteed available)
function Read-IniValue {
    param (
        [string]$File,
        [string]$Section,
        [string]$Key,
        [string]$Default = ""
    )

    $pythonCode = @"
from configparser import ConfigParser
config = ConfigParser()
config.read('$File')
print(config.get('$Section', '$Key', fallback='$Default'))
"@

    try {
        $result = python -c $pythonCode 2>$null
        if ($result) {
            return $result.Trim()
        }
        return $Default
    }
    catch {
        return $Default
    }
}

# Find the project root directory (parent of quickstrap/)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

# Save current location to return to
$OriginalLocation = Get-Location

# Change to project root for reading config files
Set-Location $ProjectRoot

# Parse quickstrap/installation_profiles.ini
$AppName = Read-IniValue -File "quickstrap/installation_profiles.ini" -Section "metadata" -Key "app_name" -Default "Application"
$ConfigDir = Read-IniValue -File "quickstrap/installation_profiles.ini" -Section "metadata" -Key "config_dir" -Default "app"

# Check if virtual environment exists
$VenvPath = Join-Path $ProjectRoot "venv"
if (-not (Test-Path $VenvPath)) {
    Write-Host "Error: Virtual environment not found." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please run the installer first:"
    Write-Host "  python install.py"
    Write-Host ""
    Set-Location $OriginalLocation
    return
}

# Activate virtual environment
$VenvActivate = Join-Path $VenvPath "Scripts" "Activate.ps1"
if (Test-Path $VenvActivate) {
    & $VenvActivate
}
else {
    Write-Host "Error: Virtual environment activation script not found." -ForegroundColor Red
    Write-Host "Expected: $VenvActivate"
    Set-Location $OriginalLocation
    return
}

# Set environment variables for the application
$env:QUICKSTRAP_APP_NAME = $AppName
$env:QUICKSTRAP_CONFIG_DIR = $ConfigDir
$env:QUICKSTRAP_PROJECT_ROOT = $ProjectRoot

# Set config file path (Windows uses LOCALAPPDATA instead of ~/.config)
$env:QUICKSTRAP_CONFIG_FILE = Join-Path $env:LOCALAPPDATA $ConfigDir "installation_profile.ini"

# Return to original location
Set-Location $OriginalLocation

# Display activation message
Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host " $AppName - Developer Mode Active" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Environment Variables Set:" -ForegroundColor Yellow
Write-Host "  QUICKSTRAP_APP_NAME     = $env:QUICKSTRAP_APP_NAME"
Write-Host "  QUICKSTRAP_CONFIG_DIR   = $env:QUICKSTRAP_CONFIG_DIR"
Write-Host "  QUICKSTRAP_PROJECT_ROOT = $env:QUICKSTRAP_PROJECT_ROOT"
Write-Host "  QUICKSTRAP_CONFIG_FILE  = $env:QUICKSTRAP_CONFIG_FILE"
Write-Host ""
Write-Host "Virtual environment activated. Run 'deactivate' to exit." -ForegroundColor Green
Write-Host ""
