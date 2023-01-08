IvyshineGui := Gui("-SysMenu -Resize" (Globals["GUI"]["Settings"]["AlwaysOnTop"] ? " +AlwaysOnTop" : " -AlwaysOnTop"), "Ivyshine Macro")
IvyshineGui.OnEvent("Close", IvyshineGuiClose)
IvyshineGui.OnEvent("Escape", IvyshineGuiClose)

IvyshineGui.MarginX := 4
IvyshineGui.MarginY := 4

IvyshineGui.SetFont()

IvyshineGui.SetFont((StrLen(Globals["Settings"]["Hotkeys"]["StartHotkey"]) < 5) ? "s7" : "s6", "Segoe UI")
StartButton := IvyshineGui.Add("Button", "x426 y326 w30 h20 Center vStartButton", Globals["Settings"]["Hotkeys"]["StartHotkey"])
StartButton.OnEvent("Click", StartMacro)

IvyshineGui.SetFont((StrLen(Globals["Settings"]["Hotkeys"]["StopHotkey"]) < 5) ? "s7" : "s6", "Segoe UI")
PauseButton := IvyshineGui.Add("Button", "xp+30 yp wp hp Center vPauseButton", Globals["Settings"]["Hotkeys"]["PauseHotkey"])
PauseButton.OnEvent("Click", PauseMacro)

IvyshineGui.SetFont((StrLen(Globals["Settings"]["Hotkeys"]["StopHotkey"]) < 5) ? "s7" : "s6", "Segoe UI")
StopButton := IvyshineGui.Add("Button", "xp+30 yp wp hp Center vStopButton", Globals["Settings"]["Hotkeys"]["StopHotkey"])
StopButton.OnEvent("Click", StopMacro)

IvyShineGui.SetFont("s7", "Segoe UI")
InfoButton := IvyshineGui.Add("Button", "xp+30 yp wp hp Center vInfoButton", "v" CurrentVersionID)
InfoButton.OnEvent("Click", ShowMacroInfo)

IvyshineGui.SetFont("s10 Norm cBlack", "Segoe UI")
MainTabs := IvyshineGui.Add("Tab3", "x0 y0 w550 h350 vMainTabs -Wrap +0x8 +Bottom -Background", ["Settings", "Fields", "Boost", "Mobs", "Quests", "Planters", "Status"])
MainTabs.Choose(Integer(Globals["GUI"]["Settings"]["CurrentGUITab"]))
MainTabs.OnEvent("Change", MainTabChanged)

IvyshineGui.Show("x" Globals["GUI"]["Settings"]["GuiX"] " y" Globals["GUI"]["Settings"]["GuiY"] " w550 h350")

IvyshineGuiClose(Ivyshine) {
    Global Globals
    RestoreFPSUnlocker()
    WinGetPos(&GuiX, &GuiY,,, Ivyshine.Hwnd)
    Globals["GUI"]["Settings"]["GuiX"] := GuiX
    Globals["GUI"]["Settings"]["GuiY"] := GuiY
    For ini, Section in Globals
        UpdateIni(Globals["Constants"]["Ini FilePaths"][ini], Globals[ini])
    Sleep(100)
    ExitApp
}

#Include *i MacroInfo\macroinfo.ahk
ShowMacroInfoGui := 0

Try
MacroInfoGui.Show("Hide")
Catch Any
    MissingFilesError()

ShowMacroinfo(*) {
    Global ShowMacroInfoGui
    ShowMacroInfoGui := !ShowMacroInfoGui
    If (ShowMacroInfoGui)
        MacroInfoGui.Show("AutoSize NoActivate")
    Else
        MacroInfoGui.Hide()
}

MainTabChanged(MainTab, *) {
    Global Globals
    Globals["GUI"]["Settings"]["CurrentGUITab"] := MainTab.Value
    IniWrite(Globals["GUI"]["Settings"]["CurrentGUITab"], Globals["Constants"]["Ini FilePaths"]["GUI"], "Settings", "CurrentGUITab")
}

SetCueBanner(HWND, Text, Show := True)
{
    DllCall("user32\SendMessage", "ptr", HWND, "uint", 0x1501, "int", Show, "str", Text, "int")
}
