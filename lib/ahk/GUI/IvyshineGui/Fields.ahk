MainTabs.UseTab(2)

#Include *i Fields\Field Rotation.ahk
#Include *i Fields\Field View.ahk

SubmitFieldsButton := IvyshineGui.Add("Button", "x0 y0 w1 h1 Hidden vSubmitFieldsButton")
SubmitFieldsButton.OnEvent("Click", SubmitFields)

SubmitFields(ThisControl, *) {
    
    SubmitButton := (ThisControl.Hwnd == SubmitFieldsButton.Hwnd)
    ThisControl := (ThisControl.Hwnd == SubmitFieldsButton.Hwnd ? IvyshineGui.FocusedCtrl : ThisControl)
    
    If (ThisControl.Hwnd == FieldRotationListBox.Hwnd) {
        Globals["Fields"]["Settings"]["CurrentlySelectedField"] := FieldRotationListBox.Value
        IniWrite(Globals["Fields"]["Settings"]["CurrentlySelectedField"], Globals["Constants"]["ini FilePaths"]["Fields"], "Settings", "CurrentlySelectedField")
    }
}

SetFieldsTabValues(*) {
    
    FieldRotationListBox.Delete()
    
    FieldRotationArray := Array()
    
    Loop (Globals["Field Rotation"].Count)
        For Key, Value in Globals["Field Rotation"][String(A_Index)]
            If (Key == "FieldName") {
                FieldRotationArray.Push(Value)
                Break
            }
    
    FieldRotationListBox.Add(FieldRotationArray)
    FieldRotationListBox.Choose(Number(Globals["Fields"]["Settings"]["CurrentlySelectedField"]))
    
    AddToFieldRotationListBox.Delete()
    AddToFieldRotationListBox.Add(["Bamboo", "Blue Flower", "Cactus", "Clover", "Coconut", "Dandelion", "Mountain Top", "Mushroom", "Pepper", "Pine Tree", "Pineapple", "Pumpkin", "Rose", "Spider", "Strawberry", "Stump", "Sunflower"])
}

FieldsTabOn := True

FieldsTabSwitch(*) {
    SetFieldsTabValues()
    
    Global FieldsTabOn
    FieldsTabOn := !FieldsTabOn
    
    FieldRotationListBox.Enabled := FieldsTabOn
    
    AddToFieldRotationListBox.Enabled := FieldsTabOn
    
    AddToFieldRotationButton.Enabled := FieldsTabOn
    
    RemoveFromFieldRotationButton.Enabled := FieldsTabOn
    
    MoveUpFieldRotationButton.Enabled := FieldsTabOn
    
    MoveDownFieldRotationButton.Enabled := FieldsTabOn
    
    FieldRotationInfoButton.Enabled := FieldsTabOn
}
