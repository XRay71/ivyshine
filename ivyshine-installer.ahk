#NoTrayIcon
#WinActivateForce ; skips "gentle" window activation
#UseHook True ; prevents hotkeys from being triggered by send commands
#SingleInstance Force
#Include "%A_ScriptDir%"
#Requires AutoHotkey v2.0 32-bit ; this script is written in v2 syntax

SetWorkingDir(A_ScriptDir) ; sets working directory to be itself

if (!A_IsAdmin) {
    try {
        Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
        ExitApp
    }
}

Try {
    Download("https://github.com/XRay71/ivyshine/archive/main.zip", "NewVersion.zip")
} Catch Any {
    MsgBox("Something went wrong while downloading the update!`r`nNothing has been changed.", "Error!", "OK Iconx")
    if (FileExist("NewVersion.zip"))
        FileDelete("NewVersion.zip")
    Return
}

PowerShell := ComObject("Shell.Application")
PowerShell.Namespace(A_WorkingDir).CopyHere(PowerShell.Namespace(A_WorkingDir "\NewVersion.zip").items, 4|16)
FileDelete("NewVersion.zip")
FileDelete("ivyshine_installer.ahk")
DirMove("ivyshine-main", "ivyshine-macro", "R")

Run("ivyshine-macro\ivyshine.ahk")
ExitApp