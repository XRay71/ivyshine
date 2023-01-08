RunFPSUnlocker(FPS := 30) {
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    If WinExist("ahk_exe rbxfpsunlocker.exe") {
        PostMessage(0x8000 + 1, 0, 0x0204,, "ahk_exe rbxfpsunlocker.exe")
        MouseMove(10, 220, 0, "R")
        Sleep(75)
        MouseClick()
        Sleep(75)
        MouseMove(-10, -220, 0, "R")
    }
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    If (!FPS)
        FPSCapSelection := 0
    Else
        FPSCapSelection := 1
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
    Sleep(100)
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
}

RestoreFPSUnlocker() {
    If WinExist("ahk_exe rbxfpsunlocker.exe")
        PostMessage(0x0010, 0xF060, 0,, "ahk_exe rbxfpsunlocker.exe")
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
    If (Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"])
        Run(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], StrReplace(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], "rbxfpsunlocker.exe"), "Hide")
}
