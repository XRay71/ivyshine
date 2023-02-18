#NoTrayIcon
#UseHook True
#Warn All, Off
#MaxThreads 255
#SingleInstance Ignore
#Include %A_ScriptDir%
#Requires AutoHotkey v2.0 32-bit

Critical("Off")

SetRegView(32)
SetWinDelay(0)
SetMouseDelay(0)
SetKeyDelay(0, -1)
SetControlDelay(0)
SetDefaultMouseSpeed(0)
SetWorkingDir(A_ScriptDir)
SetTitleMatchMode(3)
SetTitleMatchMode("Fast")

ProcessSetPriority("A")
DetectHiddenText(0)
DetectHiddenWindows(0)
Thread("Priority", 0)
Thread("NoTimers", True)

SendMode("Input")
CoordMode("Pixel", "Client")
CoordMode("Mouse", "Client")

;=====================================
; Check Resolution
;=====================================

; CheckResolution()
CheckResolution() {
    If (A_ScreenDPI != 96 || A_ScreenWidth != 1280 || A_ScreenHeight != 720) {
        MsgBox("The images taken for this macro were created for 1280x720p resolution on 100`% scaling.`r`nYou are currently on " A_ScreenWidth "x" A_ScreenHeight "p with " Floor(A_ScreenDPI / 96 * 100) "`% scaling.`r`nThe Windows display settings tab will now be opened.`r`nPlease change the resolution to be correct."
            , "Warning: incorrect resolution!"
            , "OK Iconx")
        
        Run("ms-settings:display")
        
        DoReload := MsgBox("Press `"OK`" when you have changed your resolution to 1280x720p with 100`% scaling. Press `"Cancel`" to continue regardless."
            ,
            , "OKCancel Iconx")
        
        If (DoReload == "OK")
            Reload
    }
    
    If (WinExist("Settings"))
        WinClose()
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
    
    If (NewVersionID && IsNumber(NewVersionID) && (CurrentVersionID != NewVersionID)) {
        Update := (FileExist(A_Temp "\update-ivyshine.txt") ? "Yes" : MsgBox("You are currently running version v" CurrentVersionID ".`r`nWould you like to install version v" NewVersionID "?"
            , "New version found!"
            , "YesNo Icon!"))
        
        If (Update != "No" || FileExist(A_Temp "\update-ivyshine.txt")) {
            FileAppend("boo", A_Temp "\update-ivyshine.txt")
            If (!A_IsAdmin) {
                Try {
                    Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
                    ExitApp
                }
            }
            If (FileExist(A_Temp "\update-ivyshine.txt"))
                FileDelete(A_Temp "\update-ivyshine.txt")
            
            If (FileExist((A_ScriptDir "\lib\ahk\Installer\ivyshine-installer.exe")))
                FileMove(A_ScriptDir "\lib\ahk\Installer\ivyshine-installer.exe", "..\ivyshine-installer.exe", 1)
            Else {
                Try
                Download("https://github.com/XRay71/ivyshine/raw/main/lib/ahk/Installer/ivyshine-installer.exe", "..\ivyshine-installer.exe")
                Catch Any {
                    MsgBox("Something went wrong while installing!`r`nNothing has been changed.", "Error!", "OK Iconx")
                    Try
                    FileDelete("..\ivyshine-installer.exe")
                    Return
                }
            }
            
            Loop
                Sleep(10)
            Until (FileExist("..\ivyshine-installer.exe"))
            
            Run("*RunAs ..\ivyshine-installer.exe")
            
            ExitApp
        }
    }
}

;=====================================
; Initialising
;=====================================

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
    For ini in Globals
    {
        If (FileExist(Globals["Constants"]["ini FilePaths"][ini]))
            ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        Else
            UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        
        ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
    }
}
Catch Any {
    If (A_IsAdmin)
        UnableToCreateFileError()
    Else
        Try {
        Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
        ExitApp
    }
}

;=====================================
; Check Monitor
;=====================================

EnsureGUIVisibility()
EnsureGUIVisibility() {
    If (!Globals["GUI"]["Position"]["GUIX"] && !Globals["GUI"]["Position"]["GUIY"]) {
        Globals["GUI"]["Position"]["GUIX"] := 0
        Globals["GUI"]["Position"]["GUIY"] := 350
        Return
    }
    
    Loop(MonitorGetCount()) {
        MonitorGetWorkArea(A_Index, &CurrentMonitorLeft, &CurrentMonitorTop, &CurrentMonitorRight, &CurrentMonitorBottom)
        If (Globals["GUI"]["Position"]["GUIX"] < CurrentMonitorLeft || Globals["GUI"]["Position"]["GUIX"] + 550 > CurrentMonitorRight)
            Globals["GUI"]["Position"]["GUIX"] := Globals["GUI"]["Position"]["GUIX"] < CurrentMonitorLeft ? CurrentMonitorLeft : CurrentMonitorRight - 550
        If (Globals["GUI"]["Position"]["GUIY"] < CurrentMonitorTop || Globals["GUI"]["Position"]["GUIY"] + 350 > CurrentMonitorBottom)
            Globals["GUI"]["Position"]["GUIY"] := Globals["GUI"]["Position"]["GUIY"] < CurrentMonitorTop ? CurrentMonitorTop : CurrentMonitorBottom - 350
    }
}

;=====================================
; Run rbxfpsunlocker (modified)
; https://github.com/axstin/rbxfpsunlocker
;=====================================

#Include *i lib\rbxfpsunlocker\rbxfpsunlocker.ahk

Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] := ""
If (rbxfpsunlockerPID := ProcessExist("rbxfpsunlocker.exe"))
    Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] := ProcessGetPath(rbxfpsunlockerPID)
IniWrite(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], Globals["Constants"]["ini FilePaths"]["Settings"], "rbxfpsunlocker", "rbxfpsunlockerDirectory")
Try {
    CloseFPSUnlocker()
    If (Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"])
        RunFPSUnlocker(Globals["Settings"]["rbxfpsunlocker"]["FPS"])
} Catch Any
    MissingFilesError()

;=====================================
; Creating GUI
;=====================================

#Include *i lib\ahk\GUI\Gui.ahk

WinActivate(IvyshineGui)

;=====================================
; Tray Menu
;=====================================

TrayMenu := A_TrayMenu
TrayMenu.Delete()
Loop(3)
    TrayMenu.Add()
TrayMenu.Add("Restore GUI (F5)", IvyshineGuiRestore, "P10")
TrayMenu.Default := "Restore GUI (F5)"
Loop(3)
    TrayMenu.Add()
TrayMenu.Add("Open Logs (^F2)", OpenDebug)
OpenDebug(*) {
    ListLines
}
TrayMenu.Add()
TrayMenu.Add("Suspend Hotkeys (^F3)", SuspendHotkeys)
SuspendHotkeys(*){
    Suspend(-1)
    TrayMenu.Rename("10&", (A_IsSuspended ? "Unsuspend Hotkeys (^F3)" : "Suspend Hotkeys (^F3)"))
}
TrayMenu.Add()
TrayMenu.Add("Start Macro (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")", StartMacro)
TrayMenu.Add("Pause Macro (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")", PauseMacro)
TrayMenu.Add("Stop Macro (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")", StopMacro)
TrayMenu.Add()
TrayMenu.ClickCount := 1

A_IconTip := "Ivyshine"

;=====================================
; Hotkeys
;=====================================

Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "T1 P0 S0")
Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "T1 P0 S0")
Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "T1 P20 S0")

Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "T2 P1 S0")

Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGuiMinimize, "T1 P10 S")

HotIfWinActive("ahk_id " IvyshineGui.Hwnd)

Hotkey("~LButton", StartMoveGui, "T1 P2 S")
Hotkey("~LButton Up", StopMoveGui, "T1 P3 S")

HotIfWinActive()

Hotkey(Globals["Settings"]["Hotkeys"]["DebugHotkey"], OpenDebug, "T1 P10 S")
Hotkey(Globals["Settings"]["Hotkeys"]["SuspendHotkey"], SuspendHotkeys, "T1 P10 S")

;=====================================
; Main Functions
;=====================================

OnExit(ExitMacro)

#Include *i lib\ahk\Main\Functions.ahk
#Include *i lib\ahk\Libraries\Gdip_All.ahk

Try {
    ReleaseAllKeys()
} Catch Any
    MissingFilesError()

StartMacro(*) {
    ReleaseAllKeys()
    MacroInfoGuiClose()
    MsgBox("Start")
    Return
}

PauseMacro(*) {
    MsgBox("Pause")
    Return
}

StopMacro(*) {
    MsgBox("Stop")
    ReloadMacro()
}

ReloadMacro(*) {
    RestoreFPSUnlocker()
    If (IvyshineGui) {
        If (!A_IconHidden)
            IvyshineGuiRestore()
        
        If (DirExist("lib\init")) {
            DetectHiddenWindows(1)
            WinGetPos(&GuiX, &GuiY,,, IvyshineGui)
            Globals["GUI"]["Position"]["GUIX"] := GuiX
            Globals["GUI"]["Position"]["GUIY"] := GuiY
            For ini, Section in Globals
                UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        }
    }
    HyperSleep(25)
    Reload
}

ExitMacro(*) {
    RestoreFPSUnlocker()
    If (IvyshineGui) {
        If (!A_IconHidden)
            IvyshineGuiRestore()
        
        If (DirExist("lib\init")) {
            DetectHiddenWindows(1)
            WinGetPos(&GuiX, &GuiY,,, IvyshineGui)
            Globals["GUI"]["Position"]["GUIX"] := GuiX
            Globals["GUI"]["Position"]["GUIY"] := GuiY
            For ini, Section in Globals
                UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        }
    }
    HyperSleep(25)
    ExitApp
}

;=====================================
; Errors
;=====================================

MissingFilesError() {
    MsgBox("It appears that some files are missing!`r`nPlease ensure that you have not moved any files.`r`nThis script will now exit."
        , "Error: file not found!"
        , "OK Icon!")
    ExitApp
}

UnableToCreateFileError() {
    MsgBox("The macro was unable to create needed files!`r`nPlease ensure that the script has enough permissions to do so.`r`nYou may need to run the script as admin.`r`nThis script will now exit."
        , "Error: file not found!"
        , "OK Icon!")
    ExitApp
}

]::ReloadMacro()
Hotkey("]",, "P20")
