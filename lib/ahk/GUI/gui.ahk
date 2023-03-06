; create GUI object
IvyshineGUI := Gui("-SysMenu -Resize +LastFound +OwnDialogs", "Ivyshine Macro")
IvyshineGUI.OnEvent("Close", ExitMacro)
IvyshineGUI.OnEvent("Escape", IvyshineGUIMinimise)
IvyshineGUI.MarginX := 4
IvyshineGUI.MarginY := 4
IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s7", "Calibri")
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", IvyshineGUI.Hwnd, "Ptr", 0)
IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s10", "Calibri")
TitleText := IvyshineGUI.Add("Text", "x0 y0 w550 h20 0x200 Center BackgroundSilver", "Ivyshine Macro")

UpdateTitleText() {
    TitleText.Text := (MacroState == 1 ?
    (A_IsSuspended ? "Ivyshine Macro (Hotkeys Suspended) (LOCKED WHILE RUNNING)" : "Ivyshine Macro (LOCKED WHILE RUNNING)")
    : MacroState == 2 ? (A_IsSuspended ? "Ivyshine Macro (Hotkeys Suspended) (PAUSED)" : "Ivyshine Macro (PAUSED)")
    : A_IsSuspended ? "Ivyshine Macro (Hotkeys Suspended)" : "Ivyshine Macro")
    GUICloseButton.Redraw()
    GUIMinimiseButton.Redraw()
}

GUICloseButton := IvyshineGUI.Add("Button", "x530 y3 w15 h14 -TabStop -Border -Theme 0x200 Center vGUICloseButton", "X")
GUICloseButton.OnEvent("Click", ExitMacro)

GUIMinimiseButton := IvyshineGUI.Add("Button", "x511 y3 w15 h14 -TabStop -Border -Theme 0x200 Center vGUIMinimiseButton", "-")
GUIMinimiseButton.OnEvent("Click", IvyshineGUIMinimise)

IvyshineGUIMinimise(*) {
    A_IconHidden := 0
    IvyshineGUI.Hide()
    If (WinExist(EditHotkeysGUI))
        EditHotkeysGUIClose()
    If (WinExist(MacroInfoGUI))
        MacroInfoGUIClose()
    Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGUIRestore, "T1 P15 On")
}

IvyshineGUIRestore(*) {
    A_IconHidden := 1
    IvyshineGUI.Show()
    StartButton.Enabled := (GUIOn ? (MacroState == 1 ? False : True) : False)
    PauseButton.Enabled := (GUIOn ? (MacroState == 2 || !MacroState ? False : True) : False)
    Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGUIMinimise, "T1 P15 On")
}

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s7", "Calibri")

StartButton := IvyshineGUI.Add("Button", "x397 y351 w38 h18 Center vStartButton")
StartButton.OnEvent("Click", StartMacro)

PauseButton := IvyshineGUI.Add("Button", "xp+38 yp wp hp Center vPauseButton Disabled")
PauseButton.OnEvent("Click", PauseMacro)

StopButton := IvyshineGUI.Add("Button", "xp+38 yp wp hp Center vStopButton")
StopButton.OnEvent("Click", StopMacro)

InfoButton := IvyshineGUI.Add("Button", "xp+38 yp wp hp Center vInfoButton")
InfoButton.OnEvent("Click", ShowMacroInfo)

ShowMacroinfo(*) {
    Global ShowMacroInfoGUI
    ShowMacroInfoGUI := !ShowMacroInfoGUI
    MacroInfoGUI.Show(ShowMacroInfoGUI ? "AutoSize" : "Hide")
}

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8 Norm cBlack", "Calibri")
MainTabs := IvyshineGUI.Add("Tab3", "x0 y20 w550 h350 vMainTabs Section -Wrap +0x8 +Bottom", ["Settings", "Fields", "Boost", "Mobs", "Quests", "Planters", "Status", "Boo"])
MainTabs.OnEvent("Change", MainTabChanged)

MainTabChanged(MainTab, *) {
    Globals["GUI"]["Settings"]["CurrentGUITab"] := MainTab.Text
    IniWrite(Globals["GUI"]["Settings"]["CurrentGUITab"], Globals["Constants"]["ini FilePaths"]["GUI"], "Settings", "CurrentGUITab")
    Submit%Globals["GUI"]["Settings"]["CurrentGUITab"]%Button.Opt("+Default")
}

#Include *i IvyshineGUI\Settings.ahk
#Include *i IvyshineGUI\Fields.ahk

#Include *i MacroInfoGUI\Macro Info.ahk
ShowMacroInfoGUI := 0

Try {
    SetAllGUIValues()
    MacroInfoGUI.Show("Hide")
} Catch Any
    MissingFilesError()

IvyshineGUI.Show("x" Globals["GUI"]["Position"]["GUIX"] " y" Globals["GUI"]["Position"]["GUIY"] " w550 h370")
WinActivate(IvyshineGUI)

SetCueBanner(HWND, Text, Show := True)
{
    DllCall("user32\SendMessage", "ptr", HWND, "uint", 0x1501, "int", Show, "str", Text, "int")
}

GUIOn := True

GUISwitch(*) {
    Global GUIOn
    GUIOn := !GUIOn
    
    StartButton.Enabled := (GUIOn ? (MacroState == 1 ? False : True) : False)
    PauseButton.Enabled := (GUIOn ? (MacroState == 2 || !MacroState ? False : True) : False)
    StopButton.Enabled := GUIOn
    GUICloseButton.Enabled := GUIOn
    GUIMinimiseButton.Enabled := GUIOn
    InfoButton.Enabled := GUIOn
}

SetGUIValues(*) {
    UpdateTitleText()
    IvyshineGUI.Opt(Globals["Settings"]["GUI"]["AlwaysOnTop"] ? "+AlwaysOnTop" : "-AlwaysOnTop")
    WinSetTransparent(255 - Floor(Globals["Settings"]["GUI"]["Transparency"] * 2.55), IvyshineGUI)
    MainTabs.Choose(Globals["GUI"]["Settings"]["CurrentGUITab"])
    MainTabChanged(MainTabs)
    StartButton.Text := Globals["Settings"]["Hotkeys"]["StartHotkey"]
    PauseButton.Text := Globals["Settings"]["Hotkeys"]["PauseHotkey"]
    StopButton.Text := Globals["Settings"]["Hotkeys"]["StopHotkey"]
    InfoButton.Text := "v" CurrentVersionID
}

GUIMasterSwitch(*) {
    If (WinExist(EditHotkeysGUI))
        EditHotkeysGUIClose()
    If (WinExist(MacroInfoGUI))
        MacroInfoGUIClose()
    SettingsTabSwitch()
    FieldsTabSwitch()
}

SetAllGUIValues(*) {
    SetGUIValues()
    SetSettingsTabValues()
}
