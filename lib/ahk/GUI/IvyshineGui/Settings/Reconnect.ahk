IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 ys+67 w132 h62 Section", "Reconnect Settings")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs yp+6 h20 -Wrap +BackgroundTrans", "Every ")
ReconnectIntervalEdit := IvyshineGui.Add("Edit", "x+2 yp-2 h16 w20 Center Limit2 Number vReconnectIntervalEdit")
ReconnectIntervalText := IvyshineGui.Add("Text", "x+2 yp+2 h20 -Wrap +BackgroundTrans vReconnectIntervalText", (Globals["Settings"]["Reconnect"]["ReconnectInterval"] == 1 ? " hour," : " hours,"))
SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectInterval"])
ReconnectIntervalEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+16 h20 -Wrap +BackgroundTrans", "starting at ")
ReconnectStartHourEdit := IvyshineGui.Add("Edit", "x+1 yp-2 h16 w18 Center Limit2 Number vReconnectStartHourEdit")
SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartHour"])
ReconnectStartHourEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "x+1 yp+2 h20 -Wrap +BackgroundTrans", " : ")

ReconnectStartMinuteEdit := IvyshineGui.Add("Edit", "x+1 yp-2 h16 w18 Center Limit2 Number vReconnectStartMinuteEdit")
SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartMinute"])
IvyshineGui.Add("Text", "x+1 yp+2 h20 -Wrap +BackgroundTrans", " UTC")
ReconnectStartMinuteEdit.OnEvent("LoseFocus", SubmitSettings)