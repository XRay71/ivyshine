IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x+64 y28 w132 h223 Section", "Miscellanous")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

Boo := IvyshineGui.Add("Button", "xs+8 ys+8 w100 Hidden")
Boo.OnEvent("Click", hi)

hi(*){
    MsgBox("Boo")
}