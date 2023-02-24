MacroInfoGui := Gui("+Border -SysMenu -Resize" (Globals["Settings"]["GUI"]["AlwaysOnTop"] ? " +AlwaysOnTop" : "") " +Owner" IvyshineGui.Hwnd, "Ivyshine Info")
MacroInfoGui.OnEvent("Close", MacroInfoGuiClose)
MacroInfoGui.OnEvent("Escape", MacroInfoGuiClose)

MacroInfoGui.MarginX := 10
MacroInfoGui.MarginY := 10

MacroInfoGui.SetFont()
MacroInfoGui.SetFont("s10", "Calibri")

MacroInfoText := MacroInfoGui.Add("Link", "w300 Left", 'The Ivyshine Macro is developed and maintained by XRay71 (Raychel#2101).`r`n`r`nSpecial thanks to the dev team of the <a href="https://bit.ly/NatroMacro">Natro Macro</a> for countless good ideas and code design :D`r`n`r`nThe Ivyshine Macro is hosted in the Bee Swarm Macro Community, found on <a href="https://discord.gg/dKfDkBKn5v">Discord</a>.')

MacroInfoGui.Show("Hide Center AutoSize")
MacroInfoGui.Opt("+LastFound")
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", WinExist(), "Ptr", 0)

MacroInfoGuiClose(*) {
    Global ShowMacroInfoGui := 0
    MacroInfoGui.Hide()
}