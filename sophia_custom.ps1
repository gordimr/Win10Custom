(Get-Content Sophia.ps1) -replace 'InitialActions -Warning', 'InitialActions' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'ThisPC -Show', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace '# UserFolders -ThreeDObjects Hide -Desktop Hide -Documents Hide -Downloads Hide -Music Hide -Pictures Hide -Videos Hide', 'UserFolders -ThreeDObjects Hide -Desktop Hide -Documents Hide -Downloads Hide -Music Hide -Pictures Hide -Videos Hide' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'SecondsInSystemClock -Show', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'AeroShaking -Enable', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace '# AeroShaking -Disable', 'AeroShaking -Disable' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'Cursors -Dark', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'IPv6Component -Disable', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'Set-UserShellFolderLocation -Root', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'RecommendedTroubleshooting -Automatically', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'ThumbnailCacheRemoval -Disable', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'SaveRestartableApps -Enable', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'RKNBypass -Enable', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'PinToStart -Tiles ControlPanel, DevicesPrinters', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace '# PinToStart -UnpinAll -Tiles ControlPanel, DevicesPrinters', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace '# PinToStart -UnpinAll', 'PinToStart -UnpinAll' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'Set-AppGraphicsPerformance', '#' | Set-Content Sophia.ps1
(Get-Content Sophia.ps1) -replace 'RunAsDifferentUserContext -Show', '#' | Set-Content Sophia.ps1
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\Sophia.ps1