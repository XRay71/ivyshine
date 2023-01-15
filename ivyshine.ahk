#NoTrayIcon
#WinActivateForce
#UseHook True
#Warn All, Off
#MaxThreads 255
#SingleInstance Ignore
#Include %A_ScriptDir%
#Include *i Settings\Basic Settings.ahk
#Requires AutoHotkey v2.0 32-bit

SetWinDelay(0)
Thread("NoTimers", True)
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
    If (WinExist("Settings"))
        WinClose("Settings")
}

;=====================================
; Check for updates
;=====================================
CurrentVersionID := "001"
CheckForUpdates()
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
            
            While (!WinExist("AutoHotkey Dash"))
                Sleep(10)
            
            WinClose("AutoHotkey Dash")
            
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
            FileDelete("AHK-Installer.exe")
            DirDelete("ivyshine-main")
            
            Response := MsgBox("You have successfully been updated to the newest version: v" CurrentVersionID "!", "Update success!")
            
            Run("ivyshine.ahk")
            ExitApp
        }
    }
}

;=====================================
; Initialising
;=====================================x
#Include *i lib\ahk\init\Globals.ahk
#Include *i lib\ahk\init\ini Functions.ahk

Try
{
    Globals["Constants"]
    UpdateIni("lib\temp.ini", Globals["Constants"])
    FileDelete("lib\temp.ini")
}
Catch Any
    MissingFilesError()

Try
{
    DirCreate("lib\init")
    For ini, Section in Globals
    {
        If (FileExist(Globals["Constants"]["ini FilePaths"][ini])) {
            ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
            UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        } Else
            UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        
        ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
    }
}
Catch Any
    UnableToCreateFileError()
;=====================================
; Check Monitor
;=====================================
EnsureGUIVisibility()
EnsureGUIVisibility() {
    Global Globals
    If (!Globals["GUI"]["Settings"]["GuiX"] && !Globals["GUI"]["Settings"]["GuiY"]) {
        Globals["GUI"]["Settings"]["GuiX"] := 0
        Globals["GUI"]["Settings"]["GuiY"] := 340
        Return
    }
    
    Loop(MonitorGetCount()) {
        MonitorGetWorkArea(A_Index, &CurrentMonitorLeft, &CurrentMonitorTop, &CurrentMonitorRight, &CurrentMonitorBottom)
        If (Globals["GUI"]["Settings"]["GuiX"] < CurrentMonitorLeft || Globals["GUI"]["Settings"]["GuiX"] + 550 > CurrentMonitorRight)
            Globals["GUI"]["Settings"]["GuiX"] := Globals["GUI"]["Settings"]["GuiX"] < CurrentMonitorLeft ? CurrentMonitorLeft : CurrentMonitorRight - 550
        If (Globals["GUI"]["Settings"]["GuiY"] < CurrentMonitorTop || Globals["GUI"]["Settings"]["GuiY"] + 350 > CurrentMonitorBottom)
            Globals["GUI"]["Settings"]["GuiY"] := Globals["GUI"]["Settings"]["GuiY"] < CurrentMonitorTop ? CurrentMonitorTop : CurrentMonitorBottom - 350
    }
}
;=====================================
; Run rbxfpsunlocker (modified)
; https://github.com/axstin/rbxfpsunlocker
;=====================================
#Include *i lib\rbxfpsunlocker\rbxfpsunlocker.ahk

Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] := ""
For Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process WHERE name like 'rbxfpsunlocker.exe%' ")
    Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] := Process.ExecutablePath
IniWrite(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], Globals["Constants"]["ini FilePaths"]["Settings"], "rbxfpsunlocker", "rbxfpsunlockerDirectory")
Try {
    If (Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"])
        RunFPSUnlocker(Globals["Settings"]["rbxfpsunlocker"]["FPS"])
} Catch Any
    MissingFilesError()
;=====================================
; Creating GUI
;=====================================
#Include *i lib\ahk\GUI\Gui.ahk

TrayMenu := A_TrayMenu
TrayMenu.Delete()
TrayMenu.Add()
TrayMenu.Add()
TrayMenu.Add()
TrayMenu.Add("Restore GUI", IvyshineGuiRestore, "P10")
TrayMenu.Default := "Restore GUI"
TrayMenu.Add()
TrayMenu.Add()
TrayMenu.Add()
TrayMenu.Add("Open Debug", OpenDebug)
OpenDebug(*) {
    ListLines
} 
TrayMenu.AddStandard()
TrayMenu.Delete("&Open")
TrayMenu.ClickCount := 1

A_IconTip := "Ivyshine"

;=====================================
; Main Functions
;=====================================

#Include *i lib\ahk\Main\Functions.ahk

Try
ReleaseAllKeys()
Catch Any
    MissingFilesError()

Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "T1 P0")
Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "T1 P0")
Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "T1 P0")
Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "T2 P1")
Hotkey("F5", IvyshineGuiMinimize, "T1 P10")
HotIfWinActive("ahk_id " IvyshineGui.Hwnd)
Hotkey("~LButton", StartMoveGui, "T1 P2")
Hotkey("~LButton Up", StopMoveGui, "T1 P3")
HotIfWinActive()

StartMacro(*) {
    MsgBox("Start")
    ReleaseAllKeys()
    Return
}

PauseMacro(*) {
    MsgBox("Pause")
    Return
}

StopMacro(*) {
    MsgBox("Stop")
    Return
}

ReloadMacro() {
    Global Globals, IvyshineGui
    RestoreFPSUnlocker()
    WinGetPos(&GuiX, &GuiY,,, IvyshineGui.Hwnd)
    Globals["GUI"]["Settings"]["GuiX"] := GuiX
    Globals["GUI"]["Settings"]["GuiY"] := GuiY
    For ini, Section in Globals
    {
        If (ini == "Constants")
            Continue
        UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
    }
    Sleep(100)
    Reload
}

;=====================================
; Errors
;=====================================
MissingFilesError() {
    MsgBox("It appears that some files are missing!`r`nPlease ensure that you have not moved any files.`r`nThis script will now exit.", "Error: file not found!", "OK Icon!")
    ExitApp
}

UnableToCreateFileError() {
    MsgBox("The macro was unable to create needed files!`r`nPlease ensure that the script has enough permissions to do so.`r`nYou may need to run the script as admin.`r`nThis script will now exit.", "Error: file not found!", "OK Icon!")
    ExitApp
}

]::ReloadMacro()
Hotkey("]",, "P20")