$password = Read-Host -AsSecureString "Enter new password"
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($password)
$EncodedText =[Convert]::ToBase64String($Bytes)
cls
Write-Host "New encrypted password is"
$EncodedText
Write-Host
Write-Host "Opening notepad and file, please change the entry in the file on line 14"
Start-Process notepad "$env:APPDATA/stopper.ps1"
Read-Host