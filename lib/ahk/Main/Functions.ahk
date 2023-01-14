ReleaseAllKeys()
{
    Loop(26)
        Send("{" Chr(96 + A_Index) " Up}")
    Loop(10)
        Send("{" (A_Index - 1) " Up}")
    Send("{Alt Up}")
    Send("{Space Up}")
    Send("{Shift Up}")
    Send("{Escape Up}")
    Send("{Control Up}")
    Click("Up")
}

TimeSince(OriginalTime)
{
    Return DateDiff(A_NowUTC, OriginalTime, "Seconds")
}

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
    SysX := 65535 // A_ScreenWidth
    SysY := 65535 // A_ScreenHeight
    DllCall("mouse_event", "UInt", 0x8001, "UInt", x * SysX, "UInt", y * SysY, "UInt", 0, "UInt", 0)
}

MouseWheel(w) {
    DllCall("mouse_event", "UInt", 0x800, "UInt", 0, "UInt", 0, "UInt", w, "UInt", 0, "UInt", 0)
}

; Modified Hypersleep by the Natro dev team :D
HyperSleep(ms)
{
    DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
    Loop(ms)
        DllCall("Sleep", "UInt", 1)
    DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
}