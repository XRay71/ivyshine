IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x8 y28 w204 h315 Section", "Boost Rotation")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

FieldRotationArray := Array()

Loop (Globals["Field Rotation"].Count)
    For Key, Value in Globals["Field Rotation"][String(A_Index)]
        If (Key == "FieldName") {
            FieldRotationArray.Push(Value)
            Break
        }

Globals["Fields"]["Settings"]["CurrentlySelectedField"] := (Globals["Fields"]["Settings"]["CurrentlySelectedField"] > FieldRotationArray.Length ? FieldRotationArray.Length : Globals["Fields"]["Settings"]["CurrentlySelectedField"])

IvyshineGui.Add("Text", "xs ys+6 h20 w80 Center +BackgroundTrans", "Chosen Order")
FieldRotationListBox := IvyshineGui.Add("ListBox", "xs ys+20 h268 w80 0x100 vFieldRotationListBox Choose" Globals["Fields"]["Settings"]["CurrentlySelectedField"], FieldRotationArray)
FieldRotationListBox.OnEvent("Change", SubmitFields)

IvyshineGui.Add("Text", "xs+106 ys+6 h20 w80 Center +BackgroundTrans", "Add Fields")
AddToFieldRotationListBox := IvyshineGui.Add("ListBox", "xs+106 ys+20 h268 w80 0x100 vAddToFieldRotationListBox Sort", ["Bamboo", "Blue Flower", "Cactus", "Clover", "Coconut", "Dandelion", "Mountain Top", "Mushroom", "Pepper", "Pine Tree", "Pineapple", "Pumpkin", "Rose", "Spider", "Strawberry", "Stump", "Sunflower"])
AddToFieldRotationListBox.OnEvent("Change", SubmitFields)

AddToFieldRotationButton := IvyShineGui.Add("Button", "xs+83 ys+141 w20 h20 vAddToFieldRotationButton", "◀")
AddToFieldRotationButton.OnEvent("Click", AddToFieldRotation)

AddToFieldRotation(*) {
    If (Field := AddToFieldRotationListBox.Text) {
        NewIndex := String(Globals["Field Rotation"].Count + 1)
        Globals["Field Rotation"][NewIndex] := Map()
        Globals["Field Rotation"][NewIndex] := Globals["Field Defaults"][Field].Clone()
        Globals["Field Rotation"][NewIndex]["FieldName"] := Field
        UpdateIni(Globals["Constants"]["ini FilePaths"]["Field Rotation"], Globals["Field Rotation"])
        AddToFieldRotationListBox.Choose(0)
        AddToFieldRotationListBox.Focus()
        FieldRotationListBox.Add([Field])
        FieldRotationListBox.Choose(Number(NewIndex))
        Globals["Fields"]["Settings"]["CurrentlySelectedField"] := FieldRotationListBox.Value
        IniWrite(FieldRotationListBox.Value, Globals["Constants"]["ini FilePaths"]["Fields"], "Settings", "CurrentlySelectedFields")
    }
}

RemoveFromFieldRotationButton := IvyShineGui.Add("Button", "xs+83 yp+20 w20 h20 vRemoveFromFieldRotationButton", "▶")
RemoveFromFieldRotationButton.OnEvent("Click", RemoveFromFieldRotation)

RemoveFromFieldRotation(*) {
    If ((Index := FieldRotationListBox.Value) && Globals["Field Rotation"].Count != 1) {
        i := Index
        If (i != Globals["Field Rotation"].Count)
            Loop {
                Globals["Field Rotation"][String(i)] := Globals["Field Rotation"][String(i + 1)].Clone()
                i++
            } Until (i == Globals["Field Rotation"].Count)
        Globals["Field Rotation"].Delete(String(Globals["Field Rotation"].Count))
        FieldRotationListBox.Delete(Index)
        FieldRotationListBox.Choose(Min(Index, Globals["Field Rotation"].Count))
        UpdateIni(Globals["Constants"]["ini FilePaths"]["Field Rotation"], Globals["Field Rotation"])
        Globals["Fields"]["Settings"]["CurrentlySelectedField"] := FieldRotationListBox.Value
        IniWrite(FieldRotationListBox.Value, Globals["Constants"]["ini FilePaths"]["Fields"], "Settings", "CurrentlySelectedFields")
    }
}

FieldRotationInfoButton := IvyshineGui.Add("Button", "xs+83 ys-19 h16 w15 vFieldRotationInfoButton", "?")
FieldRotationInfoButton.OnEvent("Click", ShowFieldRotationInfo)

ShowFieldRotationInfo(*) {
    MsgBox("This is the chronological list of fields the macro will use.`r`nThere will always be one field in the list for the macro to go to when there's nothing else to do.`r`n`r`nADDING A FIELD: Select a field in the `"Add Fields`" column and press ◀ to add it to the bottom of the field rotation.`r`n`r`nREMOVING A FIELD: Press ▶ while selecting a field in the field rotation to remove it from the list.`r`n`r`nMOVING A FIELD: Use the ▲ and ▼ buttons to shift the ordering of the selected field in the rotation.`r`n`r`nThe field that you select is the one that the macro will start on."
        , "What is the Field Rotation?"
        , "Icon? Owner" IvyshineGui.Hwnd)
}
