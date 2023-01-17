IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x8 ys+54 w150 h66 Section", "Collect/Kill")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs ys+8 h20 -Wrap +BackgroundTrans", "Auto-Equip: ")
AutoEquipList := IvyshineGui.Add("DropDownList", "x+4 ys+5 w70 -Wrap vAutoEquipList", ["Default", "All", "Bosses Only", "Gather Only", "Off"])
AutoEquipList.Choose(Globals["Settings"]["Collect/Kill"]["AutoEquip"])
AutoEquipList.OnEvent("Change", SubmitSettings)

HasGiftedViciousCheckBox := IvyshineGui.Add("CheckBox", "xs yp+23 h14 -Wrap vHasGiftedViciousCheckBox Checked" Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"], "Have Gifted Vicious Bee?")
HasGiftedViciousCheckBox.OnEvent("Click", SubmitSettings)