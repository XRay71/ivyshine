IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs-8 ys+65 w132 h66 Section", "rbxfpsunlocker")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 Section 0x10")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

RunrbxfpsunlockerCheckBox := IvyshineGUI.Add("CheckBox", "xs ys+4 h20 -Wrap vRunrbxfpsunlockerCheckBox Checked" Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"], "Run rbxfpsunlocker?")
RunrbxfpsunlockerCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+22 h20 -Wrap +BackgroundTrans", "Lock FPS at ")
FPSEdit := IvyshineGUI.Add("Edit", "x+2 yp-2 w40 h16 -Wrap Limit3 Number Center vFPSEdit Disabled" (Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"] == 0 ? "1" : "0"))
IvyshineGUI.Add("Text", "x+2 yp+2 h20 -Wrap +BackgroundTrans", " FPS.")
SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] == 0 ? "inf" : Globals["Settings"]["rbxfpsunlocker"]["FPS"]))
FPSEdit.OnEvent("LoseFocus", SubmitSettings)