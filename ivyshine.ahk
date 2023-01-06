#NoTrayIcon
#WinActivateForce ; skips "gentle" window activation
#UseHook True ; prevents hotkeys from being triggered by send commands
#MaxThreads 255
#SingleInstance Force
#Include "%A_ScriptDir%"
#Requires AutoHotkey v2.0 32-bit ; this script is written in v2 syntax

SetWorkingDir(A_ScriptDir) ; sets working directory to be itself
CoordMode("Pixel", "Client") ; measured via the working area of the screen
CoordMode("Mouse", "Client")

;=====================================
; Check for updates
;=====================================
CurrentVersionID := "001"
CheckForUpdates()
CheckForUpdates() {
    WinHttpRequest := ComObject("WinHttp.WinHttpRequest.5.1")
    WinHttpRequest.Open("GET", "https://raw.githubusercontent.com/XRay71/ivyshine-macro-old/main/version.txt", true)
    WinHttpRequest.Send()
    WinHttpRequest.WaitForResponse()
    NewVersionID := RegExReplace(Trim(WinHttpRequest.ResponseText), "\.? *(\n|\r)+")
    
    if (IsNumber(NewVersionID) && CurrentVersionID == NewVersionID) {
        if (!A_IsAdmin)
            Update := MsgBox("You are currently running version v" CurrentVersionID ".`r`nWould you like to install the newest version: v" NewVersionID "?"
                , "New version found!"
                , "YesNo Icon!")
        else
            Update := True
        
        if (Update) {
            if (!A_IsAdmin) {
                try {
                    Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
                    ExitApp
                }
            }
            
            Try {
                Download("https://github.com/XRay71/ivyshine-macro/archive/main.zip", "NewVersion.zip")
            } Catch Any {
                MsgBox("Something went wrong while downloading the update!`r`nNothing has been changed.", "Error!", "OK Iconx")
                if (FileExist("NewVersion.zip"))
                    FileDelete("NewVersion.zip")
                Return
            }
            
            PowerShell := ComObject("Shell.Application")
            PowerShell.Namespace(A_WorkingDir).CopyHere(PowerShell.Namespace(A_WorkingDir "\NewVersion.zip").items, 4|16)
            PowerShell.Namespace(A_WorkingDir).MoveHere(PowerShell.Namespace(A_WorkingDir "\ivyshine-main").items, 4|16)
            DirDelete("ivyshine-main")
            
            Run("ivyshine.ahk")
            ExitApp
        }
    }
    
    if (FileExist("version.txt")) {
        FileDelete("version.txt")
        MsgBox("You have successfully been updated to the newest version: v" CurrentVersionID "!", "Update success!")
    }
}