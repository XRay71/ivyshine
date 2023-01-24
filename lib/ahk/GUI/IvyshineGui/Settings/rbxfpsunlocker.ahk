IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x8 y+7 w150 h69 Section", "rbxfpsunlocker")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 Section 0x10")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

RunrbxfpsunlockerCheckBox := IvyshineGui.Add("CheckBox", "xs ys+6 h20 -Wrap vRunrbxfpsunlockerCheckBox Checked" Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"], "Run rbxfpsunlocker?")
RunrbxfpsunlockerCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+23 h20 -Wrap +BackgroundTrans", "Lock FPS at ")
FPSEdit := IvyshineGui.Add("Edit", "x+5 yp-2 w40 h16 -Wrap Limit3 Number Center vFPSEdit Disabled" (Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"] == 0 ? "1" : "0"))
IvyshineGui.Add("Text", "x+5 yp+2 h20 -Wrap +BackgroundTrans", " FPS.")
SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] == 0 ? "inf" : Globals["Settings"]["rbxfpsunlocker"]["FPS"]))
FPSEdit.OnEvent("LoseFocus", SubmitSettings)