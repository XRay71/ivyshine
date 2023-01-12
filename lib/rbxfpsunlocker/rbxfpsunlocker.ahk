Ranrbxfpsunlocker := 0

RunFPSUnlocker(FPS := 30) {
    Global Ranrbxfpsunlocker
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    If (WinExist("ahk_exe rbxfpsunlocker.exe") && !Ranrbxfpsunlocker) {
        BlockInput("Send")
        PostMessage(0x8000 + 1,, 0x0204,, "ahk_exe rbxfpsunlocker.exe")
        Sleep(100)
        hwnd := SendMessage(0x01E1, 0, 0,, "ahk_class #32768")
        SendInput("{Up}{Enter")
        BlockInput("Default")
        
    } Else If (WinExist("ahk_exe rbxfpsunlocker.exe") && Ranrbxfpsunlocker) {
        PostMessage(0x0010, 0xF060,,, "ahk_exe rbxfpsunlocker.exe")
    }
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    Sleep(100)
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
    Sleep(100)
    Ranrbxfpsunlocker := 1
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
}

RestoreFPSUnlocker() {
    Global Globals, Ranrbxfpsunlocker
    If (Ranrbxfpsunlocker)
    {
        DetectHiddenWindowsSetting := A_DetectHiddenWindows
        DetectHiddenWindows(1)
        If (WinExist("ahk_exe rbxfpsunlocker.exe"))
            PostMessage(0x0010, 0xF060,,, "ahk_exe rbxfpsunlocker.exe")
        DetectHiddenWindows(DetectHiddenWindowsSetting)
        If (FileExist("lib\rbxfpsunlocker\settings"))
            FileDelete("lib\rbxfpsunlocker\settings")
        Sleep(100)
        If(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"])
            Run(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], StrReplace(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], "\rbxfpsunlocker.exe"), "Hide")
        Sleep(100)
    }
}
