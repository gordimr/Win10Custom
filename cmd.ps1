# Registry to PowerShell converter - https://reg2ps.azurewebsites.net/
Write-Host "Settings > Personalization > Colors > Disable Transparency effects" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'EnableTransparency' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

Write-Host "Settings > Personalization > Start > Don't show recently opened items in Jump Lists on Start or the taskbar and in File Explorer Quick Access" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackDocs' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

Write-Host "Control Panel > Ease of Access Center > Make the computer easier to see > Remove background images (when available)" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Value ([byte[]](0x90,0x12,0x03,0x80,0x91,0x00,0x00,0x00)) -PropertyType Binary -Force -ea SilentlyContinue;

Write-Host "Control Panel > Ease of Access Center > Make the computer easier to see > Turn off all unnecessary animations (when possible)" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop\WindowMetrics") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop\WindowMetrics" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value '0' -PropertyType String -Force -ea SilentlyContinue;

Write-Host "Settings > Devices > Mouse > Additional Mouse Options > Pointer Options > Disable Enhance pointer precision" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\Control Panel\Mouse") -ne $true) {  New-Item "HKCU:\Control Panel\Mouse" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -Value '0' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -Value '0' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -Value '0' -PropertyType String -Force -ea SilentlyContinue;

Write-Host "Disable Bing Search" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

Write-Host "Ultimate Perofrmance Power Plan" -ForegroundColor green -BackgroundColor black
Write-Host "Define the name and GUID of the power scheme" -ForegroundColor green -BackgroundColor black
$powerSchemeName = "Ultimate Performance"
$powerSchemeGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
Write-Host "Getting all power schemes" -ForegroundColor green -BackgroundColor black
$schemes = powercfg /list | Out-String -Stream
Write-Host "Checking if the power scheme already exists" -ForegroundColor green -BackgroundColor black
$ultimateScheme = $schemes | Where-Object { $_ -match $powerSchemeName }
if ($null -eq $ultimateScheme) {
	Write-Host "Power scheme '$powerSchemeName' not found. Adding..."
	Write-Host "Downloading Ultimate Perofrmance Plan to $env:temp" -ForegroundColor green -BackgroundColor black
	powershell -command "Invoke-WebRequest -Uri 'https://github.com/gordimr/Win10Custom/raw/main/Ultimate%20Performance.pow' -OutFile '$env:temp\Ultimate Performance.pow'"
	Write-Host "Importing Ultimate Performance" -ForegroundColor green -BackgroundColor black
	powercfg -import "$env:temp\Ultimate Performance.pow" e9a42b02-d5df-448d-aa00-03f14749eb61
}
Write-Host "Applying Ultimate Performance" -ForegroundColor green -BackgroundColor black
powercfg /S $powerSchemeGuid
Write-Host "Screen never turn off" -ForegroundColor green -BackgroundColor black
powercfg -change -monitor-timeout-ac 0

Write-Host "Changing PC Name to $env:username" -ForegroundColor green -BackgroundColor black
Rename-Computer -NewName $env:username

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -force -ea SilentlyContinue };

Write-Host "Using $env:username as Username on Winlogon" -ForegroundColor green -BackgroundColor black
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUsername' -Value $env:username -PropertyType String -Force -ea SilentlyContinue;

Write-Host "Password don't expire" -ForegroundColor green -BackgroundColor black
Set-LocalUser -Name "$env:username" -PasswordNeverExpires 1

Write-Host "Enable AutoAdminLogon" -ForegroundColor green -BackgroundColor black
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon' -Value '1' -PropertyType String -Force -ea SilentlyContinue;

Write-Host "Adding Password to PC" -ForegroundColor green -BackgroundColor black
$PCPassword = read-host -Prompt "Password"

Write-Host "Using $PCPassword as Password on PC" -ForegroundColor green -BackgroundColor black
Set-LocalUser -Name $env:username -Password (ConvertTo-SecureString -AsPlainText $PCPassword -Force)

Write-Host "Using $PCPassword as Password on Winlogon" -ForegroundColor green -BackgroundColor black
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword' -Value $PCPassword -PropertyType String -Force -ea SilentlyContinue;