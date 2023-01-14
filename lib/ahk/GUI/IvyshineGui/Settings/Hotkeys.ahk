IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 y+3 w132 h90 Section", "Hotkeys")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

StartHotkeyButton := IvyshineGui.Add("Button", "xs ys+6 wp-3 h20 Left -Wrap vStartHotkeyButton", " Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")")
StartHotkeyButton.OnEvent("Click", StartEditHotkeys)

PauseHotkeyButton := IvyshineGui.Add("Button", "xs yp+20 wp h20 Left -Wrap vPauseHotkeyButton", " Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")")
PauseHotkeyButton.OnEvent("Click", StartEditHotkeys)

StopHotkeyButton := IvyshineGui.Add("Button", "xs yp+20 wp h20 Left -Wrap vStopHotkeyButton", " Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")")
StopHotkeyButton.OnEvent("Click", StartEditHotkeys)

HotkeysInfoButton := IvyshineGui.Add("Button", "xs+49 ys-19 h16 w15", "?")
HotkeysInfoButton.OnEvent("Click", ShowHotkeysInfo)

ShowHotkeysInfo(*) {
    MsgBox("^: Ctrl`r`n+: Shift`r`n!: Alt`r`n#: Windows Key", "Hotkey Symbol Information", "Icon? Owner" IvyshineGui.Hwnd)
}

PreviousEditHotkeysControl := ""

StartEditHotkeys(ThisControl, *) {
    Global Globals
    Global ShowEditHotkeysGui, PreviousEditHotkeysControl
    Global StartHotkeyButton, PauseHotkeyButton, StopHotkeyButton, AutoclickerHotkeyButton
    Global StartHotkeyHotkey, PauseHotkeyHotkey, StopHotkeyHotkey, AutoclickerHotkeyHotkey, EditHotkeysText
    
    If (ThisControl.Hwnd == StartHotkeyButton.Hwnd) {
        StartHotkeyHotkey.Visible := 1
        StartHotkeyHotkey.Value := Globals["Settings"]["Hotkeys"]["StartHotkey"]
        StartHotkeyHotkey.Focus()
        PauseHotkeyHotkey.Visible := 0
        StopHotkeyHotkey.Visible := 0
        AutoclickerHotkeyHotkey.Visible := 0
        EditHotkeysText.Text := "Editing the Start Hotkey (press enter to submit):"
    } Else If (ThisControl.Hwnd == PauseHotkeyButton.Hwnd) {
        StartHotkeyHotkey.Visible := 0
        PauseHotkeyHotkey.Visible := 1
        PauseHotkeyHotkey.Value := Globals["Settings"]["Hotkeys"]["PauseHotkey"]
        PauseHotkeyHotkey.Focus()
        StopHotkeyHotkey.Visible := 0
        AutoclickerHotkeyHotkey.Visible := 0
        EditHotkeysText.Text := "Editing the Pause Hotkey (press enter to submit):"
    } Else If (ThisControl.Hwnd == StopHotkeyButton.Hwnd) {
        StartHotkeyHotkey.Visible := 0
        PauseHotkeyHotkey.Visible := 0
        StopHotkeyHotkey.Visible := 1
        StopHotkeyHotkey.Value := Globals["Settings"]["Hotkeys"]["StopHotkey"]
        StopHotkeyHotkey.Focus()
        AutoclickerHotkeyHotkey.Visible := 0
        EditHotkeysText.Text := "Editing the Stop Hotkey (press enter to submit):"
    } Else If (ThisControl.Hwnd == AutoclickerHotkeyButton.Hwnd) {
        StartHotkeyHotkey.Visible := 0
        PauseHotkeyHotkey.Visible := 0
        StopHotkeyHotkey.Visible := 0
        AutoclickerHotkeyHotkey.Visible := 1
        AutoclickerHotkeyHotkey.Value := Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"]
        AutoclickerHotkeyHotkey.Focus()
        EditHotkeysText.Text := "Editing the Autoclicker Hotkey (press enter to submit):"
    }
    
    If (!PreviousEditHotkeysControl || ThisControl.Hwnd == PreviousEditHotkeysControl.Hwnd) {
        ShowEditHotkeysGui := !ShowEditHotkeysGui
        If (ShowEditHotkeysGui){
            Try {
                Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], "Off")
                Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], "Off")
                Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], "Off")
                Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], "Off")
            }
            EditHotkeysGui.Show("AutoSize NoActivate")
        } Else {
            Try {
                Hotkey(Globals["Settings"]["Hotkeys"]["StartHotkey"], StartMacro, "On T1")
                Hotkey(Globals["Settings"]["Hotkeys"]["PauseHotkey"], PauseMacro, "On T1")
                Hotkey(Globals["Settings"]["Hotkeys"]["StopHotkey"], StopMacro, "On T1")
                Hotkey(Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"], Autoclick, "On T2 P1")
            }
            EditHotkeysGui.Hide()
        }
    }
    
    PreviousEditHotkeysControl := ThisControl
}