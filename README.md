# screentime_limiter_windows
A simple script designed to limit the usage of Windows computers for children to x amount of minutes (hours)

This script was created on a request from a friend, and with 2 beers in hand and an hour of time, the repo is the child.

The "application" is a very simple utilization of built-in features of Windows and PowerShell, it does not need any libraries and is not dependent on anything other than PowerShell.

The scripts were not set in mind to fully hide from the users of the computer, note that the app is designed in mind that the computer is used by kids who are spending too much time on the computer. It is aimed to help the parents control the time their children spend on the computer.

I created the app as I was researching the available apps on the web to perform a simple function of limiting the time on the computer, but could not find any app doing only that. Note that this app does not filter any bad words or websites kids would visit, it was not the goal. The goal that this app aims to achieve is simply limit the screen time the child spends.

# Installation

The installation is simple and can be done in 3 steps:
1. Download the *installer.ps1* script from the repo
2. Start PowerShell with elevated privileges and run the command `Set-ExecutionPolicy Bypass` and answer with "Y"
3. Right-click the installer.ps1 script and select "Run with PowerShell"

The password for the app is "**ParentLozinka1**", if you want to change it use the *pass_change.ps1* script (right click and "Run in PowerShell") and follow the instructions.
