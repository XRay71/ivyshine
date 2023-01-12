IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x8 ys+156 w150 h112 Section", "Unlocks")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xp yp+6 h20 -Wrap +BackgroundTrans", "Unlocked Red Cannon?")
UnlockedRedCannonCheckBox := IvyshineGui.Add("CheckBox", "x135 yp-3 w15 h20 -Wrap vUnlockedRedCannonCheckBox Checked" Globals["Settings"]["Unlocks"]["UnlockedRedCannon"])
UnlockedRedCannonCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "x16 yp+24 h20 -Wrap +BackgroundTrans", "Unlocked Parachute?")
UnlockedParachuteCheckBox := IvyshineGui.Add("CheckBox", "x135 yp-3 w15 h20 -Wrap vUnlockedParachuteCheckBox Checked" ((Globals["Settings"]["Unlocks"]["UnlockedGlider"] || Globals["Settings"]["Unlocks"]["UnlockedParachute"]) ? "1" : "0"))
UnlockedParachuteCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "x16 yp+24 h20 -Wrap +BackgroundTrans", "Unlocked the Glider?")
UnlockedGliderCheckBox := IvyshineGui.Add("CheckBox", "x135 yp-3 w15 h20 -Wrap vUnlockedGliderCheckBox Checked" Globals["Settings"]["Unlocks"]["UnlockedGlider"] " Disabled" (Globals["Settings"]["Unlocks"]["UnlockedParachute"] ? "0" : "1"))
UnlockedGliderCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "x16 yp+24 h20 -Wrap +BackgroundTrans", "My hive has ")
NumberOfBeesEdit := IvyshineGui.Add("Edit", "x+5 yp-2 w30 h20 Limit2 Number -Wrap vNumberOfBeesEdit")
IvyshineGui.Add("Text", "x+5 yp+2 h20 -Wrap +BackgroundTrans", " Bees.")
NumberOfBeesEdit.OnEvent("LoseFocus", SubmitSettings)
SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
