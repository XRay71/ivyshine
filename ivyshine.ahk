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
#SingleInstance Ignore ; don't replace with new instance
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
    WinHttpRequest := ComObject("WinHttp.WinHttpRequest.5.1") ; opens a winhttps request
    WinHttpRequest.Open("GET", "https://raw.githubusercontent.com/XRay71/ivyshine/main/version.txt", true) ; sends a GET request to the github version file
    WinHttpRequest.Send() ; sends the request
    WinHttpRequest.WaitForResponse() ; waits for response
    NewVersionID := RegExReplace(Trim(WinHttpRequest.ResponseText), "\.? *(\n|\r)+") ; trims all whitespace from the version file
    
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

#Include *i lib\ahk\GUI\Gui.ahk ; all of the work is done in this file

WinActivate(IvyshineGui) ; activates the main GUI

;=====================================
; CREATE TRAY MENU
;=====================================

A_TrayMenu.Delete() ; clears the tray menu
Loop(3) ; aesthetic lines
    A_TrayMenu.Add()
A_TrayMenu.Add("Restore GUI (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")", IvyshineGuiRestore, "P10") ; adds restore gui
A_TrayMenu.Default := "Restore GUI (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")" ; makes it default
Loop(3) ; aesthetic lines
    A_TrayMenu.Add()
A_TrayMenu.Add("Open Logs (" Globals["Settings"]["Hotkeys"]["DebugHotkey"] ")", OpenDebug) ; adds debug
OpenDebug(*) {
    ListLines
}
A_TrayMenu.Add() ; aesthetic lines
A_TrayMenu.Add("Suspend Hotkeys (" Globals["Settings"]["Hotkeys"]["SuspendHotkey"] ")", SuspendHotkeys) ; adds suspend
SuspendHotkeys(*){
    Suspend(-1)
    TitleText.Text := (A_IsSuspended ? "Ivyshine Macro (Hotkeys Suspended)" : "Ivyshine Macro")
    GuiCloseButton.Redraw()
    GuiMinimizeButton.Redraw()
    A_TrayMenu.Rename("10&", (A_IsSuspended ? "Unsuspend Hotkeys (^F3)" : "Suspend Hotkeys (^F3)")) ; aesthetics
}
A_TrayMenu.Add() ; aesthetic lines
A_TrayMenu.Add("Start Macro (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")", StartMacro)
A_TrayMenu.Add("Pause Macro (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")", PauseMacro)
A_TrayMenu.Add("Stop Macro (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")", StopMacro)
A_TrayMenu.Add() ; aesthetic lines
A_TrayMenu.ClickCount := 1 ; makes it so that you only have to click once

A_IconTip := "Ivyshine" ; changes the tip to be the name

;=====================================
; CREATE HOTKEYS
;=====================================

Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "T1 P0 S0")
Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "T1 P0 S0")
Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "T1 P20 S0")

Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "T2 P1 S0")

Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGuiMinimize, "T1 P10 S")

HotIfWinActive("ahk_id " IvyshineGui.Hwnd) ; custom title bar

Hotkey("~LButton", StartMoveGui, "T1 P2 S")
Hotkey("~LButton Up", StopMoveGui, "T1 P3 S")

HotIfWinActive()

Hotkey(Globals["Settings"]["Hotkeys"]["DebugHotkey"], OpenDebug, "T1 P10 S")
Hotkey(Globals["Settings"]["Hotkeys"]["SuspendHotkey"], SuspendHotkeys, "T1 P10 S")

;=====================================
; MAIN FUNCTIONS
;=====================================

#Include *i lib\ahk\Main\Functions.ahk ; main functions used in the macro
#Include *i lib\ahk\Libraries\Gdip_All.ahk ; gdi+ library NEED TO UPDATE
#Include *i lib\ahk\Libraries\ImagePut.ahk ; imageput library
#Include *i lib\ahk\Movement\Base.ahk ; movement functions

Try {
    ReleaseAllKeys()
    pToken := Gdip_Startup()
} Catch Any
    MissingFilesError()

StartMacro(*) {
    ReleaseAllKeys() ; unpresses any key pressed
    MacroInfoGuiClose() ; closes external GUIs
    Reset()
    HiveToCorner()
}

PauseMacro(*) {
    If (Globals["Variables"]["Externals"]["CurrentMovePID"] && WinExist("ahk_class AutoHotkey ahk_pid " Globals["Externals"]["Externals"]["CurrentMovePID"]))
        PostMessage(0x2000) ; sends pause command to external script
    MsgBox("Pause")
}

StopMacro(*) {
    MsgBox("Stop")
    ReloadMacro() ; reloads the macro
}

ReloadMacro(*) {
    RestoreFPSUnlocker() ; re-opens rbxfpsunlocker if applicable
    If (IvyshineGui) { ; if it exists
        If (!A_IconHidden)
            IvyshineGuiRestore() ; if minimised, unminimise
        
        If (DirExist("lib\init")) { ; if settings exist, save them
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

ExitMacro(*) { ; same as ReloadMacro() but with ExitApp
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
        IvyshineGui.Destroy()
    }
    HyperSleep(25)
    ExitApp
}

Hotkey("]", ReloadMacro, "P20") ; debugging only
