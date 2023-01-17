IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 ys+205 w106 h90 Section", "Autoclicker")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs yp+9 h21 -Wrap +BackgroundTrans", "Interval: ")
ClickIntervalEdit := IvyshineGui.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vClickIntervalEdit")
ClickIntervalEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(ClickIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])

IvyshineGui.Add("Text", "xs yp+20 h20 -Wrap +BackgroundTrans", "Amount: ")
ClickAmountEdit := IvyshineGui.Add("Edit", "x+1 yp-2 w48 h19 Limit6 -Wrap Left Number vClickAmountEdit")
ClickAmountEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(ClickAmountEdit.Hwnd, (Globals["Settings"]["Autoclicker"]["ClickAmount"] ? Globals["Settings"]["Autoclicker"]["ClickAmount"] : "infinite"))

AutoclickerHotkeyButton := IvyshineGui.Add("Button", "xs yp+21 w92 h20 Center", "Hotkey: " Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
AutoclickerHotkeyButton.OnEvent("Click", StartEditHotkeys)

AutoclickerRunning := False

Autoclick(*) {
    Global Globals
    Global AutoclickerRunning
    
    AutoclickerRunning := !AutoclickerRunning
    
    GuiMasterSwitch()
    GuiSwitch()
    
    Globals["Settings"]["Autoclicker"]["ClickCounter"] := 0
    
    Global ClickIntervalEdit, ClickAmountEdit, AutoclickerHotkeyButton
    ClickIntervalEdit.Enabled := False
    ClickAmountEdit.Enabled := False
    AutoclickerHotkeyButton.Enabled := False
    
    IntervalTemp := A_HotkeyInterval
    A_HotkeyInterval := 0
    
    While (AutoclickerRunning && (Globals["Settings"]["Autoclicker"]["ClickAmount"] == 0 || Globals["Settings"]["Autoclicker"]["ClickCounter"] < Globals["Settings"]["Autoclicker"]["ClickAmount"])) {
        MouseLeftClick()
        Globals["Settings"]["Autoclicker"]["ClickCounter"]++
        HyperSleep(Globals["Settings"]["Autoclicker"]["ClickInterval"])
    }
    
    A_HotkeyInterval := IntervalTemp
    
    ClickIntervalEdit.Enabled := True
    ClickAmountEdit.Enabled := True
    AutoclickerHotkeyButton.Enabled := True
    
    Globals["Settings"]["Autoclicker"]["ClickCounter"] := 0
    
    SetAllGuiValues()
}