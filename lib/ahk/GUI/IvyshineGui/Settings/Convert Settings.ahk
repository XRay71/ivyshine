IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs-8 ys+52 w132 h85 Section", "Convert Settings")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

IvyshineGUI.Add("Text", "xs yp+6 h20 -Wrap +BackgroundTrans", "Convert Delay:")
ConvertDelayEdit := IvyshineGUI.Add("Edit", "x+4 yp-1 w18 h16 -Wrap Center Limit2 Number vConvertDelayEdit")
ConvertDelayEdit.OnEvent("LoseFocus", SubmitSettings)
IvyshineGUI.Add("Text", "x+4 yp+1 h20 -Wrap +BackgroundTrans", "sec.")

IvyshineGUI.Add("Text", "xs yp+16 h20 -Wrap +BackgroundTrans", "Convert Balloon: ")
BalloonConvertSettingList := IvyshineGUI.Add("DropDownList", "xs yp+16 w55 vBalloonConvertSettingList", ["Auto", "Every", "Never"])
BalloonConvertSettingList.OnEvent("Change", SubmitSettings)

BalloonConvertIntervalEdit := IvyshineGUI.Add("Edit", "x+4 yp+2 h16 w20 Limit2 Number Center vBalloonConvertIntervalEdit Hidden" (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every" ? "0" : "1"))
BalloonConvertIntervalEdit.OnEvent("LoseFocus", SubmitSettings)

BalloonConvertIntervalText := IvyshineGUI.Add("Text", "x+4 yp+2 h20 -Wrap +BackgroundTrans vBalloonConvertIntervalText Hidden" (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every" ? "0" : "1"), "min.")
