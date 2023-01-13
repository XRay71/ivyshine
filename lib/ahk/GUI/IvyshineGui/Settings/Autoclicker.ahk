IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 y+6 w106 h90 Section", "Autoclicker")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs yp+9 h21 -Wrap +BackgroundTrans", "Interval: ")
AutoclickerIntervalEdit := IvyshineGui.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vAutoclickerIntervalEdit")
AutoclickerIntervalEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(AutoclickerIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])

IvyshineGui.Add("Text", "xs yp+20 h20 -Wrap +BackgroundTrans", "Amount: ")
AutoclickerAmountEdit := IvyshineGui.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vAutoclickerAmountEdit")
AutoclickerAmountEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(AutoclickerAmountEdit.Hwnd, (Globals["Settings"]["Autoclicker"]["ClickAmount"] ? Globals["Settings"]["Autoclicker"]["ClickAmount"] : "infinite"))

AutoclickerHotkeyButton := IvyshineGui.Add("Button", "xs yp+21 w92 h20 Center", "Hotkey: " Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
AutoclickerHotkeyButton.OnEvent("Click", StartEditHotkeys)

AutoclickerRunning := False

Autoclick(*) {
    Global Globals
    Global AutoclickerRunning
    AutoclickerRunning := !AutoclickerRunning
    
    Global AutoclickerIntervalEdit, AutoclickerAmountEdit, AutoclickerHotkeyButton
    If (AutoclickerRunning) {
        AutoclickerIntervalEdit.Enabled := False
        AutoclickerAmountEdit.Enabled := False
        AutoclickerHotkeyButton.Enabled := False
        SetTimer(AutoClickClick, Globals["Settings"]["Autoclicker"]["ClickInterval"], 1)
    } Else {
        AutoclickerIntervalEdit.Enabled := True
        AutoclickerAmountEdit.Enabled := True
        AutoclickerHotkeyButton.Enabled := True
        SetTimer(AutoClickClick, 0)
    }
}

AutoClickClick() {
    Click()
}