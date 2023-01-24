IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x+4 y28 w132 h223 Section", "Unlocks")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

HasRedCannonCheckBox := IvyshineGui.Add("CheckBox", "xs yp+6 h18 -Wrap vHasRedCannonCheckBox Checked" Globals["Settings"]["Unlocks"]["HasRedCannon"], "Have Red Cannon?")
HasRedCannonCheckBox.OnEvent("Click", SubmitSettings)

HasParachuteCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasParachuteCheckBox Checked" ((Globals["Settings"]["Unlocks"]["HasGlider"] || Globals["Settings"]["Unlocks"]["HasParachute"]) ? "1" : "0"), "Have Parachute?")
HasParachuteCheckBox.OnEvent("Click", SubmitSettings)

HasGliderCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasGliderCheckBox Checked" Globals["Settings"]["Unlocks"]["HasGlider"] " Disabled" (Globals["Settings"]["Unlocks"]["HasParachute"] ? "0" : "1"), "Have Glider?")
HasGliderCheckBox.OnEvent("Click", SubmitSettings)

HasGummyMaskCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasGummyMaskCheckBox Checked" Globals["Settings"]["Unlocks"]["HasGummyMask"], "Have Gummy Mask?")
HasGummyMaskCheckBox.OnEvent("Click", SubmitSettings)

HasDiamondMaskCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 w120 -Wrap vHasDiamondMaskCheckBox Checked" Globals["Settings"]["Unlocks"]["HasDiamondMask"], "Have Diamond Mask?")
HasDiamondMaskCheckBox.OnEvent("Click", SubmitSettings)

HasDemonMaskCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasDemonMaskCheckBox Checked" Globals["Settings"]["Unlocks"]["HasDemonMask"], "Have Demon Mask?")
HasDemonMaskCheckBox.OnEvent("Click", SubmitSettings)

HasPetalWandCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasPetalWandCheckBox Checked" Globals["Settings"]["Unlocks"]["HasPetalWand"], "Have Petal Wand?")
HasPetalWandCheckBox.OnEvent("Click", SubmitSettings)

HasGummyballerCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasGummyballerCheckBox Checked" Globals["Settings"]["Unlocks"]["HasGummyballer"], "Have Gummyballer?")
HasGummyballerCheckBox.OnEvent("Click", SubmitSettings)

HasTidePopperCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasTidePopperCheckBox Checked" Globals["Settings"]["Unlocks"]["HasTidePopper"], "Have Tide Popper?")
HasTidePopperCheckBox.OnEvent("Click", SubmitSettings)

HasDarkScytheCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 -Wrap vHasDarkScytheCheckBox Checked" Globals["Settings"]["Unlocks"]["HasDarkScythe"], "Have Dark Scythe?")
HasDarkScytheCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "My hive has ")
NumberOfBeesEdit := IvyshineGui.Add("Edit", "x+5 yp-2 w25 h16 Limit2 Center Number -Wrap vNumberOfBeesEdit")
IvyshineGui.Add("Text", "x+3 yp+2 h20 -Wrap +BackgroundTrans", " Bees.")
NumberOfBeesEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
