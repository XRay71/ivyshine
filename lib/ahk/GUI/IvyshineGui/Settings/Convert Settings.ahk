IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 ys+54 w132 h85 Section", "Convert Settings")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs yp+6 h20 -Wrap +BackgroundTrans", "Convert Delay:")
ConvertDelayEdit := IvyshineGui.Add("Edit", "x+4 yp-1 w18 h16 -Wrap Center Limit2 Number vConvertDelayEdit")
SetCueBanner(ConvertDelayEdit.Hwnd, Globals["Settings"]["Convert Settings"]["ConvertDelay"])
ConvertDelayEdit.OnEvent("LoseFocus", SubmitSettings)
IvyshineGui.Add("Text", "x+4 yp+1 h20 -Wrap +BackgroundTrans", "sec.")

IvyshineGui.Add("Text", "xs yp+16 h20 -Wrap +BackgroundTrans", "Convert Balloon: ")
BalloonConvertSettingList := IvyshineGui.Add("DropDownList", "xs yp+16 w55 vBalloonConvertSettingList", ["Auto", "Every", "Never"])
BalloonConvertSettingList.Choose(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"])
BalloonConvertSettingList.OnEvent("Change", SubmitSettings)

BalloonConvertIntervalEdit := IvyshineGui.Add("Edit", "x+4 yp+2 h16 w20 Limit2 Number Center vBalloonConvertIntervalEdit Hidden" (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every" ? "0" : "1"))
BalloonConvertIntervalEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"])

BalloonConvertIntervalText := IvyshineGui.Add("Text", "x+4 yp+2 h20 -Wrap +BackgroundTrans vBalloonConvertIntervalText Hidden" (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every" ? "0" : "1"), "min.")
