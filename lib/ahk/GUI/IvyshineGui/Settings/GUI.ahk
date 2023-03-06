IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs+128 y28 w132 h72 Section", "GUI")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

AlwaysOnTopCheckBox := IvyshineGUI.Add("CheckBox", "xs yp+4 h18 -Wrap vAlwaysOnTopCheckBox Checked" Globals["Settings"]["GUI"]["AlwaysOnTop"], "GUI always on top?")
AlwaysOnTopCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "Transparency: ")
TransparencyList := IvyshineGUI.Add("DropDownList", "x+4 yp-2 w45 vTransparencyList", ["0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75"])
TransparencyList.Choose(Globals["Settings"]["GUI"]["Transparency"])
TransparencyList.OnEvent("Change", SubmitSettings)

