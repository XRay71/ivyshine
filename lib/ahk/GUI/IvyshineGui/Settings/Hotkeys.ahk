IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 ys+205 w132 h90 Section", "Hotkeys")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

HotkeysListBox := IvyshineGui.Add("ListBox", "xs ys+4 wp-3 h60 0x100", ["Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")", "Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")", "Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")", "Autoclicker (" Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"] ")", "Tray (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")", "Debug (" Globals["Settings"]["Hotkeys"]["DebugHotkey"] ")", "Suspend (" Globals["Settings"]["Hotkeys"]["SuspendHotkey"] ")"])
HotkeysListBox.OnEvent("Change", StartEditHotkeys)

HotkeysInfoButton := IvyshineGui.Add("Button", "xs+49 ys-19 h16 w15 vHotkeysInfoButton", "?")
HotkeysInfoButton.OnEvent("Click", ShowHotkeysInfo)

ShowHotkeysInfo(*) {
    MsgBox("Click on a hotkey in the listbox to edit it!`r`n`r`nSYMBOL MEANINGS:`r`n^: Ctrl`r`n+: Shift`r`n!: Alt`r`n#: Windows Key"
        , "Hotkey Information"
        , "Icon? Owner" IvyshineGui.Hwnd)
}

CurrentlyEditedHotkey := ""

StartEditHotkeys(ThisControl, *) {
    If (MacroRunning == 1)
        Return
    
    Global CurrentlyEditedHotkey, ShowEditHotkeysGui
    
    If (!CurrentlyEditedHotkey || HotkeysListBox.Text == CurrentlyEditedHotkey)
        ShowEditHotkeysGui := !ShowEditHotkeysGui
    CurrentlyEditedHotkey := HotkeysListBox.Text
    For Key, Value in Globals["Settings"]["Hotkeys"]
        If (InStr(CurrentlyEditedHotkey, StrReplace(Key, "Hotkey"))) {
            EditHotkeysHotkey.Value := Value
            EditHotkeysText.Text := "Editing " Key ", press enter to submit:"
        }
    EditHotkeysHotkey.Focus()
    HotkeysListBox.Choose(0)
    If (ShowEditHotkeysGui){
        Try {
            For Key, Value in Globals["Settings"]["Hotkeys"]
                Hotkey(Value, "Off")
            StartButton.Enabled := 0
            PauseButton.Enabled := 0
            StopButton.Enabled := 0
        }
        EditHotkeysGui.Show("AutoSize NoActivate")
    } Else {
        EditHotkeysGuiClose()
        CurrentlyEditedHotkey := ""
    }
}