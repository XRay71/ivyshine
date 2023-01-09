IvyshineGui.Add("GroupBox", "x8 y8 w150 h175 Section", "Basic Settings")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s9", "Segoe UI")

IvyshineGui.Add("Text", "xp yp+6 h20 -Wrap +BackgroundTrans", "Movespeed")
MoveSpeedEdit := IvyshineGui.Add("Edit", "x92 yp-2 w58 h20 Limit5 -Wrap")
MoveSpeedEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(MoveSpeedEdit.Hwnd, Globals["Settings"]["Basic Settings"]["MoveSpeed"])
