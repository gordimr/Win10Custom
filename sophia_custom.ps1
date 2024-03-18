(Get-Content Sophia.ps1) -replace 'InitialActions -Warning', 'InitialActions' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'ThisPC -Show', '#ThisPC -Show' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace '# UserFolders -ThreeDObjects Hide -Desktop Hide -Documents Hide -Downloads Hide -Music Hide -Pictures Hide -Videos Hide', 'UserFolders -ThreeDObjects Hide -Desktop Hide -Documents Hide -Downloads Hide -Music Hide -Pictures Hide -Videos Hide' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'SecondsInSystemClock -Show', '#SecondsInSystemClock -Show' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'AeroShaking -Enable', '#AeroShaking -Enable' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace '# AeroShaking -Disable', 'AeroShaking -Disable' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'Cursors -Dark', '#Cursors -Dark' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'IPv6Component -Disable', '#IPv6Component -Disable' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'Set-UserShellFolderLocation -Root', '#Set-UserShellFolderLocation -Root' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'RecommendedTroubleshooting -Automatically', '#RecommendedTroubleshooting -Automatically' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'ThumbnailCacheRemoval -Disable', '#ThumbnailCacheRemoval -Disable' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'SaveRestartableApps -Enable', '#SaveRestartableApps -Enable' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'RKNBypass -Enable', '#RKNBypass -Enable' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'PinToStart -Tiles ControlPanel, DevicesPrinters', '#PinToStart -Tiles ControlPanel, DevicesPrinters' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace '# PinToStart -UnpinAll', 'PinToStart -UnpinAll' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'Set-AppGraphicsPerformance', '#Set-AppGraphicsPerformance' | Set-Content Sophia.ps1
Start-Sleep 2
(Get-Content Sophia.ps1) -replace 'RunAsDifferentUserContext -Show', '#RunAsDifferentUserContext -Show' | Set-Content Sophia.ps1
Start-Sleep 2
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
Start-Sleep 2
.\Sophia.ps1