IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs-8 ys+203 w132 h92 Section", "Hotkeys")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

HotkeysListBox := IvyshineGUI.Add("ListBox", "xs ys+4 wp-3 h62 0x100", ["Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")", "Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")", "Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")", "Autoclicker (" Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"] ")", "Tray (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")", "Debug (" Globals["Settings"]["Hotkeys"]["DebugHotkey"] ")", "Suspend (" Globals["Settings"]["Hotkeys"]["SuspendHotkey"] ")"])
HotkeysListBox.OnEvent("Change", StartEditHotkeys)

HotkeysInfoButton := IvyshineGUI.Add("Button", "xs+49 ys-19 h16 w15 vHotkeysInfoButton", "?")
HotkeysInfoButton.OnEvent("Click", ShowHotkeysInfo)

ShowHotkeysInfo(*) {
    MsgBox("Click on a hotkey in the listbox to edit it!`r`n`r`nSYMBOL MEANINGS:`r`n^: Ctrl`r`n+: Shift`r`n!: Alt`r`n#: Windows Key"
        , "Hotkey Information"
        , "Icon? Owner" IvyshineGUI.Hwnd)
}

CurrentlyEditedHotkey := ""

StartEditHotkeys(ThisControl, *) {
    If (MacroRunning == 1)
        Return
    
    Global CurrentlyEditedHotkey, ShowEditHotkeysGUI
    
    If (!CurrentlyEditedHotkey || HotkeysListBox.Text == CurrentlyEditedHotkey)
        ShowEditHotkeysGUI := !ShowEditHotkeysGUI
    CurrentlyEditedHotkey := HotkeysListBox.Text
    For Key, Value in Globals["Settings"]["Hotkeys"]
        If (InStr(CurrentlyEditedHotkey, StrReplace(Key, "Hotkey"))) {
            EditHotkeysHotkey.Value := Value
            EditHotkeysText.Text := "Editing " Key ", press enter to submit:"
        }
    EditHotkeysHotkey.Focus()
    HotkeysListBox.Choose(0)
    If (ShowEditHotkeysGUI){
        Try {
            For Key, Value in Globals["Settings"]["Hotkeys"]
                Hotkey(Value, "Off")
            StartButton.Enabled := 0
            PauseButton.Enabled := 0
            StopButton.Enabled := 0
        }
        EditHotkeysGUI.Show("AutoSize NoActivate")
    } Else {
        EditHotkeysGUIClose()
        CurrentlyEditedHotkey := ""
    }
}