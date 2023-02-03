IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 ys+51 w150 h68 Section", "Collect/Kill")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

HasGiftedViciousCheckBox := IvyshineGui.Add("CheckBox", "xs ys+6 h14 -Wrap vHasGiftedViciousCheckBox Checked" Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"], "Have Gifted Vicious Bee?")
HasGiftedViciousCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+18 h20 -Wrap +BackgroundTrans", "Auto-Equip: ")
AutoEquipList := IvyshineGui.Add("DropDownList", "x+4 yp-3 w70 -Wrap vAutoEquipList", ["Default", "All", "Bosses Only", "Gather Only", "Off"])
AutoEquipList.Choose(Globals["Settings"]["Collect/Kill"]["AutoEquip"])
AutoEquipList.OnEvent("Change", SubmitSettings)