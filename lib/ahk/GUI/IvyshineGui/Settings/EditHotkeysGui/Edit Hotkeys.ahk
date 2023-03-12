EditHotkeysGUI := Gui("+Border -SysMenu -Resize +Owner" IvyshineGUI.Hwnd, "Edit Hotkeys")
EditHotkeysGUI.OnEvent("Close", EditHotkeysGUIClose)
EditHotkeysGUI.OnEvent("Escape", EditHotkeysGUIClose)

EditHotkeysGUI.MarginX := 10
EditHotkeysGUI.MarginY := 4

EditHotkeysGUI.SetFont()
EditHotkeysGUI.SetFont("s10", "Calibri")

EditHotkeysText := EditHotkeysGUI.Add("Text", "w300 h20 +BackgroundTrans vEditHotkeysText", "Editing Start Hotkey (enter to submit):")

EditHotkeysHotkey := EditHotkeysGUI.Add("Hotkey", "wp hp -Wrap vEditHotkeysHotkey")

EditHotkeysGUIDefaultButton := EditHotkeysGUI.Add("Button", "x0 y0 w1 h1 -Wrap Default Hidden vEditHotkeysGUIDefaultButton")
EditHotkeysGUIDefaultButton.OnEvent("Click", SubmitEditHotkeys)

EditHotkeysGUI.Opt("+LastFound")
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", WinExist(), "Ptr", 0)

EditHotkeysGUIClose(*) {
    Global ShowEditHotkeysGUI, CurrentlyEditedHotkey
    ShowEditHotkeysGUI := 0
    CurrentlyEditedHotkey := ""
    EditHotkeysGUI.Hide()
    Try {
        If (MacroState != 1)
            Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "On T" (MacroState == 2 ? "2" : "1") " P0 S0")
        If (MacroState == 1)
            Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "On T1 P0 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "On T1 P100 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "On T2 P1 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGUIMinimise, "On T1 P20 S")
        Hotkey(Globals["Settings"]["Hotkeys"]["DebugHotkey"], OpenDebug, "On T1 P20 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["SuspendHotkey"], SuspendHotkeys, "On T1 P20 S")
        StartButton.Enabled := MacroState != 1
        PauseButton.Enabled := MacroState == 1
        StopButton.Enabled := 1
    }
}

SubmitEditHotkeys(*) {
    Global CurrentlyEditedHotkey
    For Key, Value in Globals["Settings"]["Hotkeys"]
        If (!EditHotkeysHotkey.Value || (Value == EditHotkeysHotkey.Value && !InStr(CurrentlyEditedHotkey, StrReplace(Key, "Hotkey"))) || !StrLen(StrReplace(StrReplace(StrReplace(EditHotkeysHotkey.Value, "+"), "!"), "^")))
            Return
    For Key, Value in Globals["Settings"]["Hotkeys"]
        If (InStr(CurrentlyEditedHotkey, StrReplace(Key, "Hotkey"))) {
            IniWrite(Globals["Settings"]["Hotkeys"][Key] := EditHotkeysHotkey.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", Key)
            IvyshineGUI.SetFont()
            IvyshineGUI.SetFont("s8", "Calibri")
            If (Key == "StartHotkey")
                A_TrayMenu.Rename("12&", "Start Macro (" (StartButton.Text := Globals["Settings"]["Hotkeys"]["StartHotkey"]) ")")
            Else If (Key == "PauseHotkey")
                A_TrayMenu.Rename("13&", "Pause Macro (" (PauseButton.Text := Globals["Settings"]["Hotkeys"]["PauseHotkey"]) ")")
            Else If (Key == "StopHotkey")
                A_TrayMenu.Rename("14&", "Stop Macro (" (StopButton.Text := Globals["Settings"]["Hotkeys"]["StopHotkey"]) ")")
            Else If (Key == "TrayHotkey")
                A_TrayMenu.Rename("4&", "Restore GUI (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")")
            Else If (Key == "DebugHotkey")
                A_TrayMenu.Rename("8&", "Open Logs (" Globals["Settings"]["Hotkeys"]["DebugHotkey"] ")")
            Else If (Key == "SuspendHotkey")
                A_TrayMenu.Rename("10&", "Suspend Hotkeys (" Globals["Settings"]["Hotkeys"]["SuspendHotkey"] ")")
            Break
        }
    HotkeysListBox.Delete()
    HotkeysListBox.Add(["Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")", "Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")", "Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")", "Autoclicker (" Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"] ")", "Tray (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")", "Debug (" Globals["Settings"]["Hotkeys"]["DebugHotkey"] ")", "Suspend (" Globals["Settings"]["Hotkeys"]["SuspendHotkey"] ")"])
    
    EditHotkeysGUIClose()
}