IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs-8 ys+203 w106 h92 Section", "Autoclicker")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

IvyshineGUI.Add("Text", "xs ys+6 h21 -Wrap +BackgroundTrans", "Interval: ")
ClickIntervalEdit := IvyshineGUI.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vClickIntervalEdit")
ClickIntervalEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "Amount: ")
ClickAmountEdit := IvyshineGUI.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vClickAmountEdit")
ClickAmountEdit.OnEvent("LoseFocus", SubmitSettings)

AutoclickerProgress := IvyshineGUI.Add("Progress", "xs yp+22 h18 w91 vAutoclickerProgress Range0-1")
AutoclickerText := IvyshineGUI.Add("Text", "xs yp+2 h18 w91 +BackgroundTrans vAutoclickerText Center", "Autoclicker OFF")

AutoclickerRunning := False

Autoclick(*) {
    Global AutoclickerRunning
    
    AutoclickerRunning := !AutoclickerRunning
    AutoclickerText.Text := "Autoclicker ON"
    
    If (AutoclickerRunning) {
        ListLines(0)
        ProcessSetPriority("R")
        SetMouseDelay(-1)
        SetKeyDelay(-1)
        GUISwitch()
        If (MacroState != 1) {
            GUIMasterSwitch()
            ClickIntervalEdit.Enabled := False
            ClickAmountEdit.Enabled := False
        }
        
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
        
        AutoclickerProgress.Value := 0
        AutoclickerText.Text := "Autoclicker OFF"
        
        AutoclickerRunning := False
        
        ProcessSetPriority("A")
        GUISwitch()
        If (MacroState != 1) {
            ClickIntervalEdit.Enabled := True
            ClickAmountEdit.Enabled := True
            SetAllGUIValues()
            GUIMasterSwitch()
        }
        ListLines(1)
    }
}