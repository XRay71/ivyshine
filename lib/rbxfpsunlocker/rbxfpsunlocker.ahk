RunFPSUnlocker(FPS := 30) {
    Critical
    CloseFPSUnlocker()
    
    FPSCapSelection := (FPS ? 1 : 0)
    
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
    
    Loop
        HyperSleep(5)
    Until (!FileExist("lib\rbxfpsunlocker\settings"))
    HyperSleep(5)
    
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
    
    Loop
        HyperSleep(5)
    Until (FileExist("lib\rbxfpsunlocker\settings"))
    HyperSleep(5)
    
    Run("lib\rbxfpsunlocker\rbxfpsunlocker.exe", "lib\rbxfpsunlocker", "Hide")
    
    Loop
        HyperSleep(5)
    Until (ProcessExist("rbxfpsunlocker.exe"))
    
    HyperSleep(20)
    
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
}

RestoreFPSUnlocker() {
    Critical
    CloseFPSUnlocker()
    
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings")
    
    Loop
        HyperSleep(5)
    Until (!FileExist("lib\rbxfpsunlocker\settings"))
    HyperSleep(5)
    
    If (Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] && !InStr(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], "\lib\rbxfpsunlocker\rbxfpsunlocker.exe")) {
        Run(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], StrReplace(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], "\rbxfpsunlocker.exe"), "Hide")
        
        Loop
            HyperSleep(5)
        Until (ProcessExist("rbxfpsunlocker.exe"))
        HyperSleep(5)
    }
    
    HyperSleep(5)
}

CloseFPSUnlocker() {
    Critical
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    
    While (rbxfpsunlockerPID := ProcessExist("rbxfpsunlocker.exe")) {
        rbxfpsunlockerPID := ProcessExist("rbxfpsunlocker.exe")
        If (ProcessExist(rbxfpsunlockerPID)) {
            Try {
                CurrentExecPath := ProcessGetPath(rbxfpsunlockerPID)
                
                If (CurrentExecPath && InStr(CurrentExecPath, "\lib\rbxfpsunlocker\rbxfpsunlocker.exe"))
                    PostMessage(0x0010, 0xF060,,, "ahk_pid " rbxfpsunlockerPID)
                Else If (CurrentExecPath && CurrentExecPath == Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"]) {
                    BlockInput("Send")
                    PostMessage(0x8000 + 1,, 0x0204,, "ahk_pid " rbxfpsunlockerPID)
                    HyperSleep(35)
                    Send("{" Globals["Constants"]["Scan Codes"]["Up"] "}{" Globals["Constants"]["Scan Codes"]["Enter"] "}")
                    WinActivate("ahk_pid " rbxfpsunlockerPID)
                    BlockInput("Default")
                }
            }
            Catch Any
                Break
        }
        HyperSleep(20)
    }
    HyperSleep(10)
    
    DetectHiddenWindows(DetectHiddenWindowsSetting)
}
