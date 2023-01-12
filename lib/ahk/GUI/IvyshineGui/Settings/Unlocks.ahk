IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x+4 y8 w150 h238 Section", "Unlocks")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs yp+6 h20 -Wrap +BackgroundTrans", "Unlocked Red Cannon?")
UnlockedRedCannonCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vUnlockedRedCannonCheckBox Checked" Globals["Settings"]["Unlocks"]["UnlockedRedCannon"])
UnlockedRedCannonCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Unlocked Parachute?")
UnlockedParachuteCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vUnlockedParachuteCheckBox Checked" ((Globals["Settings"]["Unlocks"]["UnlockedGlider"] || Globals["Settings"]["Unlocks"]["UnlockedParachute"]) ? "1" : "0"))
UnlockedParachuteCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Unlocked the Glider?")
UnlockedGliderCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vUnlockedGliderCheckBox Checked" Globals["Settings"]["Unlocks"]["UnlockedGlider"] " Disabled" (Globals["Settings"]["Unlocks"]["UnlockedParachute"] ? "0" : "1"))
UnlockedGliderCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Have Gummy Mask?")
HasGummyMaskCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vHasGummyMaskCheckBox Checked" Globals["Settings"]["Unlocks"]["HasGummyMask"])
HasGummyMaskCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Have Diamond Mask?")
HasDiamondMaskCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vHasDiamondMaskCheckBox Checked" Globals["Settings"]["Unlocks"]["HasDiamondMask"])
HasDiamondMaskCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Have Demon Mask?")
HasDemonMaskCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vHasDemonMaskCheckBox Checked" Globals["Settings"]["Unlocks"]["HasDemonMask"])
HasDemonMaskCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Have the Petal Wand?")
HasPetalWandCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vHasPetalWandCheckBox Checked" Globals["Settings"]["Unlocks"]["HasPetalWand"])
HasPetalWandCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Have the Tide Popper?")
HasTidePopperCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vHasTidePopperCheckBox Checked" Globals["Settings"]["Unlocks"]["HasTidePopper"])
HasTidePopperCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "Have the Dark Scythe?")
HasDarkScytheCheckBox := IvyshineGui.Add("CheckBox", "xs+120 yp-3 w15 h20 -Wrap vHasDarkScytheCheckBox Checked" Globals["Settings"]["Unlocks"]["HasDarkScythe"])
HasDarkScytheCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+24 h20 -Wrap +BackgroundTrans", "My hive has ")
NumberOfBeesEdit := IvyshineGui.Add("Edit", "x+5 yp-2 w30 h20 Limit2 Number -Wrap vNumberOfBeesEdit")
IvyshineGui.Add("Text", "x+5 yp+2 h20 -Wrap +BackgroundTrans", " Bees.")
NumberOfBeesEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
