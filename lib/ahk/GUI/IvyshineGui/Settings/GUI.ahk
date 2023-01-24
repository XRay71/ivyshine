IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x+64 y28 w132 h72 Section", "GUI")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

AlwaysOnTopCheckBox := IvyshineGui.Add("CheckBox", "xs yp+6 h18 -Wrap vAlwaysOnTopCheckBox Checked" Globals["Settings"]["GUI"]["AlwaysOnTop"], "GUI always on top?")
AlwaysOnTopCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+21 h20 -Wrap +BackgroundTrans", "Transparency: ")
TransparencyList := IvyshineGui.Add("DropDownList", "x+4 yp-2 w45 vTransparencyList", ["0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75"])
TransparencyList.Choose(Globals["Settings"]["GUI"]["Transparency"])
TransparencyList.OnEvent("Change", SubmitSettings)

