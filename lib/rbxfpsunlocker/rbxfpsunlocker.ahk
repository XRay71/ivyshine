RunFPSUnlocker(FPS := 30) {
    Critical
    CloseFPSUnlocker() ; close old instance
    
    FPSCapSelection := (FPS ? 1 : 0)
    
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings") ; deletes settings if applicable
    
    Loop
        HyperSleep(5)
    Until (!FileExist("lib\rbxfpsunlocker\settings"))
    HyperSleep(5) ; waits until the settings are deleted
    
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
        , "lib\rbxfpsunlocker\settings") ; makes new settings
    
    Loop
        HyperSleep(5)
    Until (FileExist("lib\rbxfpsunlocker\settings"))
    HyperSleep(20) ; waits until settings exist
    
    Run("lib\rbxfpsunlocker\rbxfpsunlocker.exe", "lib\rbxfpsunlocker", "Hide") ; runs rbxfpsunlocker
    
    Loop
        HyperSleep(5)
    Until (ProcessExist("rbxfpsunlocker.exe")) ; waits until it exists
    HyperSleep(5)
    Critical("Off")
}

RestoreFPSUnlocker() {
    Critical
    CloseFPSUnlocker() ; closes current instance
    
    If (FileExist("lib\rbxfpsunlocker\settings"))
        FileDelete("lib\rbxfpsunlocker\settings") ; deletes settings file
    
    ; runs previously detected rbxfpsunlocker instance, if applicable
    If (Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"] && !InStr(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], "\lib\rbxfpsunlocker\rbxfpsunlocker.exe")) {
        Run(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], StrReplace(Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"], "\rbxfpsunlocker.exe"), "Hide")
        
        Loop
            HyperSleep(5)
        Until (ProcessExist("rbxfpsunlocker.exe"))
        HyperSleep(5)
    }
    
    HyperSleep(50)
    Critical("Off")
}

CloseFPSUnlocker() {
    Critical
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    
    While (rbxfpsunlockerPID := ProcessExist("rbxfpsunlocker.exe")) {
        rbxfpsunlockerPID := ProcessExist("rbxfpsunlocker.exe") ; checks if it exists
        If (rbxfpsunlockerPID && rbxfpsunlockerPID := ProcessExist(rbxfpsunlockerPID)) {
            Try {
                CurrentExecPath := ProcessGetPath(rbxfpsunlockerPID)
                
                If (CurrentExecPath && InStr(CurrentExecPath, "\lib\rbxfpsunlocker\rbxfpsunlocker.exe"))
                    PostMessage(0x0010, 0xF060,,, "ahk_pid " rbxfpsunlockerPID) ; sends message if macro instance
                Else If (CurrentExecPath && CurrentExecPath == Globals["Settings"]["rbxfpsunlocker"]["rbxfpsunlockerDirectory"]) {
                    CurrentWindowID := WinGetID("A")
                    PostMessage(0x8000 + 1,, 0x0204,, "ahk_pid " rbxfpsunlockerPID) ; opens rbxfpsunlocker tray menu
                    HyperSleep(100)
                    Send("{" Globals["Constants"]["Scan Codes"]["Up"] "}{" Globals["Constants"]["Scan Codes"]["Enter"] "}") ; presses exit
                    WinActivate("ahk_pid " rbxfpsunlockerPID) ; closes menu in case unsuccessful
                    WinActivate(CurrentWindowID)
                }
            }
            Catch Any
                Break
        }
        HyperSleep(500)
    }
    
    If (FileExist("lib\rbxfpsunlocker\settings")) ; deletes settings file
        FileDelete("lib\rbxfpsunlocker\settings")
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    
    HyperSleep(50)
    Critical("Off")
}

