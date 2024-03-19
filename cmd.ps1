# Registry to PowerShell converter - https://reg2ps.azurewebsites.net/
Write-Host "Settings > Personalization > Colors > Transparency effects > Off" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'EnableTransparency' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

Write-Host "Settings > Personalization > Start > Show recently opened items in Jump Lists on Start or the taskbar and in File Explorer Quick Access > Off" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackDocs' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

Write-Host "Control Panel > Ease of Access Center > Make the computer easier to see > Remove background images (when available) > On" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Value ([byte[]](0x90,0x12,0x03,0x80,0x91,0x00,0x00,0x00)) -PropertyType Binary -Force -ea SilentlyContinue;

Write-Host "Control Panel > Ease of Access Center > Make the computer easier to see > Turn off all unnecessary animations (when possible) > On" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\Control Panel\Desktop\WindowMetrics") -ne $true) {  New-Item "HKCU:\Control Panel\Desktop\WindowMetrics" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value '0' -PropertyType String -Force -ea SilentlyContinue;

Write-Host "Settings > Devices > Mouse > Additional Mouse Options > Pointer Options > Enhance pointer precision > Off" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\Control Panel\Mouse") -ne $true) {  New-Item "HKCU:\Control Panel\Mouse" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -Value '0' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -Value '0' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -Value '0' -PropertyType String -Force -ea SilentlyContinue;

Write-Host "Bing Search > Off" -ForegroundColor green -BackgroundColor black
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

Write-Host "Control Panel > Power Options > Ultimate Perofrmance > On" -ForegroundColor green -BackgroundColor black
$powerSchemeName = "Ultimate Performance"
$powerSchemeGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
$schemes = powercfg /list | Out-String -Stream
$ultimateScheme = $schemes | Where-Object { $_ -match $powerSchemeName }
if ($null -eq $ultimateScheme) {
	Invoke-WebRequest -Uri 'https://github.com/gordimr/Win10Custom/raw/main/Ultimate%20Performance.pow' -OutFile '$env:temp\Ultimate Performance.pow'
	powercfg -import "$env:temp\Ultimate Performance.pow" $powerSchemeGuid
}
powercfg /S $powerSchemeGuid

Write-Host "Settings > Power & Sleep > Screen > When plugged in, turn off after > Never" -ForegroundColor green -BackgroundColor black
powercfg -change -monitor-timeout-ac 0

Write-Host "Indexing Service Disabled" -ForegroundColor green -BackgroundColor black
Get-Service WSearch | Stop-Service | Set-Service -StartupType Disabled

if ($env:computername -ne $env:username) {
Write-Host "PC Name Changed To $env:username" -ForegroundColor green -BackgroundColor black
Rename-Computer -NewName $env:username
}

Write-Host "Computer Management > System Tools > Local Users and Groups > Users > $env:username > Password never expires > On" -ForegroundColor green -BackgroundColor black
Set-LocalUser -Name "$env:username" -PasswordNeverExpires 1

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon") -ne $true) {  New-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -force -ea SilentlyContinue };

Write-Host "$env:username Added to HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon as DefaultUsername" -ForegroundColor green -BackgroundColor black
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultUsername' -Value $env:username -PropertyType String -Force -ea SilentlyContinue;

Write-Host "Folder Properties > Customize > Optimize all folders > General items" -ForegroundColor green -BackgroundColor black
$BasePath = 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell'
if ( Test-Path -Path "$BasePath\Bags" ) {
	Remove-Item -Path "$BasePath\Bags" -Recurse -Force
}
if ( Test-Path -Path "$BasePath\BagMRU" ) {
	Remove-Item -Path "$BasePath\BagMRU" -Recurse -Force
}
$Bags = New-Item -Path $BasePath -Name 'Bags' -Force
$AllFolders = New-Item -Path $Bags.PSPath -Name 'AllFolders' -Force
$Shell = New-Item -Path $AllFolders.PSPath -Name 'Shell' -Force
New-ItemProperty -Path $Shell.PSPath -Name 'FolderType' -Value 'NotSpecified' -PropertyType String -Force

Write-Host "Settings > Time & language > Language > Hebrew (Standard)" -ForegroundColor green -BackgroundColor black
$UserLanguageList = New-WinUserLanguageList -Language "en-US"
$UserLanguageList.Add("he-IL")
Set-WinUserLanguageList -LanguageList $UserLanguageList -Force
Write-Host "Settings > Time & language > Language > Hebrew (BasicTyping, TextToSpeech)" -ForegroundColor green -BackgroundColor black
Install-Language -Language he-IL -AsJob -Verbose
Write-Host "Settings > Time & language > Region >  Country or region > Israel" -ForegroundColor green -BackgroundColor black
Set-Culture -CultureInfo he-IL
Write-Host "Settings > Time & language > Region >  Regional format > Hebrew (Israel)" -ForegroundColor green -BackgroundColor black
Set-WinSystemLocale -SystemLocale he-IL
Write-Host "Settings > Date & time > Time zone > Jerusalem" -ForegroundColor green -BackgroundColor black
Set-TimeZone -Id "Israel Standard Time"

Write-Host "(Optional) Add PC Password" -ForegroundColor green -BackgroundColor black
$PCPassword = read-host -Prompt "Enter PC Password (Leave Blank To Skip)"
if ($PCPassword) {
	Write-Host "PC Password Changed To $PCPassword" -ForegroundColor green -BackgroundColor black
	Set-LocalUser -Name $env:username -Password (ConvertTo-SecureString -AsPlainText $PCPassword -Force)

	Write-Host "$PCPassword Added to HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon as DefaultPassword" -ForegroundColor green -BackgroundColor black
	New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'DefaultPassword' -Value $PCPassword -PropertyType String -Force -ea SilentlyContinue;

	Write-Host "Enabled AutoAdminLogon on HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -ForegroundColor green -BackgroundColor black
	New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoAdminLogon' -Value '1' -PropertyType String -Force -ea SilentlyContinue;
}