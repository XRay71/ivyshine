IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x8 y28 w204 h315 Section", "Field Rotation")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

IvyshineGui.Add("Text", "xs ys+6 h20 w80 Center +BackgroundTrans", "Chosen Order")

FieldRotationArray := Array()

For FieldNumber, Pair in Globals["Field Rotation"]
    For Key, Value in Pair
        If (Key == "FieldName") {
            FieldRotationArray.Push(Value)
            Break
        }

Globals["Fields"]["Settings"]["CurrentlySelectedField"] := (Globals["Fields"]["Settings"]["CurrentlySelectedField"] > FieldRotationArray.Length ? FieldRotationArray.Length : Globals["Fields"]["Settings"]["CurrentlySelectedField"])

FieldRotationListBox := IvyshineGui.Add("ListBox", "xs ys+20 h268 w80 0x100 Choose" Globals["Fields"]["Settings"]["CurrentlySelectedField"], FieldRotationArray)
FieldRotationListBox.OnEvent("Change", SubmitFields)

AddFieldRotationListBox := IvyshineGui.Add("ListBox", "xs+106 ys+20 h268 w80 0x100 Sort", ["Bamboo", "Blue Flower", "Cactus", "Clover", "Coconut", "Dandelion", "Mountain Top", "Mushroom", "Pepper", "Pine Tree", "Pineapple", "Pumpkin", "Rose", "Spider", "Strawberry", "Stump", "Sunflower"])
AddFieldRotationListBox.OnEvent("Change", SubmitFields)
IvyshineGui.Add("Text", "xp ys+6 h20 w80 Center +BackgroundTrans", "Add Fields")

