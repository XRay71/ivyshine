MacroInfoGUI := Gui("+Border -SysMenu -Resize +Owner" IvyshineGUI.Hwnd, "Ivyshine Info")
MacroInfoGUI.OnEvent("Close", MacroInfoGUIClose)
MacroInfoGUI.OnEvent("Escape", MacroInfoGUIClose)
WinSetStyle(-0xC40000)
DllCall("SetMenu", "Ptr", WinExist(), "Ptr", 0)
MacroInfoGUI.MarginX := 10
MacroInfoGUI.MarginY := 10
MacroInfoGUI.SetFont()
MacroInfoGUI.SetFont("s10", "Calibri")

MacroInfoText := MacroInfoGUI.Add("Link", "w300 Left", 'The Ivyshine Macro is developed and maintained by XRay71 (Raychel#2101).`r`n`r`nSpecial thanks to the dev team of the <a href="https://bit.ly/NatroMacro">Natro Macro</a> for countless good ideas and code design :D`r`n`r`nThe Ivyshine Macro is hosted in the Bee Swarm Macro Community, found on <a href="https://discord.gg/dKfDkBKn5v">Discord</a>.')

MacroInfoGUIClose(*) {
    Global ShowMacroInfoGUI := 0
    MacroInfoGUI.Hide()
}