IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x+64 y28 w132 h223 Section", "Miscellaneous")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

AlwaysOnTopCheckBox := IvyshineGui.Add("CheckBox", "xs yp+6 h20 -Wrap vAlwaysOnTopCheckBox Checked" Globals["GUI"]["Settings"]["AlwaysOnTop"], "GUI always on top?")
AlwaysOnTopCheckBox.OnEvent("Click", SubmitSettings)

MoveSpeedCorrectionCheckBox := IvyshineGui.Add("CheckBox", "xs yp+19 h20 w120 -Wrap vMoveSpeedCorrectionCheckBox Checked" Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"], "Adjust for haste buffs?")
MoveSpeedCorrectionCheckBox.OnEvent("Click", SubmitSettings)

ShiftLockWhenPossibleCheckBox := IvyshineGui.Add("CheckBox", "xs yp+19 h20 w120 -Wrap vShiftLockWhenPossibleCheckBox Checked" Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"], "Shiftlock moving?")
ShiftLockWhenPossibleCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+22 h20 -Wrap +BackgroundTrans", "Transparency: ")
TransparencyList := IvyshineGui.Add("DropDownList", "x+4 yp-2 w45 vTransparencyList", ["0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75"])
TransparencyList.Choose(Globals["GUI"]["Settings"]["Transparency"])
TransparencyList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+21 h20 -Wrap +BackgroundTrans", "Convert Balloon: ")
BalloonConvertList := IvyshineGui.Add("DropDownList", "xs yp+16 w55 vBalloonConvertList", ["Auto", "Every", "Never"])
BalloonConvertList.Choose(Globals["Settings"]["Miscellaneous"]["BalloonConvert"])
BalloonConvertList.OnEvent("Change", SubmitSettings)

BalloonConvertEdit := IvyshineGui.Add("Edit", "x+4 yp+2 h16 w20 Limit2 Number Center vBalloonConvertEdit Hidden" (Globals["Settings"]["Miscellaneous"]["BalloonConvert"] == "Every" ? "0" : "1"))
BalloonConvertEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(BalloonConvertEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["BalloonConvertInterval"])

BalloonConvertText := IvyshineGui.Add("Text", "x+4 yp+1 h20 -Wrap +BackgroundTrans vBalloonConvertText Hidden" (Globals["Settings"]["Miscellaneous"]["BalloonConvert"] == "Every" ? "0" : "1"), "min.")

IvyshineGui.Add("Text", "xs yp+20 h20 -Wrap +BackgroundTrans", "Reset Multiplier: ")
ResetMultiplierList := IvyshineGui.Add("DropDownList", "x+4 yp-3 w33 vResetMultiplierList", ["1", "2", "3", "4", "5"])
ResetMultiplierList.Choose(Globals["Settings"]["Miscellaneous"]["ResetMultiplier"])
ResetMultiplierList.OnEvent("Change", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+21 h20 -Wrap +BackgroundTrans", "Reconnect Interval: ")
IvyshineGui.Add("Text", "xs yp+19 h20 -Wrap +BackgroundTrans", "Every ")
ReconnectIntervalEdit := IvyshineGui.Add("Edit", "x+2 yp-1 h16 w20 Center Limit2 Number vReconnectIntervalEdit")
ReconnectIntervalText := IvyshineGui.Add("Text", "x+2 yp+1 h20 -Wrap +BackgroundTrans", (Globals["Settings"]["Miscellaneous"]["ReconnectInterval"] == 1 ? " hour," : " hours,"))
SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["ReconnectInterval"])
ReconnectIntervalEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h20 -Wrap +BackgroundTrans", "starting at ")
ReconnectStartHourEdit := IvyshineGui.Add("Edit", "x+1 yp-1 h16 w17 Center Limit2 Number vReconnectStartHourEdit")
SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["ReconnectStartHour"])
IvyshineGui.Add("Text", "x+1 yp+1 h20 -Wrap +BackgroundTrans", " : ")
ReconnectStartMinuteEdit := IvyshineGui.Add("Edit", "x+1 yp-1 h16 w17 Center Limit2 Number vReconnectStartMinuteEdit")
SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["ReconnectStartMinute"])
IvyshineGui.Add("Text", "x+1 yp+2 h20 -Wrap +BackgroundTrans", " UTC")
