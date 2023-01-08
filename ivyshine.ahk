#NoTrayIcon
#WinActivateForce
#UseHook True
#Warn All, Off
#MaxThreads 255
#SingleInstance Force
#Include "%A_ScriptDir%"
#Requires AutoHotkey v2.0 32-bit

SetWorkingDir(A_ScriptDir)
CoordMode("Pixel", "Client")
CoordMode("Mouse", "Client")

;=====================================
; Check Resolution
;=====================================
; CheckResolution()
CheckResolution() {
    If (A_ScreenDPI != 96 || A_ScreenWidth != 1280 || A_ScreenHeight != 720) {
        CurrentScaling := Floor(A_ScreenDPI / 96 * 100)
        MsgBox("The images taken for this macro were created for 1280x720p resolution on 100`% scaling.`r`nYou are currently on " A_ScreenWidth "x" A_ScreenHeight "p with " CurrentScaling "`% scaling.`r`nThe Windows display settings tab will now be opened.`r`nPlease change the resolution to be correct.", "Warning!", "OK Iconx")
        Run("ms-settings:display")
        DoReload := MsgBox("Press `"OK`" when you have changed your resolution to 1280x720p with 100`% scaling. Press `"Cancel`" to continue regardless.",, "OKCancel Iconx")
        If (DoReload == "OK")
            Reload
    }
    
    WinClose("Settings")
}

;=====================================
; Check for updates
;=====================================
CurrentVersionID := "001"
; CheckForUpdates()
CheckForUpdates() {
    WinHttpRequest := ComObject("WinHttp.WinHttpRequest.5.1")
    WinHttpRequest.Open("GET", "https://raw.githubusercontent.com/XRay71/ivyshine/main/version.txt", true)
    WinHttpRequest.Send()
    WinHttpRequest.WaitForResponse()
    NewVersionID := RegExReplace(Trim(WinHttpRequest.ResponseText), "\.? *(\n|\r)+")
    
    If (IsNumber(NewVersionID) && CurrentVersionID != NewVersionID) {
        If (!A_IsAdmin)
            Update := MsgBox("You are currently running version v" CurrentVersionID ".`r`nWould you like to install the newest version: v" NewVersionID "?"
                , "New version found!"
                , "YesNo Icon!")
        Else
            Update := True
        
        If (Update != "No") {
            If (!A_IsAdmin) {
                Try {
                    Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
                    ExitApp
                }
            }
            
            Try {
                Download("https://github.com/XRay71/ivyshine/archive/main.zip", "NewVersion.zip")
            } Catch Any {
                MsgBox("Something went wrong while downloading the update!`r`nNothing has been changed.", "Error!", "OK Iconx")
                If (FileExist("NewVersion.zip"))
                    FileDelete("NewVersion.zip")
                Return
            }
            
            PowerShell := ComObject("Shell.Application")
            PowerShell.Namespace(A_WorkingDir).CopyHere(PowerShell.Namespace(A_WorkingDir "\NewVersion.zip").items, 4|16)
            PowerShell.Namespace(A_WorkingDir).MoveHere(PowerShell.Namespace(A_WorkingDir "\ivyshine-main").items, 4|16)
            FileDelete("NewVersion.zip")
            DirDelete("ivyshine-main")
            
            MsgBox("You have successfully been updated to the newest version: v" CurrentVersionID "!", "Update success!")
            
            Run("ivyshine.ahk")
            ExitApp
        }
    }
}

;=====================================
; Initialising
;=====================================x
#Include "*i lib\ahk\init\globals.ahk"
#Include "*i lib\ahk\init\inifunctions.ahk"

Try
{
    Globals["Constants"]
    CreateIni("lib\boo.ini", Globals["Constants"])
    FileDelete("lib\boo.ini")
}
Catch Any
    MissingFilesError()

Try
{
    DirCreate("lib\init")
    For ini, Section in Globals
    {
        If (FileExist(Globals["Constants"]["Ini FilePaths"][ini])) {
            ReadIni(Globals["Constants"]["Ini FilePaths"][ini], Globals[ini])
            UpdateIni(Globals["Constants"]["Ini FilePaths"][ini], Globals[ini])
        } Else
            CreateIni(Globals["Constants"]["Ini FilePaths"][ini], Globals[ini])
    }
}
Catch Any
    UnableToCreateFileError()

MissingFilesError() {
    MsgBox("It appears that some files are missing!`r`nPlease ensure that you have not moved any files.`r`nThis script will now exit.", "Error: file not found!", "OK Icon!")
    ExitApp
}

UnableToCreateFileError() {
    MsgBox("The macro was unable to create needed files!`r`nPlease ensure that the script has enough permissions to do so.`r`nYou may need to run the script as admin.`r`nThis script will now exit.", "Error: file not found!", "OK Icon!")
    ExitApp
}