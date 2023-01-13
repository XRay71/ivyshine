EditHotkeysGui := Gui("+Border -SysMenu -Resize" (Globals["GUI"]["Settings"]["AlwaysOnTop"] ? " +AlwaysOnTop" : " -AlwaysOnTop") " +Owner" IvyshineGui.Hwnd, "Edit Hotkeys")
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
    Global Globals
    Global ShowEditHotkeysGui
    ShowEditHotkeysGui := 0
    EditHotkeysGui.Hide()
    Try {
        Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro)
        Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro)
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro)
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick)
        Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], "On")
        Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], "On")
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], "On")
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], "On")
    }
}

SubmitEditHotkeys(*) {
    Global Globals
    Global EditHotkeysGui, IvyshineGui
    Global StartHotkeyHotkey, PauseHotkeyHotkey, StopHotkeyHotkey, AutoclickerHotkeyHotkey
    
    ThisControl := EditHotkeysGui.FocusedCtrl
    
    Try {
        Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], "Off")
        Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], "Off")
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], "Off")
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], "Off")
    }
    
    If (ThisControl.Hwnd == StartHotkeyHotkey.Hwnd) {
        If (StartHotkeyHotkey.Value == "" || StartHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["PauseHotkey"] || StartHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StopHotkey"] || StartHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
            Return
        
        Globals["Settings"]["Hotkeys"]["StartHotkey"] := StartHotkeyHotkey.Value
        IniWrite(Globals["Settings"]["Hotkeys"]["StartHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "StartHotkey")
        Global StartButton, StartHotkeyButton, IvyshineGui
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        StartButton.Text := Globals["Settings"]["Hotkeys"]["StartHotkey"]
        StartHotkeyButton.Text := " Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")"
        
    } Else If (ThisControl.Hwnd == PauseHotkeyHotkey.Hwnd) {
        If (PauseHotkeyHotkey.Value == "" || PauseHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StartHotkey"] || PauseHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StopHotkey"] || PauseHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
            Return
        Globals["Settings"]["Hotkeys"]["PauseHotkey"] := PauseHotkeyHotkey.Value
        IniWrite(Globals["Settings"]["Hotkeys"]["PauseHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "PauseHotkey")
        Global PauseButton, PauseHotkeyButton, IvyshineGui
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        PauseButton.Text := Globals["Settings"]["Hotkeys"]["PauseHotkey"]
        PauseHotkeyButton.Text := " Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")"
    } Else If (ThisControl.Hwnd == StopHotkeyHotkey.Hwnd) {
        If (StopHotkeyHotkey.Value == "" || StopHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["PauseHotkey"] || StopHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StartHotkey"] || StopHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"])
            Return
        Globals["Settings"]["Hotkeys"]["StopHotkey"] := StopHotkeyHotkey.Value
        IniWrite(Globals["Settings"]["Hotkeys"]["StopHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "StopHotkey")
        Global StopButton, StopHotkeyButton, IvyshineGui
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        StopButton.Text := Globals["Settings"]["Hotkeys"]["StopHotkey"]
        StopHotkeyButton.Text := " Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")"
    } Else If (ThisControl.Hwnd == AutoclickerHotkeyHotkey.Hwnd) {
        If (AutoclickerHotkeyHotkey.Value == "" || AutoclickerHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["PauseHotkey"] || AutoclickerHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StartHotkey"] || AutoclickerHotkeyHotkey.Value == Globals["Settings"]["Hotkeys"]["StopHotkey"])
            Return
        Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"] := AutoclickerHotkeyHotkey.Value
        IniWrite(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", "AutoclickerHotkey")
        Global AutoclickerHotkeyButton, IvyshineGui
        
        IvyshineGui.SetFont()
        IvyshineGui.SetFont("s8", "Calibri")
        AutoclickerHotkeyButton.Text := "Hotkey: " Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"]
    }
    
    Try {
        Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro)
        Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro)
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro)
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick)
        Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], "On")
        Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], "On")
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], "On")
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], "On")
    }
    
    EditHotkeysGuiClose()
}