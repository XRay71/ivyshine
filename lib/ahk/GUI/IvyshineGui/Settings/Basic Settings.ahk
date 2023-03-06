IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs+8 ys+8 w150 h152 Section", "Basic Settings")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 Section 0x10")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

IvyshineGUI.Add("Text", "xs yp+8 h20 -Wrap +BackgroundTrans", "Movespeed")
MoveSpeedEdit := IvyshineGUI.Add("Edit", "xs+74 yp-3 w60 hp Limit5 -Wrap vMoveSpeedEdit")
MoveSpeedEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "Move Method")
MoveMethodList := IvyshineGUI.Add("DropDownList", "xs+74 yp-3 w60 vMoveMethodList")
MoveMethodList.OnEvent("Change", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "# of Sprinklers")
NumberOfSprinklersList := IvyshineGUI.Add("DropDownList", "xs+74 yp-3 w60 vNumberOfSprinklersList", ["0: None", "1: Sup/Basic", "2: Silver", "3: Golden", "4: Diamond"])
NumberOfSprinklersList.OnEvent("Change", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "Hive Slot")
HiveSlotNumberList := IvyshineGUI.Add("DropDownList", "x65 yp-3 w85 vHiveSlotNumberList", ["1: Red Cannon", "2", "3", "4", "5", "6: Noob Shop"])
HiveSlotNumberList.OnEvent("Change", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+22 h20 -Wrap +BackgroundTrans", "Private Server Link:")
PrivateServerLinkEdit := IvyshineGUI.Add("Edit", "xs yp+16 w134 vPrivateServerLinkEdit")
PrivateServerLinkEdit.OnEvent("LoseFocus", SubmitSettings)