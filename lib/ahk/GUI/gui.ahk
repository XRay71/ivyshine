IvyshineGui := Gui("Border -MaximizeBox -Resize -SysMenu" (Globals["GUI"]["Settings"]["AlwaysOnTop"] ? " +AlwaysOnTop" : " -AlwaysOnTop"), "Ivyshine Macro")
IvyshineGui.OnEvent("Close", IvyshineGuiClose)
IvyshineGui.Show("X" Globals["GUI"]["Settings"]["GuiX"] " Y" Globals["GUI"]["Settings"]["GuiY"] " W500 H500")

IvyshineGuiClose(Ivyshine) {
    Global Globals
    WinGetPos(&GuiX, &GuiY,,, Ivyshine.Hwnd)
    Globals["GUI"]["Settings"]["GuiX"] := GuiX
    Globals["GUI"]["Settings"]["GuiY"] := GuiY
    For ini, Section in Globals
        UpdateIni(Globals["Constants"]["Ini FilePaths"][ini], Globals[ini])
    RestoreFPSUnlocker()
    Sleep(100)
    ExitApp
}