IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 ys+205 w106 h90 Section", "Autoclicker")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs ys+6 h21 -Wrap +BackgroundTrans", "Interval: ")
ClickIntervalEdit := IvyshineGui.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vClickIntervalEdit")
ClickIntervalEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(ClickIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])

IvyshineGui.Add("Text", "xs yp+22 h20 -Wrap +BackgroundTrans", "Amount: ")
ClickAmountEdit := IvyshineGui.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vClickAmountEdit")
ClickAmountEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(ClickAmountEdit.Hwnd, (Globals["Settings"]["Autoclicker"]["ClickAmount"] ? Globals["Settings"]["Autoclicker"]["ClickAmount"] : "infinite"))

AutoclickerProgress := IvyshineGui.Add("Progress", "xs yp+21 h18 w91 vAutoclickerProgress Range0-1")
AutoclickerText := IvyshineGui.Add("Text", "xs yp+2 h18 w91 +BackgroundTrans vAutoclickerText Center", "Autoclicker OFF")

AutoclickerRunning := False

Autoclick(*) {
    Global AutoclickerRunning
    CriticalSetting := A_IsCritical
    Critical("Off")
    ListLines(0)
    ProcessSetPriority("R")
    SetMouseDelay(-1)
    SetKeyDelay(-1)
    
    AutoclickerRunning := !AutoclickerRunning
    AutoclickerText.Text := "Autoclicker ON"
    
    If (AutoclickerRunning) {
        GuiMasterSwitch()
        GuiSwitch()
        
        ClickIntervalEdit.Enabled := False
        ClickAmountEdit.Enabled := False
        
        IntervalTemp := A_HotkeyInterval
        A_HotkeyInterval := 0
        Diff := 0
        If (Globals["Settings"]["Autoclicker"]["ClickAmount"] == 0) {
            While (AutoclickerRunning) {
                MouseLeftClick()
                Diff := HyperSleep(Globals["Settings"]["Autoclicker"]["ClickInterval"] - Diff - 1.25)
            }
        }
        Else {
            While (AutoclickerRunning && A_Index <= Globals["Settings"]["Autoclicker"]["ClickAmount"]) {
                MouseLeftClick()
                Diff := HyperSleep(Globals["Settings"]["Autoclicker"]["ClickInterval"] - Diff - 1.25)
            }
        }
        
        A_HotkeyInterval := IntervalTemp
        
        ClickIntervalEdit.Enabled := True
        ClickAmountEdit.Enabled := True
        AutoclickerProgress.Value := 0
        AutoclickerText.Text := "Autoclicker OFF"
        
        AutoclickerRunning := False
        
        ProcessSetPriority("A")
        SetAllGuiValues()
        GuiMasterSwitch()
        GuiSwitch()
    }
    
    ListLines(1)
    Critical CriticalSetting
}