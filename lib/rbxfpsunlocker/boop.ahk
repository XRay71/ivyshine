#Requires AutoHotkey >=v2.0 32-bit
DetectHiddenWindows 1
;PostMessage 0x0010,0xF060,,,"ahk_exe rbxfpsunlocker.exe"
PostMessage 0x8000 + 1,,0x0204,,"ahk_exe rbxfpsunlocker.exe"
MouseMove(10, 220, 0, "R")
Sleep(75)
MouseClick()
Sleep(75)
MouseMove(-10, -220, 0, "R")