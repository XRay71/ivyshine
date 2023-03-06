IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs-8 ys+132 w150 h71 Section", "Reconnect Settings")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

IvyshineGUI.Add("Text", "xs yp+8 h20 -Wrap +BackgroundTrans", "Rejoin every ")
ReconnectIntervalEdit := IvyshineGUI.Add("Edit", "x+3 yp-2 h16 w20 Center Limit2 Number vReconnectIntervalEdit")
ReconnectIntervalText := IvyshineGUI.Add("Text", "x+3 yp+2 h20 -Wrap +BackgroundTrans vReconnectIntervalText", (Globals["Settings"]["Reconnect"]["ReconnectInterval"] == 1 ? " hour," : " hours,"))
SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectInterval"])
ReconnectIntervalEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "starting at ")
ReconnectStartHourEdit := IvyshineGUI.Add("Edit", "x+3 yp-2 h16 w18 Center Limit2 Number vReconnectStartHourEdit")
SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartHour"])
ReconnectStartHourEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGUI.Add("Text", "x+3 yp+2 h20 -Wrap +BackgroundTrans", " : ")

ReconnectStartMinuteEdit := IvyshineGUI.Add("Edit", "x+3 yp-2 h16 w18 Center Limit2 Number vReconnectStartMinuteEdit")
SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartMinute"])
IvyshineGUI.Add("Text", "x+3 yp+2 h20 -Wrap +BackgroundTrans", " UTC")
ReconnectStartMinuteEdit.OnEvent("LoseFocus", SubmitSettings)