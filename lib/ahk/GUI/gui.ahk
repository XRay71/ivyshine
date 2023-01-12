IvyshineGui := Gui("-SysMenu -Resize" (Globals["GUI"]["Settings"]["AlwaysOnTop"] ? " +AlwaysOnTop" : " -AlwaysOnTop"), "Ivyshine Macro")
IvyshineGui.OnEvent("Close", IvyshineGuiClose)
IvyshineGui.OnEvent("Escape", IvyshineGuiClose)

IvyshineGui.MarginX := 4
IvyshineGui.MarginY := 4

IvyshineGui.SetFont()
IvyshineGui.SetFont("s7", "Calibri")

StartButton := IvyshineGui.Add("Button", "x390 y328 w40 h20 Center vStartButton", Globals["Settings"]["Hotkeys"]["StartHotkey"])
StartButton.OnEvent("Click", StartMacro)

PauseButton := IvyshineGui.Add("Button", "xp+40 yp wp hp Center vPauseButton", Globals["Settings"]["Hotkeys"]["PauseHotkey"])
PauseButton.OnEvent("Click", PauseMacro)

StopButton := IvyshineGui.Add("Button", "xp+40 yp wp hp Center vStopButton", Globals["Settings"]["Hotkeys"]["StopHotkey"])
StopButton.OnEvent("Click", StopMacro)

InfoButton := IvyshineGui.Add("Button", "x510 yp wp hp Center vInfoButton", "v" CurrentVersionID)
InfoButton.OnEvent("Click", ShowMacroInfo)

IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
MainTabs := IvyshineGui.Add("Tab3", "x0 y0 w550 h350 vMainTabs -Wrap +0x8 +Bottom", ["Settings", "Fields", "Boost", "Mobs", "Quests", "Planters", "Status"])
MainTabs.Choose(Integer(Globals["GUI"]["Settings"]["CurrentGUITab"]))
MainTabs.OnEvent("Change", MainTabChanged)

#Include *i IvyshineGui\Settings.ahk

IvyshineGui.Show("x" Globals["GUI"]["Settings"]["GuiX"] " y" Globals["GUI"]["Settings"]["GuiY"] " w550 h350")

IvyshineGuiClose(Ivyshine) {
    Global Globals
    RestoreFPSUnlocker()
    WinGetPos(&GuiX, &GuiY,,, Ivyshine.Hwnd)
    Globals["GUI"]["Settings"]["GuiX"] := GuiX
    Globals["GUI"]["Settings"]["GuiY"] := GuiY
    For ini, Section in Globals
        UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
    Sleep(100)
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
}

SetCueBanner(HWND, Text, Show := True)
{
    DllCall("user32\SendMessage", "ptr", HWND, "uint", 0x1501, "int", Show, "str", Text, "int")
}
