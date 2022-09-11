$WorkingDir="$env:APPDATA\TempSCH\days\"
$TimerFile="$env:APPDATA\TempSCH\timer.config"
$year=Get-Date -UFormat "%Y"
$month=Get-Date -UFormat "%m"
$day=Get-Date -UFormat "%d"
$filename=$day+"_"+$month+"_"+$year
$unix=[int][double]::Parse((Get-Date -UFormat %s))
$fullPath=$WorkingDir+$filename+".t"
$timerstart=$WorkingDir+$filename+".ft"
$allowedTimeMinutes=Get-Content -Path $TimerFile

if (-not(Test-Path -Path $fullPath -PathType Leaf)) {
     New-Item -ItemType File -Path $fullPath -Force -ErrorAction Stop
	 $unix | Out-File -FilePath $timerstart
	 1 | Out-File -FilePath $fullPath
 }
 else {
     Write-Host "[$filename] already exists."
	 [int]$oldTime=Get-Content -Path $fullPath
	 if ($oldTime -ge $allowedTimeMinutes) {
		shutdown -s -t 50 -c "Time is up, computer will shutdown in 50 seconds"
	 }
	 else
	 {
		 [int]$calc=$oldTime+1
		 $calc | Out-File -FilePath $fullPath
	 }
 }