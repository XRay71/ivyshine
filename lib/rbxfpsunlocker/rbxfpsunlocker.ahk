RunFPSUnlocker(FPS := 30) {
    Global Globals
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    CurrentExecPath := ""
    For Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process WHERE name like 'rbxfpsunlocker.exe%' ")
        CurrentExecPath := Process.ExecutablePath
    If (CurrentExecPath && CurrentExecPath == (A_ScriptDir "\lib\rbxfpsunlocker\rbxfpsunlocker.exe"))
        PostMessage(0x0010, 0xF060,,, "ahk_exe rbxfpsunlocker.exe")
    Else If (CurrentExecPath && CurrentExecPath == Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"]) {
        BlockInput("Send")
        PostMessage(0x8000 + 1,, 0x0204,, "ahk_exe rbxfpsunlocker.exe")
        HyperSleep(20)
        SendInput("{Up}{Enter}")
        BlockInput("Default")
    }
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    HyperSleep(50)
    FPSCapSelection := (FPS ? 1 : 0)
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
    FileAppend(
    (
        "UnlockClient=true`r`n"
        "UnlockStudio=false`r`n"
        "FPSCapValues=[" FPS "]`r`n"
        "FPSCapSelection=" FPSCapSelection "`r`n"
        "FPSCap=" (FPSCapSelection ? FPS : "0") "`r`n"
        "CheckForUpdates=false`r`n"
        "NonBlockingErrors=true`r`n"
        "SilentErrors=true`r`n"
        "QuickStart=true"
    )
        , "lib\rbxfpsunlocker\settings")
    Run("lib\rbxfpsunlocker\rbxfpsunlocker.exe", "lib\rbxfpsunlocker", "Hide")
    HyperSleep(25)
    Ranrbxfpsunlocker := 1
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
}

RestoreFPSUnlocker() {
    Global Globals
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    CurrentExecPath := ""
    For Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process WHERE name like 'rbxfpsunlocker.exe%' ")
        CurrentExecPath := Process.ExecutablePath
    If (CurrentExecPath && CurrentExecPath == (A_ScriptDir "\lib\rbxfpsunlocker\rbxfpsunlocker.exe"))
        PostMessage(0x0010, 0xF060,,, "ahk_exe rbxfpsunlocker.exe")
    Else If (CurrentExecPath && CurrentExecPath == Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"]) {
        BlockInput("Send")
        PostMessage(0x8000 + 1,, 0x0204,, "ahk_exe rbxfpsunlocker.exe")
        HyperSleep(20)
        SendInput("{Up}{Enter}")
        BlockInput("Default")
    }
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
    HyperSleep(25)
    If (Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"])
        Run(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], StrReplace(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], "\rbxfpsunlocker.exe"), "Hide")
    HyperSleep(25)
}
