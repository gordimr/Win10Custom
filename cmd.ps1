# Registry to PowerShell converter - https://reg2ps.azurewebsites.net/
# Settings > Personalization > Colors > Disable Transparency effects
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'EnableTransparency' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

# Settings > Personalization > Start > Don't show recently opened items in Jump Lists on Start or the taskbar and in File Explorer Quick Access
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackDocs' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

# Control Panel > Ease of Access Center > Make the computer easier to see > Remove background images (when available)
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Value ([byte[]](0x90,0x12,0x03,0x80,0x91,0x00,0x00,0x00)) -PropertyType Binary -Force -ea SilentlyContinue;

# Control Panel > Ease of Access Center > Make the computer easier to see > Turn off all unnecessary animations (when possible)
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop\WindowMetrics") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop\WindowMetrics" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value '0' -PropertyType String -Force -ea SilentlyContinue;

# Settings > Devices > Mouse > Additional Mouse Options > Pointer Options > Disable Enhance pointer precision
if((Test-Path -LiteralPath "HKCU:\Control Panel\Mouse") -ne $true) {  New-Item "HKCU:\Control Panel\Mouse" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -Value '0' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -Value '0' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -Value '0' -PropertyType String -Force -ea SilentlyContinue;

# Disable Bing Search
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

# Ultimate Perofrmance
# Define the name and GUID of the power scheme
	$powerSchemeName = "Ultimate Performance"
	$powerSchemeGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
	
	# Get all power schemes
	$schemes = powercfg /list | Out-String -Stream
	
	# Check if the power scheme already exists
	$ultimateScheme = $schemes | Where-Object { $_ -match $powerSchemeName }
	if ($null -eq $ultimateScheme) {
	Write-Host "Power scheme '$powerSchemeName' not found. Adding..."

	# Download Ultimate Perofrmance Plan to %TEMP%
	powershell -command "Invoke-WebRequest -Uri 'https://github.com/gordimr/Win10Custom/raw/main/Ultimate%20Performance.pow' -OutFile '$env:temp\Ultimate Performance.pow'"
	# Import Ultimate Performance
	powercfg -import "$env:temp\Ultimate Performance.pow" e9a42b02-d5df-448d-aa00-03f14749eb61
	# Apply Ultimate Performance
	powercfg /S $powerSchemeGuid