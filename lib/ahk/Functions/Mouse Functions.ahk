MouseLeftClick() {
    DllCall("mouse_event", "UInt", 0x02, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
    DllCall("mouse_event", "UInt", 0x04, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
}

MouseLeftDown() {
    DllCall("mouse_event", "UInt", 0x02, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
}

MouseLeftUp() {
    DllCall("mouse_event", "UInt", 0x04, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
}

MouseRightClick() {
    DllCall("mouse_event", "UInt", 0x08, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
    DllCall("mouse_event", "UInt", 0x10, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
}

MouseRightDown() {
    DllCall("mouse_event", "UInt", 0x08, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
}

MouseRightUp() {
    DllCall("mouse_event", "UInt", 0x10, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
}

MouseMiddleClick() {
    DllCall("mouse_event", "UInt", 0x20, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
    DllCall("mouse_event", "UInt", 0x40, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
}

MouseRelativeMove(x, y) {
    DllCall("mouse_event", "UInt", 0x01, "UInt", x, "UInt", y, "UInt", 0, "UInt", 0)
}

MouseAbsoluteMove(x, y) {
    DllCall("mouse_event", "UInt", 0x8001, "UInt", x * (65535 // A_ScreenWidth), "UInt", y * (65535 // A_ScreenHeight), "UInt", 0, "UInt", 0)
}

MouseWheel(w) {
    DllCall("mouse_event", "UInt", 0x800, "UInt", 0, "UInt", 0, "UInt", w, "UInt", 0, "UInt", 0)
}