IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs-8 ys+46 w132 h92 Section", "Anti-AFK")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

RunAntiAFKCheckBox := IvyshineGUI.Add("CheckBox", "xs yp+4 h20 -Wrap vRunAntiAFKCheckBox", "Run Anti-AFK?")
RunAntiAFKCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+23 h18 -Wrap +BackgroundTrans", "Run every ")
AntiAFKIntervalEdit := IvyshineGUI.Add("Edit", "x+2 yp-2 w20 hp -Wrap Center Limit2 Number vAntiAFKIntervalEdit Disabled" (Globals["Settings"]["AntiAFK"]["RunAntiAFK"] ? "0" : "1"))
AntiAFKIntervalEdit.OnEvent("LoseFocus", SubmitSettings)
AntiAFKIntervalText := IvyshineGUI.Add("Text", "x+2 yp+2 hp w100 -Wrap +BackgroundTrans vAntiAFKIntervalText", ((Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] != 1 || !AntiAFKIntervalEdit.Enabled) ? " minutes." : " minute."))

If (Globals["Settings"]["AntiAFK"]["RunAntiAFK"]) {
    Globals["Settings"]["AntiAFK"]["LastRun"] := CurrentTime()
    SetTimer(AntiAFK, 500, -1)
}

AntiAFKProgress := IvyshineGUI.Add("Progress", "xs yp+20 h18 w116 vAntiAFKProgress Range0-" (Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] * 60))

AntiAFKInfoButton := IvyshineGUI.Add("Button", "xs+52 ys-19 h16 w15 vAntiAFKInfoButton", "?")
AntiAFKInfoButton.OnEvent("Click", ShowAntiAFKInfo)

ShowAntiAFKInfo(*) {
    MsgBox("This feature automatically switches to Roblox and nudges the camera on a chosen interval, preventing you from disconnecting if you are AFKing in the background.`r`n`r`nExample use case: Roblox is minimized in the background."
        , "What is Anti-AFK?"
        , "Icon? Owner" IvyshineGUI.Hwnd)
}

AntiAFK() {
    Critical
    TimeDifference := CurrentTime() - Globals["Settings"]["AntiAFK"]["LastRun"]
    
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    If (!ProcessExist("RobloxPlayerBeta.exe") || WinActive("ahk_exe RobloxPlayerBeta.exe")) {
        Globals["Settings"]["AntiAFK"]["LastRun"] := CurrentTime()
        TimeDifference := 0
    }
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    
    AntiAFKProgress.Value := TimeDifference
    
    If (TimeDifference > Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] * 60) {
        Globals["Settings"]["AntiAFK"]["LastRun"] := CurrentTime()
        Try {
            CurrentWindowName := WinGetTitle("A")
            CurrentWindowProcessName := WinGetProcessName("A")
        }
        ReleaseAllKeys()
        If (RobloxWindow := ActivateWindowWithCheck("Roblox", "RobloxPlayerBeta.exe")) {
            Send("{" Globals["Constants"]["Scan Codes"]["LControl"] "}" "{" Globals["Constants"]["Scan Codes"]["F7"] "}")
            HyperSleep(15)
            Send("{" Globals["Constants"]["Scan Codes"]["LControl"] "}" "{" Globals["Constants"]["Scan Codes"]["F7"] "}")
            If (RobloxWindow[3] == -1)
                WinMinimize(RobloxWindow[2])
        }
        If (CurrentWindowName && CurrentWindowProcessName)
            ActivateWindowWithCheck(CurrentWindowName, CurrentWindowProcessName)
    }
    Critical("Off")
}