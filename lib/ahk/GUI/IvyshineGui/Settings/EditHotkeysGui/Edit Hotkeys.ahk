EditHotkeysGui := Gui("+Border -SysMenu -Resize" (Globals["Settings"]["GUI"]["AlwaysOnTop"] ? " +AlwaysOnTop" : " -AlwaysOnTop") " +Owner" IvyshineGui.Hwnd, "Edit Hotkeys")
EditHotkeysGui.OnEvent("Close", EditHotkeysGuiClose)
EditHotkeysGui.OnEvent("Escape", EditHotkeysGuiClose)

EditHotkeysGui.MarginX := 10
EditHotkeysGui.MarginY := 4

EditHotkeysGui.SetFont()
EditHotkeysGui.SetFont("s10", "Calibri")

EditHotkeysText := EditHotkeysGui.Add("Text", "w300 h20 +BackgroundTrans vEditHotkeysText", "Editing Start Hotkey (enter to submit):")

StartHotkeyHotkey := EditHotkeysGui.Add("Hotkey", "wp hp -Wrap Hidden vStartHotkeyHotkey", Globals["Settings"]["Hotkeys"]["StartHotkey"])

PauseHotkeyHotkey := EditHotkeysGui.Add("Hotkey", "xp yp wp hp -Wrap Hidden vPauseHotkeyHotkey", Globals["Settings"]["Hotkeys"]["PauseHotkey"])

StopHotkeyHotkey := EditHotkeysGui.Add("Hotkey", "xp yp wp hp -Wrap Hidden vStopHotkeyHotkey", Globals["Settings"]["Hotkeys"]["StopHotkey"])

AutoclickerHotkeyHotkey := EditHotkeysGui.Add("Hotkey", "xp yp wp hp -Wrap Hidden vAutoclickerHotkeyHotkey", Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])

EditHotkeysGuiDefaultButton := EditHotkeysGui.Add("Button", "x0 y0 w1 h1 -Wrap Default Hidden vEditHotkeysGuiDefaultButton")
EditHotkeysGuiDefaultButton.OnEvent("Click", SubmitEditHotkeys)

EditHotkeysGui.Show("Hide Center AutoSize")
EditHotkeysGui.Opt("+LastFound")
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", WinExist(), "Ptr", 0)

EditHotkeysGuiClose(*) {
    Global ShowEditHotkeysGui
    ShowEditHotkeysGui := 0
    EditHotkeysGui.Hide()
    Try {
        Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "On T1 P0 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "On T1 P0 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "On T1 P20 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "On T2 P1 S0")
        TrayMenu.Enable("12&")
        TrayMenu.Enable("13&")
        TrayMenu.Enable("14&")
        StartButton.Enabled := 1
        PauseButton.Enabled := 1
        StopButton.Enabled := 1
    }
}

SubmitEditHotkeys(*) {
    ThisControl := EditHotkeysGui.FocusedCtrl
    
    Try {
        For Key in Globals["Settings"]["Hotkeys"]
            Hotkey(Key, "Off")
        StartButton.Enabled := 0
        PauseButton.Enabled := 0
        StopButton.Enabled := 0
    }
    
    If (ThisControl.Hwnd == StartHotkeyHotkey.Hwnd) {
        If (StartHotkeyHotkey.Value == "" || StartHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["PauseHotkey"] || StartHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StopHotkey"] || StartHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
            Return
        Globals["Settings"]["Hotkeys"]["StartHotkey"] := StartHotkeyHotkey.Value
        TrayMenu.Rename("12&", "Start Macro (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")")
        IniWrite(Globals["Settings"]["Hotkeys"]["StartHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "StartHotkey")
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        StartButton.Text := Globals["Settings"]["Hotkeys"]["StartHotkey"]
        StartHotkeyButton.Text := " Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")"
    } Else If (ThisControl.Hwnd == PauseHotkeyHotkey.Hwnd) {
        If (PauseHotkeyHotkey.Value == "" || PauseHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StartHotkey"] || PauseHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StopHotkey"] || PauseHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
            Return
        Globals["Settings"]["Hotkeys"]["PauseHotkey"] := PauseHotkeyHotkey.Value
        TrayMenu.Rename("13&", "Pause Macro (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")")
        IniWrite(Globals["Settings"]["Hotkeys"]["PauseHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "PauseHotkey")
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        PauseButton.Text := Globals["Settings"]["Hotkeys"]["PauseHotkey"]
        PauseHotkeyButton.Text := " Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")"
    } Else If (ThisControl.Hwnd == StopHotkeyHotkey.Hwnd) {
        If (StopHotkeyHotkey.Value == "" || StopHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["PauseHotkey"] || StopHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StartHotkey"] || StopHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
            Return
        Globals["Settings"]["Hotkeys"]["StopHotkey"] := StopHotkeyHotkey.Value
        TrayMenu.Rename("14&", "Stop Macro (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")")
        IniWrite(Globals["Settings"]["Hotkeys"]["StopHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "StopHotkey")
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        StopButton.Text := Globals["Settings"]["Hotkeys"]["StopHotkey"]
        StopHotkeyButton.Text := " Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")"
    } Else If (ThisControl.Hwnd == AutoclickerHotkeyHotkey.Hwnd) {
        If (AutoclickerHotkeyHotkey.Value == "" || AutoclickerHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["PauseHotkey"] || AutoclickerHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StartHotkey"] || AutoclickerHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StopHotkey"])
            Return
        Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"] := AutoclickerHotkeyHotkey.Value
        IniWrite(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "AutoclickerHotkey")
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        AutoclickerHotkeyButton.Text := "Hotkey: " Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"]
    }
    
    Try {
        Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "On T1 P0 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "On T1 P0 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "On T1 P20 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "On T2 P1 S0")
        TrayMenu.Enable("12&")
        TrayMenu.Enable("13&")
        TrayMenu.Enable("14&")
        StartButton.Enabled := 1
        PauseButton.Enabled := 1
        StopButton.Enabled := 1
    }
    
    EditHotkeysGuiClose()
}