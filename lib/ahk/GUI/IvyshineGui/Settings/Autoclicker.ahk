IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "xs-8 y+6 w106 h90 Section", "Autoclicker")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

; RunAntiAFKCheckBox := IvyshineGui.Add("CheckBox", "xs yp+6 h20 -Wrap vRunAntiAFKCheckBox Checked" Globals["Settings"]["AntiAFK"]["RunAntiAFK"], "Run Anti-AFK?")
; RunAntiAFKCheckBox.OnEvent("Click", SubmitSettings)

; IvyshineGui.Add("Text", "xs yp+22 h18 -Wrap +BackgroundTrans", "Run every ")
; AntiAFKEdit := IvyshineGui.Add("Edit", "x+2 yp-2 w20 hp -Wrap Center Limit2 Number vAntiAFKEdit Disabled" (Globals["Settings"]["AntiAFK"]["RunAntiAFK"] ? "0" : "1"))
; AntiAFKDescriptorText := IvyshineGui.Add("Text", "x+2 yp+2 hp w100 -Wrap +BackgroundTrans", (Globals["Settings"]["AntiAFK"]["AntiAFKLoopTimeMinutes"] == 1 ? " minute." : " minutes."))
; AntiAFKEdit.OnEvent("LoseFocus", SubmitSettings)
; SetCueBanner(AntiAFKEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKLoopTimeMinutes"])

; If (Globals["Settings"]["AntiAFK"]["RunAntiAFK"]) {
;     Globals["Settings"]["AntiAFK"]["LastRun"] := A_NowUTC
;     SetTimer(AntiAFK, 500, -1)
; }

; AntiAFKProgress := IvyshineGui.Add("Progress", "xs yp+19 h18 w116 Range0-" (Globals["Settings"]["AntiAFK"]["AntiAFKLoopTimeMinutes"] * 60))

; AntiAFKInfoButton := IvyshineGui.Add("Button", "xs+52 ys-19 h16 w15", "?")

; AntiAFKInfoButton.OnEvent("Click", ShowAntiAFKInfo)

; ShowAntiAFKInfo(*) {
;     MsgBox("This feature automatically switches to Roblox and nudges the camera on a chosen interval, preventing you from disconnecting if you are AFKing in the background.`r`n`r`nExample use case: Roblox is minimized in the background.", "What is Anti-AFK?", "Icon? Owner" IvyshineGui.Hwnd)
; }

; AntiAFK() {

; }