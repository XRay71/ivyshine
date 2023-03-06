RunMovement(Path, Name := "") {
    Critical
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    OnMessage(0x2002, HandshakeMovementStart)
    
    If (Globals["Variables"]["Externals"]["CurrentMovePID"] && WinExist("ahk_class AutoHotkey ahk_pid " Globals["Variables"]["Externals"]["CurrentMovePID"]))
        EndMovement()
    
    Script :=
    (
    "OnMessage(0x2000, StartMovement)`r`n"
    "OnMessage(0x2001, PauseMovement)`r`n"
    "OnMessage(0x2002, UnpauseMovement)`r`n"
    "Persistent`r`n"
    "#SingleInstance Off`r`n"
    "#Requires AutoHotkey v2.0 32-bit`r`n"
    "KeyHistory(0)`r`n"
    "ListLines(0)`r`n"
    "ProcessSetPriority(`"H`")`r`n"
    "DetectHiddenWindows(1)`r`n"
    "SetTitleMatchMode(2)`r`n"
    "SetMouseDelay(-1)`r`n"
    "SetKeyDelay(-1)`r`n"
    "SendMode(`"Input`")`r`n"
    "SetWorkingDir `"" A_ScriptDir "`"`r`n"
    "OnExit(ExitScript)`r`n"
    "#Include " A_ScriptDir "\lib\ahk`r`n"
    "#Include Movement\Base.ahk`r`n"
    "#Include Main\Functions.ahk`r`n"
    "#Include init\ini Functions.ahk`r`n"
    "#Include init\globals.ahk`r`n"
    "For ini in Globals`r`n"
    "    If (FileExist(Globals[`"Constants`"][`"ini FilePaths`"][ini]))`r`n"
    "        ReadIni(Globals[`"Constants`"][`"ini FilePaths`"][ini], Globals[ini])`r`n"
    "ReadIni(`"lib\init\constants.ini`", Globals[`"Constants`"])`r`n"
    "ReadIni(`"lib\init\settings.ini`", Globals[`"Settings`"])`r`n"
    "StartMovement()`r`n"
    "StartMovement(*){`r`n"
        "   SendMessage(0x2002,,,, `"Ivyshine Macro ahk_class AutoHotkeyGUI`")`r`n"
        Path
        "   SendMessage(0x2003,,,, `"Ivyshine Macro ahk_class AutoHotkeyGUI`")`r`n"
    "}`r`n"
    "PauseMovement(*){`r`n"
    "   If (!A_IsPaused) {`r`n"
    "       ReleaseAllKeys()`r`n"
    "       Pause(-1)`r`n"
    "   }`r`n"
    "}`r`n"
    "UnpauseMovement(*){`r`n"
    "   If (A_IsPaused) {`r`n"
    "       RestoreKeyStates()`r`n"
    "       Pause(-1)`r`n"
    "   }`r`n"
    "}`r`n"
    "ExitScript(*) {`r`n"
    "   ReleaseAllKeys()`r`n"
    "}`r`n"
    )
    Shell := ComObject("WScript.Shell")
    Exec := Shell.Exec(A_AhkPath " /ErrorStdOut *")
    Exec.StdIn.Write(Script)
    Exec.StdIn.Close()
    
    WinWait("ahk_class AutoHotkey ahk_pid " Exec.ProcessID,, 2)
    Globals["Variables"]["Externals"]["CurrentMovePID"] := Exec.ProcessID
    Globals["Variables"]["Externals"]["CurrentMoveName"] := Name
    
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    Critical("Off")
}

EndMovement(*) {
    Critical
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    If (Globals["Variables"]["Externals"]["CurrentMovePID"] && WinExist("ahk_class AutoHotkey ahk_pid " Globals["Variables"]["Externals"]["CurrentMovePID"]))
        WinClose("ahk_class AutoHotkey ahk_pid " Globals["Variables"]["Externals"]["CurrentMovePID"])
    Globals["Variables"]["Externals"]["CurrentMovePID"] := 0
    Globals["Variables"]["Externals"]["CurrentMoveName"] := ""
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    Critical("Off")
}

MovementFlag := 0

HandshakeMovementStart(*) {
    Global MovementFlag := 1
    OnMessage(0x2003, HandshakeMovementEnd)
    OnMessage(0x2002, HandshakeMovementStart, 0)
}

HandshakeMovementEnd(*) {
    Global MovementFlag := 0
    OnMessage(0x2003, HandshakeMovementEnd, 0)
}

PressKey(Key, State := "") { ; presses a specified key in a specified state, returns unslept time
    Diff := 0
    If (State)
        Send("{" Globals["Constants"]["Scan Codes"][Key] " " State "}")
    Else {
        Send("{" Globals["Constants"]["Scan Codes"][Key] " Down}")
        Diff := HyperSleep(30 + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"]) ; least amount of time Roblox requires to detect keypress
        Send("{" Globals["Constants"]["Scan Codes"][Key] " Up}")
    }
    Return Diff
}

Move(Keys, MoveTime) { ; movement in game, in ms. Returns difference
    For Key in Keys
        PressKey(Key, "Down")
    Diff := HyperSleep(MoveTime * Globals["Settings"]["Basic Settings"]["MoveSpeed"] / Globals["Constants"]["Game Values"]["Base MoveSpeed"] + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
    For Key in Keys
        PressKey(Key, "Up")
    Return Diff
}

MoveFlowers(Keys, NumFlowers) { ; movement in game, in terms of flower tiles. Returns difference
    For Key in Keys
        PressKey(Key, "Down")
    Diff := HyperSleep(NumFlowers * Globals["Constants"]["Game Values"]["Flower Length"] * Globals["Constants"]["Game Values"]["Base MoveSpeed"] / Globals["Settings"]["Basic Settings"]["MoveSpeed"] + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
    For Key in Keys
        PressKey(Key, "Up")
    Return Diff
}

Jump(Duration := 150) { ; jumps. Default is apex of movement
    Diff := PressKey("Space")
    Return HyperSleep(Abs(Duration - Diff) + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
}

DeployGlider(OnGround := 0) { ; deploys glider
    Jump(OnGround ? Globals["Constants"]["Game Values"]["Jump Duration"] / 2 : 75)
    Jump(0)
}

Reset() {
    Loop Integer(Globals["Settings"]["Miscellaneous"]["ResetMultiplier"]) {
        PressKey("Escape")
        PressKey("r")
        PressKey("Enter")
        Sleep(6500)
    }
}

#Include *i Default\HiveToCorner.ahk