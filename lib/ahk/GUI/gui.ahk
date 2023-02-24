; create GUI object
IvyshineGui := Gui("-SysMenu -Resize +LastFound +OwnDialogs" (Globals["Settings"]["GUI"]["AlwaysOnTop"] ? " +AlwaysOnTop" : ""), "Ivyshine Macro")

WinSetTransparent(255 - Floor(Globals["Settings"]["GUI"]["Transparency"] * 2.55))

IvyshineGui.OnEvent("Close", ExitMacro)
IvyshineGui.OnEvent("Escape", IvyshineGuiMinimize)

IvyshineGui.MarginX := 4
IvyshineGui.MarginY := 4

IvyshineGui.SetFont()
IvyshineGui.SetFont("s7", "Calibri")

StartButton := IvyshineGui.Add("Button", "x397 y351 w38 h18 Center vStartButton", Globals["Settings"]["Hotkeys"]["StartHotkey"])
StartButton.OnEvent("Click", StartMacro)

PauseButton := IvyshineGui.Add("Button", "xp+38 yp wp hp Center vPauseButton Disabled", Globals["Settings"]["Hotkeys"]["PauseHotkey"])
PauseButton.OnEvent("Click", PauseMacro)

StopButton := IvyshineGui.Add("Button", "xp+38 yp wp hp Center vStopButton", Globals["Settings"]["Hotkeys"]["StopHotkey"])
StopButton.OnEvent("Click", StopMacro)

InfoButton := IvyshineGui.Add("Button", "xp+38 yp wp hp Center vInfoButton", "v" CurrentVersionID)
InfoButton.OnEvent("Click", ShowMacroInfo)

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8 Norm cBlack", "Calibri")
MainTabs := IvyshineGui.Add("Tab3", "x0 y20 w550 h350 vMainTabs Section -Wrap +0x8 +Bottom", ["Settings", "Fields", "Boost", "Mobs", "Quests", "Planters", "Status", "Boo"])
MainTabs.Choose(Globals["GUI"]["Settings"]["CurrentGUITab"])
MainTabs.OnEvent("Change", MainTabChanged)

#Include *i IvyshineGui\Settings.ahk
#Include *i IvyshineGui\Fields.ahk

MainTabs.UseTab()
IvyshineGui.Show("Hide Center AutoSize")
IvyshineGui.Opt("+LastFound")
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", IvyshineGui.Hwnd, "Ptr", 0)
MainTabChanged(MainTabs)

#Include *i MacroInfoGui\Macro Info.ahk
ShowMacroInfoGui := 0

IvyshineGui.Show("x" Globals["GUI"]["Position"]["GUIX"] " y" Globals["GUI"]["Position"]["GUIY"] " w550 h370")
WinActivate(IvyshineGui)

Try
MacroInfoGui.Show("Hide")
Catch Any
    MissingFilesError()

ShowMacroinfo(*) {
    Global ShowMacroInfoGui
    ShowMacroInfoGui := !ShowMacroInfoGui
    MacroInfoGui.Show(ShowMacroInfoGui ? "AutoSize" : "Hide")
}

MainTabChanged(MainTab, *) {
    Globals["GUI"]["Settings"]["CurrentGUITab"] := MainTab.Text
    IniWrite(Globals["GUI"]["Settings"]["CurrentGUITab"], Globals["Constants"]["ini FilePaths"]["GUI"], "Settings", "CurrentGUITab")
    
    If (Globals["GUI"]["Settings"]["CurrentGUITab"] == "Settings")
        SubmitSettingsButton.Opt("+Default")
    Else If (Globals["GUI"]["Settings"]["CurrentGUITab"] == "Fields")
        SubmitFieldsButton.Opt("+Default")
}

SetCueBanner(HWND, Text, Show := True)
{
    DllCall("user32\SendMessage", "ptr", HWND, "uint", 0x1501, "int", Show, "str", Text, "int")
}

GuiMoving := False
MouseX := MouseY := 0

StartMoveGui(*) {
    Global GuiMoving
    Global MouseX, MouseY
    If (!WinActive(IvyshineGui) || GuiMoving)
        Return
    MouseGetPos(&MouseX, &MouseY)
    If (MouseY >= 0 && MouseY <= 25) {
        CoordMode("Mouse", "Screen")
        MouseGetPos(&MouseX, &MouseY)
        CoordMode("Mouse", "Client")
        GuiMoving := True
        SetTimer(MoveGui, 1, 3)
    }
}

StopMoveGui(*) {
    Global GuiMoving
    GuiMoving := False
    SetTimer(MoveGui, 0)
    WinGetPos(&WinX, &WinY,,, IvyshineGui)
    Globals["GUI"]["Position"]["GUIX"] := WinX
    Globals["GUI"]["Position"]["GUIY"] := WinY
    IniWrite(Globals["GUI"]["Position"]["GUIX"], Globals["Constants"]["ini FilePaths"]["GUI"], "Position", "GuiX")
    IniWrite(Globals["GUI"]["Position"]["GUIX"], Globals["Constants"]["ini FilePaths"]["GUI"], "Position", "GuiY")
}

MoveGui() {
    Global MouseX, MouseY
    Global GuiMoving
    If (!GuiMoving || !GetKeyState("LButton")) {
        StopMoveGui()
        Return
    }
    OldMouseX := MouseX
    OldMouseY := MouseY
    CoordMode("Mouse", "Screen")
    MouseGetPos(&MouseX, &MouseY)
    CoordMode("Mouse", "Client")
    DiffMouseX := MouseX - OldMouseX
    DiffMouseY := MouseY - OldMouseY
    WinGetPos(&WinX, &WinY,,, IvyshineGui)
    WinMove(WinX + DiffMouseX, WinY + DiffMouseY,,, IvyshineGui)
}

IvyshineGui.SetFont()
IvyshineGui.SetFont("s10", "Calibri")
TitleText := IvyshineGui.Add("Text", "x0 y0 w550 h20 0x200 Center BackgroundSilver", "Ivyshine Macro")

UpdateTitleText() {
    TitleText.Text := (MacroRunning == 1 ?
    (A_IsSuspended ? "Ivyshine Macro (Hotkeys Suspended) (LOCKED WHILE RUNNING)" : "Ivyshine Macro (LOCKED WHILE RUNNING)")
    : MacroRunning == 2 ? (A_IsSuspended ? "Ivyshine Macro (Hotkeys Suspended) (PAUSED)" : "Ivyshine Macro (PAUSED)")
    : A_IsSuspended ? "Ivyshine Macro (Hotkeys Suspended)" : "Ivyshine Macro")
    GuiCloseButton.Redraw()
    GuiMinimizeButton.Redraw()
}

GuiCloseButton := IvyshineGui.Add("Button", "x530 y3 w15 h14 -TabStop -Border -Theme 0x200 Center vGuiCloseButton", "X")
GuiCloseButton.OnEvent("Click", ExitMacro)

GuiMinimizeButton := IvyshineGui.Add("Button", "x511 y3 w15 h14 -TabStop -Border -Theme 0x200 Center vGuiMinimizeButton", "-")
GuiMinimizeButton.OnEvent("Click", IvyshineGuiMinimize)

IvyshineGuiMinimize(*) {
    A_IconHidden := 0
    IvyshineGui.Hide()
    If (WinExist(EditHotkeysGui))
        EditHotkeysGuiClose()
    If (WinExist(MacroInfoGui))
        MacroInfoGuiClose()
    Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGuiRestore, "T1 P15 On")
}

IvyshineGuiRestore(*) {
    A_IconHidden := 1
    IvyshineGui.Show()
    StartButton.Enabled := (GuiOn ? (MacroRunning == 1 ? False : True) : False)
    PauseButton.Enabled := (GuiOn ? (MacroRunning == 2 || !MacroRunning ? False : True) : False)
    Hotkey(Globals["Settings"]["Hotkeys"]["TrayHotkey"], IvyshineGuiMinimize, "T1 P15 On")
}

GuiOn := True

GuiSwitch(*) {
    Global GuiOn
    GuiOn := !GuiOn
    
    StartButton.Enabled := (GuiOn ? (MacroRunning == 1 ? False : True) : False)
    PauseButton.Enabled := (GuiOn ? (MacroRunning == 2 || !MacroRunning ? False : True) : False)
    StopButton.Enabled := GuiOn
    GuiCloseButton.Enabled := GuiOn
    GuiMinimizeButton.Enabled := GuiOn
    InfoButton.Enabled := GuiOn
}

GuiMasterSwitch(*) {
    If (WinExist(EditHotkeysGui))
        EditHotkeysGuiClose()
    If (WinExist(MacroInfoGui))
        MacroInfoGuiClose()
    SettingsTabSwitch()
    FieldsTabSwitch()
}

SetAllGuiValues(*) {
    SetSettingsTabValues()
}
