;=====================================
; IVYSHINE MACRO
;=====================================
; Created by XRay71 (Raychel#2101)
; Special thanks to the Natro Dev Team
; License: GNU GPL v3+
;=====================================

#NoTrayIcon ; no tray icon when GUI is visible
#UseHook True ; make it so that movements don't trigger hotkeys
#Warn All, Off ; remove warnings
#MaxThreads 255 ; allows more multi-threading
#SingleInstance Force ; force replace with new instance
#Include %A_ScriptDir% ; sets current #Include to the working directory
#Requires AutoHotkey v2.0 32-bit ; requires AHK v2.0+, 32-bit for stability
Critical("Off") ; makes threads interruptible by default

SetRegView(32) ; removes complexity in registry reads
SetWinDelay(0) ; shortest possible delay after windows actions
SetMouseDelay(-1) ; no mouse delay
SetKeyDelay(-1, -1) ; no key delay for when SendInput fails
SetControlDelay(0) ; no control delay
SetDefaultMouseSpeed(0) ; instant movement
SetWorkingDir(A_ScriptDir) ; sets working directory, just in case
SetTitleMatchMode(3) ; exact match
SetTitleMatchMode("Fast") ; default behaviour

ProcessSetPriority("A") ; makes the macro important to the computer
DetectHiddenText(0) ; does not check for hidden text
DetectHiddenWindows(0) ; does not check for hidden windows
Thread("Priority", 0) ; sets default thread priority
Thread("NoTimers", True) ; makes it so that timers don't interrupt threads
KeyHistory(0) ; no key logging

SendMode("Input") ; by default use SendInput
CoordMode("Pixel", "Client") ; by default exclude title bar, etc. from image checks
CoordMode("Mouse", "Client") ; by default exclude title bar, etc. from mouse movements

;=====================================
; CHECK RESOLUTION
;=====================================

; CheckResolution() ; called at the very start to make sure that the scaling is 100%
CheckResolution() {
    If (A_ScreenDPI != 96) { ; 96 = 100%
        MsgBox(
            (
            "You need to be on 100`% screen scaling for this macro to work!
            You are currently at " Floor(A_ScreenDPI / 96 * 100) "`% scaling.
            The Windows display settings tab will now be opened.
            Please change the scaling to be correct."
            )
            , "Warning: incorrect resolution!"
            , "OK Iconx")
        
        Run("ms-settings:display") ; opens Windows displays settings
        
        DoReload := MsgBox(
            (
            "Press `"OK`" when you have changed your scaling to 100`%.
            Press `"Cancel`" to continue regardless."
            )
            ,
            , "OKCancel Iconx")
        
        If (DoReload == "OK")
            Reload
    }
    
    If (WinExist("Settings"))
        WinClose()
}

;=====================================
; CHECK UPDATES
;=====================================

CurrentVersionID := "001"
; CheckForUpdates()
CheckForUpdates() {
    Try {
        WinHttpRequest := ComObject("WinHttp.WinHttpRequest.5.1") ; opens a winhttps request
        WinHttpRequest.Open("GET", "https://raw.githubusercontent.com/XRay71/ivyshine/main/version.txt", true) ; sends a GET request to the github version file
        WinHttpRequest.Send() ; sends the request
        WinHttpRequest.WaitForResponse() ; waits for response
        NewVersionID := RegExReplace(Trim(WinHttpRequest.ResponseText), "\.? *(\n|\r)+") ; trims all whitespace from the version file
    } Catch Any
        Return -1
    
    If (NewVersionID && IsNumber(NewVersionID) && (CurrentVersionID != NewVersionID)) { ; checks if the request was successful, checks if it's a number, and checks if it's different from the current version
        Update := (FileExist(A_Temp "\update-ivyshine.txt") ? "Yes" : ; checks if the update flag is there, otherwise prompts the user
        MsgBox(
            (
            "You are currently running version v" CurrentVersionID ".
            Would you like to install version v" NewVersionID "?"
            )
            , "New version found!"
            , "YesNo Icon!"))
        
        If (Update != "No") {
            FileAppend("boo", A_Temp "\update-ivyshine.txt") ; creates update flag
            If (!A_IsAdmin) { ; restarts as admin
                Try {
                    Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
                    ExitApp
                }
            }
            
            If (FileExist(A_ScriptDir "\lib\ahk\Installer\ivyshine-installer.exe")) ; checks if the installer is already present
                FileMove(A_ScriptDir "\lib\ahk\Installer\ivyshine-installer.exe", "..\ivyshine-installer.exe", 1) ; moves it
            Else {
                Try ; otherwise download the installer in that place
                Download("https://github.com/XRay71/ivyshine/raw/main/lib/ahk/Installer/ivyshine-installer.exe", "..\ivyshine-installer.exe")
                Catch Any {
                    MsgBox(
                        (
                        "Something went wrong while installing!
                        Nothing has been changed."
                        )
                        , "Error!"
                        , "OK Iconx")
                    Try
                    FileDelete("..\ivyshine-installer.exe") ; delete it if anything goes wrong
                    Return
                }
            }
            
            Loop
                Sleep(10) ; continually check until the file finishes downloading
            Until (FileExist("..\ivyshine-installer.exe"))
            
            Run("*RunAs ..\ivyshine-installer.exe") ; run the installer
            
            If (FileExist(A_Temp "\update-ivyshine.txt"))
                FileDelete(A_Temp "\update-ivyshine.txt") ; deletes update flag
            
            ExitApp
        }
    }
}

;=====================================
; INITIALISE VARIABLES
;=====================================

#Include *i lib\ahk\init\Globals.ahk ; global variable file - Globals[][][] map
#Include *i lib\ahk\init\ini Functions.ahk ; ini file functions - UpdateIni(Path, Data[][]) and ReadIni(Path, Data[][])

Try { ; double checks the functions, if error then the files did not include properly
    Globals["Constants"]
    UpdateIni("lib\temp.ini", Globals["Constants"])
    FileDelete("lib\temp.ini")
} Catch Any
    MissingFilesError()

Try { ; loads all of the ini data into the Globals[] variable
    DirCreate("lib\init")
    For ini in Globals {
        If (FileExist(Globals["Constants"]["ini FilePaths"][ini])) ; if the file already exists, read from it
            ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        Else ; otherwise create it
            UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        
        ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini]) ; read it once more for good measure
    }
} Catch Any {
    If (A_IsAdmin) ; if you're already running it as admin, good luck
        UnableToCreateFileError()
    Else { ; otherwise, try running it as admin :D
        Try {
            Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
            ExitApp
        }
    }
}

;=====================================
; CHECK VISIBILITY
;=====================================

EnsureGUIVisibility() ; run at the start to make sure the GUI is still on the screen
EnsureGUIVisibility() {
    If (!Globals["GUI"]["Position"]["GUIX"] && !Globals["GUI"]["Position"]["GUIY"]) { ; if the positions are not defined, define them
        Globals["GUI"]["Position"]["GUIX"] := 5
        Globals["GUI"]["Position"]["GUIY"] := 5
        Return
    }
    
    Loop(MonitorGetCount()) { ; checks every monitor to make sure everything is fine
        MonitorGetWorkArea(A_Index, &CurrentMonitorLeft, &CurrentMonitorTop, &CurrentMonitorRight, &CurrentMonitorBottom)
        If (Globals["GUI"]["Position"]["GUIX"] < CurrentMonitorLeft || Globals["GUI"]["Position"]["GUIX"] + 550 > CurrentMonitorRight)
            Globals["GUI"]["Position"]["GUIX"] := Globals["GUI"]["Position"]["GUIX"] < CurrentMonitorLeft ? CurrentMonitorLeft : CurrentMonitorRight - 550
        If (Globals["GUI"]["Position"]["GUIY"] < CurrentMonitorTop || Globals["GUI"]["Position"]["GUIY"] + 350 > CurrentMonitorBottom)
            Globals["GUI"]["Position"]["GUIY"] := Globals["GUI"]["Position"]["GUIY"] < CurrentMonitorTop ? CurrentMonitorTop : CurrentMonitorBottom - 350
    }
}

;=====================================
; RUN RBXFPSUNLOCKER
; https://github.com/axstin/rbxfpsunlocker
;=====================================

; rbxfpsunlocker has been modified to respond to PostMessages

#Include *i lib\rbxfpsunlocker\rbxfpsunlocker.ahk ; includes the functions dealing with rbxfpsunlocker

Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] := "" ; clear any old directories
If (rbxfpsunlockerPID := ProcessExist("rbxfpsunlocker.exe")) ; if it's running, get the PID
    Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] := ProcessGetPath(rbxfpsunlockerPID) ; using the PID, get the directory
IniWrite(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], Globals["Constants"]["ini FilePaths"]["Settings"], "rbxfpsunlocker", "rbxfpsunlockerDirectory") ; save it
Try { ; close the current instance of rbxfpsunlocker, open the macro's instance if applicable
    CloseFPSUnlocker()
    If (Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"])
        RunFPSUnlocker(Globals["Settings"]["rbxfpsunlocker"]["FPS"])
} Catch Any
    MissingFilesError()

;=====================================
; CREATE GUI
;=====================================

MacroState := 0
#Include *i lib\ahk\GUI\GUI.ahk ; all of the work is done in this file

WinActivate(IvyshineGUI) ; activates the main GUI

;=====================================
; CREATE TRAY MENU
;=====================================

A_TrayMenu.Delete() ; clears the tray menu

Loop(3) ; aesthetic lines
    A_TrayMenu.Add()

A_TrayMenu.Add("Restore GUI (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")", IvyshineGUIRestore, "P20") ; adds restore gui
A_TrayMenu.Default := "Restore GUI (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")" ; makes it default
A_TrayMenu.ClickCount := 1 ; makes it so that you only have to click once

Loop(3) ; aesthetic lines
    A_TrayMenu.Add()

A_TrayMenu.Add("Open Logs (" Globals["Settings"]["Hotkeys"]["DebugHotkey"] ")", OpenDebug, "P20") ; adds debug
OpenDebug(*) {
    ListLines()
}

A_TrayMenu.Add() ; aesthetic lines

A_TrayMenu.Add("Suspend Hotkeys (" Globals["Settings"]["Hotkeys"]["SuspendHotkey"] ")", SuspendHotkeys, "P20") ; adds suspend
SuspendHotkeys(*){
    Suspend(-1) ; suspends hotkeys
    UpdateTitleText() ; changes title to match state
    A_TrayMenu.Rename("10&", (A_IsSuspended ? "Unsuspend Hotkeys (^F3)" : "Suspend Hotkeys (^F3)"), "P20") ; updates tray option
}

A_TrayMenu.Add() ; aesthetic lines

A_TrayMenu.Add("Start Macro (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")", StartMacro, "P0") ; 12& start macro
A_TrayMenu.Add("Pause Macro (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")", PauseMacro, "P0") ; 13& pause macro
A_TrayMenu.Disable("13&") ; initially disabled as macro not started
A_TrayMenu.Add("Stop Macro (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")", StopMacro, "P20") ; stop macro

A_TrayMenu.Add() ; aesthetic lines

A_IconTip := "Ivyshine Macro" ; changes the tip to be the name

;=====================================
; CREATE HOTKEYS
;=====================================

Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "T1 P0 S0") ; start hotkey
Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "Off T1 P0 S0") ; pause hotkey, disabled
Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "T1 P100 S0") ; stop hotkey

Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "T2 P1 S0") ; autoclicker hotkey T2 for toggle

Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGUIMinimise, "T1 P20 S") ; minimise to tray hotkey

Hotkey(Globals["Settings"]["Hotkeys"]["DebugHotkey"], OpenDebug, "T1 P20 S0") ; open debug hotkey
Hotkey(Globals["Settings"]["Hotkeys"]["SuspendHotkey"], SuspendHotkeys, "T1 P20 S") ; suspend hotkeys

HotIfWinActive("ahk_id " IvyshineGUI.Hwnd) ; custom title bar

Hotkey("~LButton", StartMoveGUI, "T1 P2 S") ; move using title bar
Hotkey("~LButton Up", StopMoveGUI, "T1 P4 S") ; stop move using title bar

GUIMoving := False
MovingMouseX := MovingMouseY := 0

StartMoveGUI(*) {
    Global GUIMoving
    Global MovingMouseX, MovingMouseY
    If (!WinActive(IvyshineGUI) || GUIMoving)
        Return
    MouseGetPos(&MovingMouseX, &MovingMouseY)
    If (MovingMouseY >= 0 && MovingMouseY <= 25) {
        CoordMode("Mouse", "Screen")
        MouseGetPos(&MovingMouseX, &MovingMouseY)
        CoordMode("Mouse", "Client")
        GUIMoving := True
        SetTimer(MoveGUI, 1, 3)
    }
}

StopMoveGUI(*) {
    Global GUIMoving
    GUIMoving := False
    SetTimer(MoveGUI, 0)
    WinGetPos(&WinX, &WinY,,, IvyshineGUI)
    Globals["GUI"]["Position"]["GUIX"] := WinX
    Globals["GUI"]["Position"]["GUIY"] := WinY
    IniWrite(Globals["GUI"]["Position"]["GUIX"], Globals["Constants"]["ini FilePaths"]["GUI"], "Position", "GUIX")
    IniWrite(Globals["GUI"]["Position"]["GUIX"], Globals["Constants"]["ini FilePaths"]["GUI"], "Position", "GUIY")
}

MoveGUI() {
    Global GUIMoving
    Global MovingMouseX, MovingMouseY
    If (!GUIMoving || !GetKeyState("LButton")) {
        StopMoveGUI()
        Return
    }
    OldMovingMouseX := MovingMouseX
    OldMovingMouseY := MovingMouseY
    CoordMode("Mouse", "Screen")
    MouseGetPos(&MovingMouseX, &MovingMouseY)
    CoordMode("Mouse", "Client")
    DiffMovingMouseX := MovingMouseX - OldMovingMouseX
    DiffMovingMouseY := MovingMouseY - OldMovingMouseY
    WinGetPos(&WinX, &WinY,,, IvyshineGUI)
    WinMove(WinX + DiffMovingMouseX, WinY + DiffMovingMouseY,,, IvyshineGUI)
}

HotIfWinActive()

;=====================================
; MAIN FUNCTIONS
;=====================================

#Include *i lib\ahk\Main\Functions.ahk ; main functions used in the macro
#Include *i lib\ahk\Libraries\Gdip_All.ahk ; gdi+ library NEED TO UPDATE
#Include *i lib\ahk\Libraries\ImagePut.ahk ; imageput library
#Include *i lib\ahk\Movement\Base.ahk ; movement functions

; SetTitleMatchMode(2)
; now := ImagePutBuffer(0)
; buf := ImagePutBuffer([50, 50, 1000, 500])
; ImagePutClipboard(buf)
; ImageShow(now)
; results := now.ImageSearch([60, 50, 1000, 500])
; MsgBox(results[1])

Try {
    ReleaseAllKeys() ; releases all keys
    pToken := Gdip_Startup() ; starts gdi+ lib
} Catch Any
    MissingFilesError()

StartMacro(*) {
    PauseFlag := MacroState ; to check if was paused
    Global MacroState := 1 ; 1 == running
    
    ReleaseAllKeys() ; unpresses any key pressed
    
    If (WinExist(EditHotkeysGUI)) ; closes external gui
        EditHotkeysGUIClose()
    
    If (WinExist(MacroInfoGUI)) ; closes external gui
        MacroInfoGUIClose()
    
    If (AutoclickerRunning) ; stops autoclicker
        Autoclick()
    
    If (Globals["Settings"]["AntiAFK"]["RunAntiAFK"]) ; stops antiAFK
        SetTimer(AntiAFK, 0)
    
    DetectHiddenWindowsSetting := A_DetectHiddenWindows ; unpauses external script
    DetectHiddenWindows(1)
    If (Globals["Variables"]["Externals"]["CurrentMovePID"] && WinExist("ahk_class AutoHotkey ahk_pid " Globals["Variables"]["Externals"]["CurrentMovePID"]))
        PostMessage(0x2002) ; 0x2001 == pause toggle
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    
    ; turns on pause hotkey, turns off start hotkey
    Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "On T1 P0 S0")
    Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], "Off")
    Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], "Off")
    
    GUIMasterSwitch() ; locks macro
    
    StartButton.Enabled := False
    PauseButton.Enabled := True
    A_TrayMenu.Disable("12&")
    A_TrayMenu.Enable("13&")
    
    UpdateTitleText() ; updates title
    
    If (A_IsPaused)
        Pause(-1)
    
    If (PauseFlag == 0) { ; starts the macro loop if just started
        Loop {
            HiveToCorner() ; temp test function
            Sleep(1000)
        }
    }
}

PauseMacro(*) {
    Global MacroState := 2 ; 2 == paused
    
    DetectHiddenWindowsSetting := A_DetectHiddenWindows ; pause external scripts
    DetectHiddenWindows(1)
    If (Globals["Variables"]["Externals"]["CurrentMovePID"] && WinExist("ahk_class AutoHotkey ahk_pid " Globals["Variables"]["Externals"]["CurrentMovePID"]))
        PostMessage(0x2001)
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    
    If (Globals["Settings"]["AntiAFK"]["RunAntiAFK"]) { ; rdestarts AntiAFK if applicable
        Globals["Settings"]["AntiAFK"]["LastRun"] := CurrentTime()
        SetTimer(AntiAFK, 500, -1)
    }
    
    ; turns on start hotkey, turns off pause hotkey
    Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], "Off")
    Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "On T2 P0 S0")
    Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "On T2 P1 S0")
    
    GUIMasterSwitch() ; unlocks macro
    
    StartButton.Enabled := True
    PauseButton.Enabled := False
    A_TrayMenu.Disable("13&")
    A_TrayMenu.Enable("12&")
    
    UpdateTitleText() ; updates title
    Pause(-1)
}

StopMacro(*) {
    Critical
    Gdip_Shutdown(pToken) ; unloads gdi+ library
    ReloadMacro() ; reloads the macro
}

ReloadMacro(*) {
    Critical
    RestoreFPSUnlocker() ; re-opens rbxfpsunlocker if applicable
    EndMovement() ; stops external script
    
    If (IvyshineGUI) { ; if it exists
        If (!A_IconHidden)
            IvyshineGUIRestore() ; if minimised, unminimise
        
        If (DirExist("lib\init")) { ; if settings exist, save them
            DetectHiddenWindows(1)
            WinGetPos(&GUIX, &GUIY,,, IvyshineGUI)
            Globals["GUI"]["Position"]["GUIX"] := GUIX
            Globals["GUI"]["Position"]["GUIY"] := GUIY
            For ini, Section in Globals
                UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        }
    }
    HyperSleep(25)
    Reload
}

ExitMacro(*) { ; same as ReloadMacro() but with ExitApp
    Critical
    RestoreFPSUnlocker()
    EndMovement()
    
    If (IvyshineGUI) {
        If (!A_IconHidden)
            IvyshineGUIRestore()
        
        If (DirExist("lib\init")) {
            DetectHiddenWindows(1)
            WinGetPos(&GUIX, &GUIY,,, IvyshineGUI)
            Globals["GUI"]["Position"]["GUIX"] := GUIX
            Globals["GUI"]["Position"]["GUIY"] := GUIY
            For ini, Section in Globals
                UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        }
        IvyshineGUI.Destroy() ; destroys GUI
    }
    HyperSleep(25)
    ExitApp
}

Hotkey("]", ReloadMacro, "P20") ; debugging only
