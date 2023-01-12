IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x8 y+3 w150 h66 Section", "Unlocks")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

HasBearBeeCheckBox := IvyshineGui.Add("CheckBox", "xs ys+6 h20 -Wrap vHasBearBeeCheckBox Checked" Globals["Settings"]["Bees"]["HasBearBee"], "Have Bear Bee?")
HasBearBeeCheckBox.OnEvent("Click", SubmitSettings)

HasGiftedViciousCheckBox := IvyshineGui.Add("CheckBox", "xs ys+26 h14 -Wrap vHasGiftedViciousCheckBox Checked" Globals["Settings"]["Bees"]["HasGiftedVicious"], "Have Gifted Vicious Bee?")
HasGiftedViciousCheckBox.OnEvent("Click", SubmitSettings)