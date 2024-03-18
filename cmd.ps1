# Settings > Personalization > Colors > Disable Transparency effects
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f

# Control Panel > Ease of Access Center > Make the computer easier to see > Remove background images (when available)
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 900712078091000000 /f

# Settings > Devices > Mouse > Additional Mouse Options > Pointer Options > Disable Enhance pointer precision
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d 0 /f

# Control Panel > Ease of Access Center > Make the computer easier to see > Turn off all unnecessary animations (when possible)
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f

# Settings > Personalization > Start > Don't show recently opened items in Jump Lists on Start or the taskbar and in File Explorer Quick Access
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f