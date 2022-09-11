$WorkingDir="$env:APPDATA\TempSCH"
$TimerFile="$env:APPDATA\TempSCH\timer.config"
$Desktop=[Environment]::GetFolderPath("Desktop")
$FullPath=$WorkingDir+"\runner.ps1"
New-Item -ItemType Directory -Force -Path $WorkingDir\days

wget "https://raw.githubusercontent.com/s3luX/screentime_limiter_windows/main/Work_files/runner.ps1" -outfile "$WorkingDir/runner.ps1"
wget "https://raw.githubusercontent.com/s3luX/screentime_limiter_windows/main/Work_files/stopper.ps1" -outfile "$env:APPDATA/stopper.ps1"
wget "https://raw.githubusercontent.com/s3luX/screentime_limiter_windows/main/Work_files/stopper.bat" -outfile "$Desktop/ScreenTime Config.bat"

[int]$allowedTime = Read-Host "How many minutes can the computer be used per day? eg. 30"
$allowedTime | Out-File -FilePath $TimerFile

$username = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$userPass = Read-Host "Enter password for the current user"

$Argument = "-WindowStyle hidden -NonInteractive -NoLogo -NoProfile -File "+$FullPath
$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $Argument
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)
$Settings = New-ScheduledTaskSettingsSet
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
Register-ScheduledTask -TaskName 'ScreenTime' -InputObject $Task -User $username -Password $userPass
