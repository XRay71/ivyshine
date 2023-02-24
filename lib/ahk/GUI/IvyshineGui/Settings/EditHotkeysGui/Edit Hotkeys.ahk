EditHotkeysGui := Gui("+Border -SysMenu -Resize" (Globals["Settings"]["GUI"]["AlwaysOnTop"] ? " +AlwaysOnTop" : " -AlwaysOnTop") " +Owner" IvyshineGui.Hwnd, "Edit Hotkeys")
EditHotkeysGui.OnEvent("Close", EditHotkeysGuiClose)
EditHotkeysGui.OnEvent("Escape", EditHotkeysGuiClose)

EditHotkeysGui.MarginX := 10
EditHotkeysGui.MarginY := 4

EditHotkeysGui.SetFont()
EditHotkeysGui.SetFont("s10", "Calibri")

EditHotkeysText := EditHotkeysGui.Add("Text", "w300 h20 +BackgroundTrans vEditHotkeysText", "Editing Start Hotkey (enter to submit):")

EditHotkeysHotkey := EditHotkeysGui.Add("Hotkey", "wp hp -Wrap vEditHotkeysHotkey")

EditHotkeysGuiDefaultButton := EditHotkeysGui.Add("Button", "x0 y0 w1 h1 -Wrap Default Hidden vEditHotkeysGuiDefaultButton")
EditHotkeysGuiDefaultButton.OnEvent("Click", SubmitEditHotkeys)

EditHotkeysGui.Show("Hide Center AutoSize")
EditHotkeysGui.Opt("+LastFound")
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", WinExist(), "Ptr", 0)

EditHotkeysGuiClose(*) {
    Global ShowEditHotkeysGui, CurrentlyEditedHotkey
    ShowEditHotkeysGui := 0
    CurrentlyEditedHotkey := ""
    EditHotkeysGui.Hide()
    Try {
        If (MacroRunning != 1)
            Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "On T" (MacroRunning == 2 ? "2" : "1") " P0 S0")
        If (MacroRunning == 1)
            Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "On T1 P0 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "On T1 P20 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "On T2 P1 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGuiMinimize, "On T1 P15 S")
        Hotkey(Globals["Settings"]["Hotkeys"]["DebugHotkey"], OpenDebug, "On T1 P15 S0")
        Hotkey(Globals["Settings"]["Hotkeys"]["SuspendHotkey"], SuspendHotkeys, "On T1 P15 S")
        StartButton.Enabled := MacroRunning != 1
        PauseButton.Enabled := MacroRunning == 1
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
            Globals["Settings"]["Hotkeys"][Key] := EditHotkeysHotkey.Value
            IniWrite(Globals["Settings"]["Hotkeys"][Key], Globals["Constants"]["ini FilePaths"]["Settings"], "Hotkeys", Key)
            IvyshineGui.SetFont()
            IvyshineGui.SetFont("s8", "Calibri")
            If (Key == "StartHotkey"){
                A_TrayMenu.Rename("12&", "Start Macro (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")")
                StartButton.Text := Globals["Settings"]["Hotkeys"]["StartHotkey"]
            }
            Else If (Key == "PauseHotkey"){
                A_TrayMenu.Rename("13&", "Pause Macro (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")")
                PauseButton.Text := Globals["Settings"]["Hotkeys"]["PauseHotkey"]
            }
            Else If (Key == "StopHotkey"){
                A_TrayMenu.Rename("14&", "Stop Macro (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")")
                StopButton.Text := Globals["Settings"]["Hotkeys"]["StopHotkey"]
            }
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
    
    EditHotkeysGuiClose()
}