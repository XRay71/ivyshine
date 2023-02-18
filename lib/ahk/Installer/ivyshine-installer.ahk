#NoTrayIcon
#Requires AutoHotkey v2.0 32-bit ; this script is written in v2 syntax

SetWorkingDir(A_ScriptDir) ; sets working directory to be itself

If (!A_IsAdmin) {
    Try {
        Run("*RunAs " A_ScriptFullPath " /restart")
        ExitApp
    }
}

Try
Download("https://www.autohotkey.com/download/ahk-v2.exe", "AHK-Installer.exe")
Catch Any {
    MsgBox("Something went wrong while installing!`r`nNothing has been changed.", "Error!", "OK Iconx")
    If (FileExist("AHK-Installer.exe"))
        FileDelete("AHK-Installer.exe")
    Return
}

While (!FileExist("AHK-Installer.exe"))
    Sleep(10)

RunWait("*RunAs AHK-Installer.exe")

; Run("*RunAs AHK-Installer.exe")
; While (!WinExist("AutoHotkey Setup"))
;     Sleep(10)

; SendInput("{Enter}")

While (!WinExist("AutoHotkey Dash"))
    Sleep(10)

WinClose("AutoHotkey Dash")

Try
Download("https://github.com/XRay71/ivyshine/archive/main.zip", "NewVersion.zip")
Catch Any {
    MsgBox("Something went wrong while installing!`r`nNothing has been changed.", "Error!", "OK Iconx")
    If (FileExist("NewVersion.zip"))
        FileDelete("NewVersion.zip")
    Return
}

PowerShell := ComObject("Shell.Application")
PowerShell.Namespace(A_WorkingDir).CopyHere(PowerShell.Namespace(A_WorkingDir "\NewVersion.zip").items, 4|16)
DirCreate("ivyshine")
PowerShell.Namespace(A_WorkingDir "\ivyshine").MoveHere(PowerShell.Namespace(A_WorkingDir "\ivyshine-main").items, 4|16)
FileDelete("NewVersion.zip")
FileDelete("AHK-Installer.exe")
DirDelete("ivyshine-main")

Run("ivyshine\ivyshine.ahk")
FileAppend(
    (
        "@echo off"
        "dir " A_ScriptDir " /b /s`r`n"
        "del " A_ScriptFullPath "`r`n"
        "del /s " A_ScriptDir "\ivyshine-temp-deleter.bat 1>nul"
    ), "ivyshine-temp-deleter.bat"
)

While(!FileExist("ivyshine-temp-deleter.bat"))
    Sleep(10)

Run("ivyshine-temp-deleter.bat",, "Hide")

ExitApp