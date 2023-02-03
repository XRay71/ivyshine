IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs+8 ys+8 w150 h152 Section", "Basic Settings")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 Section 0x10")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs yp+8 h20 -Wrap +BackgroundTrans", "Movespeed")
MoveSpeedEdit := IvyshineGui.Add("Edit", "xs+74 yp-3 w60 hp Limit5 -Wrap vMoveSpeedEdit")
MoveSpeedEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(MoveSpeedEdit.Hwnd, Round(Number(Globals["Settings"]["Basic Settings"]["MoveSpeed"]), 2))

IvyshineGui.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "Move Method")
MoveMethodList := IvyshineGui.Add("DropDownList", "xs+74 yp-3 w60 vMoveMethodList", ["Default", "Walk", "Glider", "Cannon"])
MoveMethodList.Choose(Globals["Settings"]["Basic Settings"]["MoveMethod"])
MoveMethodList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "# of Sprinklers")
NumberOfSprinklersList := IvyshineGui.Add("DropDownList", "xs+74 yp-3 w60 vNumberOfSprinklersList", ["1", "2 (Silver)", "3 (Golden)", "4 (Diamond)"])
NumberOfSprinklersList.Choose(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"])
NumberOfSprinklersList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "Hive Slot")
HiveSlotNumberList := IvyshineGui.Add("DropDownList", "x65 yp-3 w85 vHiveSlotNumberList", ["1 (Red Cannon)", "2", "3", "4", "5", "6 (Noob Shop)"])
HiveSlotNumberList.Choose(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"])
HiveSlotNumberList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+22 h20 -Wrap +BackgroundTrans", "Private Server Link:")
PrivateServerLinkEdit := IvyshineGui.Add("Edit", "xs yp+16 w134 vPrivateServerLinkEdit")
PrivateServerLinkEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])