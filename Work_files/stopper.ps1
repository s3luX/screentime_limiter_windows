if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

$password = Read-Host -AsSecureString "Password"
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($password)
$EncodedText =[Convert]::ToBase64String($Bytes)
$TimerFile="$env:APPDATA\TempSCH\timer.config"
$Desktop=[Environment]::GetFolderPath("Desktop")

# If you want to change the app password, change the below entry with the newly encoded password you generated.
# Change encoded text within the " ", please inlcude the whole encrypted phrase including the = at the end.
if ($EncodedText -eq "UwB5AHMAdABlAG0ALgBTAGUAYwB1AHIAaQB0AHkALgBTAGUAYwB1AHIAZQBTAHQAcgBpAG4AZwA=") {
	
	Write-Host "Which option do you want to execute?"
	Write-Host "1. Stop pending shutdown action"
	Write-Host "2. Change allowed computer usage time"
	Write-Host "3. Remove application"
	$option = Read-Host "Option number"
	if ($option -eq 1) {
		shutdown -a
	}
	elseif ($option -eq 2) {
		[int]$allowedTime = Read-Host "How many minutes can the computer be used per day? eg. 30"
		$allowedTime | Out-File -FilePath $TimerFile
	}
	elseif ($option -eq 3) {
		Remove-Item -LiteralPath "$env:APPDATA/TempSCH" -Force -Recurse
		Remove-Item -LiteralPath "$env:APPDATA/stopper.ps1" -Force
		Remove-Item -LiteralPath "$Desktop/ScreenTime Config.bat" -Force
		Unregister-ScheduledTask -TaskName "ScreenTime" -Confirm:$False
	}
	else
	{
		Write-Host "Incorrect option selected, run application again"
		Start-Sleep -Seconds 3
	}
}
else {
	Write-Host "Incorrect password"
}
