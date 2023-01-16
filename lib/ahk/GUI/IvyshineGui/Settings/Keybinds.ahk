IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x434 y28 w106 h223 Section", "Keybinds")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs yp+6 h19 -Wrap +BackgroundTrans", "Forward Key:")
ForwardKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vForwardKeyEdit")
SetCueBanner(ForwardKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ForwardKey"])
ForwardKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Left Key:")
LeftKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vLeftKeyEdit")
SetCueBanner(LeftKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["LeftKey"])
LeftKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Backward Key:")
BackwardKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vBackwardKeyEdit")
SetCueBanner(BackwardKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["BackwardKey"])
BackwardKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Right Key:")
RightKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vRightKeyEdit")
SetCueBanner(RightKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["RightKey"])
RightKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Camera Left:")
CameraLeftKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vCamLeftKeyEdit")
SetCueBanner(CameraLeftKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraLeftKey"])
CameraLeftKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Camera Right:")
CameraRightKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vCameraRightKeyEdit")
SetCueBanner(CameraRightKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraRightKey"])
CameraRightKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Camera In:")
CameraInKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vCameraInKeyEdit")
SetCueBanner(CameraInKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraInKey"])
CameraInKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Camera Out:")
CameraOutKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vCameraOutKeyEdit")
SetCueBanner(CameraOutKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraOutKey"])
CameraOutKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h19 -Wrap +BackgroundTrans", "Reset Key:")
ResetKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vResetKeyEdit")
SetCueBanner(ResetKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ResetKey"])
ResetKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+19 h20 -Wrap +BackgroundTrans", "Chat Key:")
ChatKeyEdit := IvyshineGui.Add("Edit", "xs+75 yp-2 w15 hp Limit1 Center -Wrap vChatKeyEdit")
SetCueBanner(ChatKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ChatKey"])
ChatKeyEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+22 h19 -Wrap +BackgroundTrans", "Key Delay:")
AdditionalKeyDelayEdit := IvyshineGui.Add("Edit", "xs+60 yp-3 w30 h21 Right Limit3 Number -Wrap vAdditionalKeyDelayEdit")
SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Keybinds"]["AdditionalKeyDelay"])
AdditionalKeyDelayEdit.OnEvent("LoseFocus", SubmitSettings)