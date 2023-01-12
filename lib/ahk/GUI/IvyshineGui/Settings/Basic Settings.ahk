IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x8 y8 w150 h152 Section", "Basic Settings")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xp yp+6 h20 -Wrap +BackgroundTrans", "Movespeed")
MoveSpeedEdit := IvyshineGui.Add("Edit", "x90 yp-2 w60 hp Limit5 -Wrap vMoveSpeedEdit")
MoveSpeedEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(MoveSpeedEdit.Hwnd, Round(Number(Globals["Settings"]["Basic Settings"]["MoveSpeed"]), 2))

IvyshineGui.Add("Text", "x16 yp+23 h20 -Wrap +BackgroundTrans", "Move Method")
MoveMethodList := IvyshineGui.Add("DropDownList", "x90 yp-3 w60 vMoveMethodList", ["Default", "Walk", "Glider", "Cannon"])
MoveMethodList.Choose(Globals["Settings"]["Basic Settings"]["MoveMethod"])
MoveMethodList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "x16 yp+24 h20 -Wrap +BackgroundTrans", "# of Sprinklers")
NumberOfSprinklersList := IvyshineGui.Add("DropDownList", "x90 yp-3 w60 vNumberOfSprinklersList", ["1 (Basic, Supreme)", "2 (Silver)", "3 (Golden)", "4 (Diamond)"])
NumberOfSprinklersList.Choose(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"])
NumberOfSprinklersList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "x16 yp+24 h20 -Wrap +BackgroundTrans", "Hive Slot")
HiveSlotList := IvyshineGui.Add("DropDownList", "x65 yp-3 w85 vHiveSlotList", ["1 (Red Cannon)", "2", "3", "4", "5", "6 (Noob Shop)"])
HiveSlotList.Choose(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"])
HiveSlotList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "x16 yp+24 h20 -Wrap +BackgroundTrans", "Private Server Link:")
PrivateServerLinkEdit := IvyshineGui.Add("Edit", "x16 yp+16 w134 vPrivateServerLinkEdit")
PrivateServerLinkEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])