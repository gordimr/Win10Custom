Write-Host "Arkenfox" -ForegroundColor green -BackgroundColor black
$CurrentFireFoxProfilePath = Get-Location
Invoke-WebRequest -Uri https://raw.githubusercontent.com/gordimr/FFoverrides/main/overrides.js -OutFile $CurrentFireFoxProfilePath\user-overrides.js
Invoke-WebRequest -Uri https://raw.githubusercontent.com/arkenfox/user.js/master/updater.bat -OutFile $CurrentFireFoxProfilePath\updater.bat
Invoke-WebRequest -Uri https://raw.githubusercontent.com/arkenfox/user.js/master/prefsCleaner.bat -OutFile $CurrentFireFoxProfilePath\prefsCleaner.bat
Invoke-WebRequest -Uri https://raw.githubusercontent.com/arkenfox/user.js/master/user.js -OutFile $CurrentFireFoxProfilePath\user.js

$taskName1 = "Arkenfox Update"
$taskExists1 = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName1 }
if($taskExists1) {
}
else{
	Write-Host "Arkenfox updater.bat Added To Task Scheduler" -ForegroundColor green -BackgroundColor black
	$action1 = New-ScheduledTaskAction -Execute "$CurrentFireFoxProfilePath\updater.bat" -Argument "-unattended -updatebatch"
	$trigger1 = New-ScheduledTaskTrigger -AtLogon
	$settings1 = New-ScheduledTaskSettingsSet
	$task1 = New-ScheduledTask -Action $action1 -Trigger $trigger1
	Register-ScheduledTask $taskName1 -InputObject $task1
}

$taskName2 = "Arkenfox Clean"
$taskExists2 = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName2 }
if($taskExists2) {
}
else{
	Write-Host "Arkenfox prefsCleaner.bat Added To Task Scheduler" -ForegroundColor green -BackgroundColor black
	$action2 = New-ScheduledTaskAction -Execute "$CurrentFireFoxProfilePath\prefsCleaner.bat" -Argument "-unattended"
	$trigger2 = New-ScheduledTaskTrigger -AtLogon
	$task2 = New-ScheduledTask -Action $action2 -Trigger $trigger2
	Register-ScheduledTask $taskName2 -InputObject $task2
}

$taskName3 = "Arkenfox Overrides"
$taskExists3 = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName3 }
if($taskExists3) {
}
else{
	Write-Host "Arkenfox user-overrides.js Added To Task Scheduler" -ForegroundColor green -BackgroundColor black
	$action3 = New-ScheduledTaskAction -Execute "powershell" -Argument "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/gordimr/FFoverrides/main/overrides.js' -OutFile '$CurrentFireFoxProfilePath\user-overrides.js'"
	$trigger3 = New-ScheduledTaskTrigger -AtLogon
	$task3 = New-ScheduledTask -Action $action3 -Trigger $trigger3
	Register-ScheduledTask $taskName3 -InputObject $task3
}