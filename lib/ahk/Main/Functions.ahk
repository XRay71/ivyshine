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

; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=84750
CustomToolTip(Content
    , Title := ""
    , X := ""
    , Y := ""
    , Icon := 0 ; 0 — None, 1 — Info, 2 — Warning, 3 — Error, >3 — hIcon
    , Transparent := False
    , CloseButton := False
    , BackColor := ""
    , TextColor := 0
    , FontName := ""
    , FontOptions := "" ; like in GUI
    , IsBalloon := False
    , Timeout := ""
    , MaxWidth := 600 )
{
    Static ttStyles := (TTS_NOPREFIX := 2) | (TTS_ALWAYSTIP := 1)
        , TTS_BALLOON := 0x40
        , TTS_CLOSE := 0x80
        , TTF_TRACK := 0x20
        , TTF_ABSOLUTE := 0x80
        , TTM_SETMAXTIPWIDTH := 0x418
        , TTM_TRACKACTIVATE := 0x411
        , TTM_TRACKPOSITION := 0x412
        , TTM_SETTIPBKCOLOR := 0x413
        , TTM_SETTIPTEXTCOLOR := 0x414
        , TTM_ADDTOOL := 0x432
        , TTM_SETTITLE := 0x421
        , TTM_UPDATETIPTEXT := 0x439
        , exStyles := (WS_EX_TOPMOST := 0x00000008) | (WS_EX_COMPOSITED := 0x2000000) | (WS_EX_LAYERED := 0x00080000)
        , WM_SETFONT := 0x30
        , WM_GETFONT := 0x31
        
        (Transparent && exStyles |= WS_EX_TRANSPARENT := 0x20)
    dhwPrev := A_DetectHiddenWindows
    DetectHiddenWindows(1)
    lastFoundPrev := WinExist()
    hWnd := DllCall("CreateWindowEx"
    , "UInt", exStyles
    , "Str", "tooltips_class32"
    , "Str", ""
    , "UInt", ttStyles | TTS_CLOSE * !!CloseButton | TTS_BALLOON * !!IsBalloon
    , "Int", 0
    , "Int", 0
    , "Int", 0
    , "Int", 0
    , "Ptr", 0
    , "Ptr", 0
    , "Ptr", 0
    , "Ptr", 0
    , "Ptr")
    
    WinExist("ahk_id" hWnd)
    If (TextColor != 0 || BackColor != "") {
        DllCall("UxTheme\SetWindowTheme", "Ptr", hWnd, "Ptr", 0, "UShortP", Empty := 0)
        ByteSwap := DllCall.Bind("msvcr100\_byteswap_ulong", "UInt")
        SendMessage(TTM_SETTIPBKCOLOR, ByteSwap.Call(BackColor << 8, "CDecl"))
        SendMessage(TTM_SETTIPTEXTCOLOR, ByteSwap.Call(TextColor << 8, "CDecl"))
    }
    
    If (FontName || FontOptions) {
        TempGui := Gui()
        TempGui.SetFont(FontOptions, FontName)
        TempText := TempGui.Add("Text")
        ResultFont := SendMessage(WM_GETFONT,,,, TempText.Hwnd)
        SendMessage(WM_SETFONT, ResultFont)
        TempGui.Destroy()
    }
    
    If (X == "" || Y == "")
        DllCall("GetCursorPos", "Int64P", pt)
    (X == "" && X := (pt & 0xFFFFFFFF) + 15), (Y == "" && Y := (pt >> 32) + 15)
    
    TOOLINFO := Buffer(24 + A_PtrSize * 6)
    NumPut("UInt", TOOLINFO.Size, TOOLINFO)
    NumPut("UPtr", TTF_TRACK | TTF_ABSOLUTE * !IsBalloon, TOOLINFO, 4)
    NumPut("UPtr", StrPtr(Content), TOOLINFO, 24 + A_PtrSize * 3)
    
    SendMessage(TTM_SETTITLE      , Icon, StrPtr(Title))
    SendMessage(TTM_TRACKPOSITION ,     , X | (Y << 16))
    SendMessage(TTM_SETMAXTIPWIDTH,     , MaxWidth)
    SendMessage(TTM_ADDTOOL       ,     , TOOLINFO)
    SendMessage(TTM_UPDATETIPTEXT ,     , TOOLINFO)
    SendMessage(TTM_TRACKACTIVATE , True, TOOLINFO)
    
    If Timeout {
        Timer := DllCall.Bind("DestroyWindow", "Ptr", hWnd)
        SetTimer(Timer, -Timeout)
    }
    
    WinExist("ahk_id" lastFoundPrev)
    DetectHiddenWindows(dhwPrev)
    Return hWnd
}
