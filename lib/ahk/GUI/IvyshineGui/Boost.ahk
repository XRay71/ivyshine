MainTabs.UseTab(3)

#Include *i Boost\Boost Rotation.ahk

SubmitBoostButton := IvyshineGui.Add("Button", "x0 y0 w1 h1 Hidden vSubmitBoostButton")
SubmitBoostButton.OnEvent("Click", SubmitBoost)

SubmitBoost(ThisControl, *) {
    
    SubmitButton := (ThisControl.Hwnd == SubmitBoostButton.Hwnd)
    ThisControl := (ThisControl.Hwnd == SubmitBoostButton.Hwnd ? IvyshineGui.FocusedCtrl : ThisControl)
    
}

SetBoostTabValues(*) {
    
}

BoostTabOn := True

BoostTabSwitch(*) {
    SetBoostTabValues()
    
    Global BoostTabOn
    BoostTabOn := !BoostTabOn
    
}