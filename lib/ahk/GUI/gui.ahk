IvyshineGui := Gui("-SysMenu -Resize" (Globals["GUI"]["Settings"]["AlwaysOnTop"] ? " +AlwaysOnTop" : " -AlwaysOnTop"), "Ivyshine Macro")
IvyshineGui.Opt("+LastFound")
WinSetTransparent(255 - Floor(Globals["GUI"]["Settings"]["Transparency"] * 2.55))
IvyshineGui.OnEvent("Close", IvyshineGuiClose)
IvyshineGui.OnEvent("Escape", IvyshineGuiClose)

IvyshineGui.MarginX := 4
IvyshineGui.MarginY := 4

IvyshineGui.SetFont()
IvyshineGui.SetFont("s7", "Calibri")

StartButton := IvyshineGui.Add("Button", "x390 y349 w40 h20 Center vStartButton", Globals["Settings"]["Hotkeys"]["StartHotkey"])
StartButton.OnEvent("Click", StartMacro)

PauseButton := IvyshineGui.Add("Button", "xp+40 yp wp hp Center vPauseButton", Globals["Settings"]["Hotkeys"]["PauseHotkey"])
PauseButton.OnEvent("Click", PauseMacro)

StopButton := IvyshineGui.Add("Button", "xp+40 yp wp hp Center vStopButton", Globals["Settings"]["Hotkeys"]["StopHotkey"])
StopButton.OnEvent("Click", StopMacro)

InfoButton := IvyshineGui.Add("Button", "x510 yp wp hp Center vInfoButton", "v" CurrentVersionID)
InfoButton.OnEvent("Click", ShowMacroInfo)

IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
MainTabs := IvyshineGui.Add("Tab3", "x0 y20 w550 h350 vMainTabs -Wrap +0x8 +Bottom", ["Settings", "Fields", "Boost", "Mobs", "Quests", "Planters", "Status"])
MainTabs.Choose(Integer(Globals["GUI"]["Settings"]["CurrentGUITab"]))
MainTabs.OnEvent("Change", MainTabChanged)

#Include *i IvyshineGui\Settings.ahk

MainTabs.UseTab()
IvyshineGui.Show("Hide Center AutoSize")
IvyshineGui.Opt("+LastFound")
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", WinExist(), "Ptr", 0)

IvyshineGui.Show("x" Globals["GUI"]["Position"]["GUIX"] " y" Globals["GUI"]["Position"]["GUIY"] " w550 h370")

IvyshineGuiClose(*) {
    Global Globals, IvyshineGui
    RestoreFPSUnlocker()
    WinGetPos(&GuiX, &GuiY,,, IvyshineGui.Hwnd)
    Globals["GUI"]["Position"]["GUIX"] := GuiX
    Globals["GUI"]["Position"]["GUIY"] := GuiY
    For ini, Section in Globals
        UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
    HyperSleep(50)
    ExitApp
}

#Include *i MacroInfoGui\Macro Info.ahk
ShowMacroInfoGui := 0

Try
MacroInfoGui.Show("Hide")
Catch Any
    MissingFilesError()

ShowMacroinfo(*) {
    Global ShowMacroInfoGui
    ShowMacroInfoGui := !ShowMacroInfoGui
    If (ShowMacroInfoGui)
        MacroInfoGui.Show("AutoSize")
    Else
        MacroInfoGui.Hide()
}

MainTabChanged(MainTab, *) {
    Global Globals
    Globals["GUI"]["Settings"]["CurrentGUITab"] := MainTab.Value
    IniWrite(Globals["GUI"]["Settings"]["CurrentGUITab"], Globals["Constants"]["ini FilePaths"]["GUI"], "Settings", "CurrentGUITab")
    
    Global SubmitSettingsButton
    If (Globals["GUI"]["Settings"]["CurrentGUITab"] == "Settings")
        SubmitSettingsButton.Opt("+Default")
}

SetCueBanner(HWND, Text, Show := True)
{
    DllCall("user32\SendMessage", "ptr", HWND, "uint", 0x1501, "int", Show, "str", Text, "int")
}

GuiMoving := False
MouseX := MouseY := 0

StartMoveGui(*) {
    Global Globals, IvyshineGui, GuiMoving
    Global MouseX, MouseY
    If (!WinActive(IvyshineGui.Hwnd) || GuiMoving)
        Return
    MouseGetPos(&MouseX, &MouseY)
    If (MouseY >= 0 && MouseY <= 25) {
        CoordMode("Mouse", "Screen")
        MouseGetPos(&MouseX, &MouseY)
        CoordMode("Mouse", "Client")
        GuiMoving := True
        SetTimer(MoveGui, 15, 3)
    }
}

StopMoveGui(*) {
    Global Globals, IvyshineGui, GuiMoving
    GuiMoving := False
    SetTimer(MoveGui, 0)
    WinGetPos(&WinX, &WinY,,, IvyshineGui.Hwnd)
    Globals["GUI"]["Position"]["GUIX"] := WinX
    Globals["GUI"]["Position"]["GUIY"] := WinY
    IniWrite(Globals["GUI"]["Position"]["GUIX"], Globals["Constants"]["ini FilePaths"]["GUI"], "Settings", "GuiX")
    IniWrite(Globals["GUI"]["Position"]["GUIX"], Globals["Constants"]["ini FilePaths"]["GUI"], "Settings", "GuiY")
}

MoveGui() {
    Global IvyshineGui
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
    WinGetPos(&WinX, &WinY,,, IvyshineGui.Hwnd)
    WinMove(WinX + DiffMouseX, WinY + DiffMouseY,,, IvyshineGui.Hwnd)
}

IvyshineGui.SetFont()
IvyshineGui.SetFont("s10", "Calibri")
IvyshineGui.Add("Text", "x0 y0 w550 h20 0x200 Center BackgroundSilver", "Ivyshine Macro")

GuiCloseButton := IvyshineGui.Add("Button", "x530 y3 w15 h14 -TabStop -Border -Theme 0x200 Center vGuiCloseButton", "X")
GuiCloseButton.OnEvent("Click", IvyshineGuiClose)

GuiMinimizeButton := IvyshineGui.Add("Button", "x511 y3 w15 h14 -TabStop -Border -Theme 0x200 Center vGuiMinimizeButton", "-")
GuiMinimizeButton.OnEvent("Click", IvyshineGuiMinimize)

IvyshineGuiMinimize(*) {
    A_IconHidden := 0
    IvyshineGui.Hide()
    EditHotkeysGuiClose()
    MacroInfoGuiClose()
    Global PreviousEditHotkeysControl
    PreviousEditHotkeysControl := ""
    Hotkey("F5", IvyshineGuiRestore, "T1 P10 On")
}

IvyshineGuiRestore(*) {
    A_IconHidden := 1
    IvyshineGui.Show()
    Hotkey("F5", IvyshineGuiMinimize, "T1 P10 On")
}

DisableGui(*) {
    Global 
}