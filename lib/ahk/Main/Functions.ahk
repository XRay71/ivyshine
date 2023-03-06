ReleaseAllKeys() { ; checks if each key is currently pressed, unpresses and logs
    For Key, Code in Globals["Constants"]["Scan Codes"]
        If (Globals["Variables"]["Keystates"][Code] := GetKeyState(Format("vk{:X}", GetKeyVK(Code))))
            SendInput("{" Code " Up}")
    If (Globals["Variables"]["Keystates"]["LButton"] := GetKeyState("LButton"))
        MouseLeftUp()
}

RestoreKeyStates() { ; re-presses any keys that were released
    For Key, Code in Globals["Constants"]["Scan Codes"]
        If (Globals["Variables"]["Keystates"][Code])
            SendInput("{" Code " Down}")
    If (Globals["Variables"]["Keystates"]["LButton"])
        MouseLeftDown()
}

CurrentTime() { ; returns unix time in seconds
    Return DateDiff(A_NowUTC, 19700101000000, "Seconds")
}

ActivateWindowWithCheck(WindowName, ProcessName) { ; activates a specific window by name AND process name
    DetectHiddenWindowsSetting := A_DetectHiddenWindows
    SetTitleMatchModeSetting := A_TitleMatchMode
    DetectHiddenWindows(1)
    SetTitleMatchMode(3)
    
    WinValues := Array()
    PIDs := Array()
    For Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name='" ProcessName "'")
        PIDs.Push(Process.ProcessId)
    
    If (WIDs := WinGetList(WindowName))
        For WID in WIDS
            For PID in PIDS
                If (WinGetPID(WID) == PID) {
                    WinValues.Push(PID)
                    WinValues.Push(WID)
                    WinValues.Push(WinGetMinMax(WID))
                    WinGetPos(&X, &Y, &W, &H, WID)
                    WinValues.Push(X)
                    WinValues.Push(Y)
                    WinValues.Push(W)
                    WinValues.Push(H)
                    
                    While (!WinActive(WID)) {
                        WinActivate(WID)
                        WinWaitActive(WID,, 0.1)
                    }
                    WinActivate(WID)
                    WinWaitActive(WID)
                    
                    SetTitleMatchMode(SetTitleMatchModeSetting)
                    DetectHiddenWindows(DetectHiddenWindowsSetting)
                    Return WinValues
                }
    
    SetTitleMatchMode(SetTitleMatchModeSetting)
    DetectHiddenWindows(DetectHiddenWindowsSetting)
    Return 0
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
    DllCall("mouse_event", "UInt", 0x8001, "UInt", x * (65535 // A_ScreenWidth), "UInt", y * (65535 // A_ScreenHeight), "UInt", 0, "UInt", 0)
}

MouseWheel(w) {
    DllCall("mouse_event", "UInt", 0x800, "UInt", 0, "UInt", 0, "UInt", w, "UInt", 0, "UInt", 0)
}

; Accurate sleep
; Credits to the Natro dev team & the link below for base function
; https://www.autohotkey.com/boards/viewtopic.php?style=19&t=88693
HyperSleep(ms)
{
    ListLines(0)
    Static SysTimeFreq, SysTimeTick
    If (!IsSet(SysTimeFreq))
        DllCall("QueryPerformanceFrequency", "Int64*", &SysTimeFreq := 0)
    DllCall("QueryPerformanceCounter", "Int64*", &SysTimeTick := 0)
    SysEndTime := SysTimeTick + ms * SysTimeFreq * 0.001
    DllCall("QueryPerformanceCounter", "Int64*", &Current := 0)
    While (Current < SysEndTime) {
        If (SysEndTime - Current) > 30000 {
            DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
            DllCall("QueryPerformanceCounter", "Int64*", &Current)
        }
        Else
            DllCall("QueryPerformanceCounter", "Int64*", &Current)
    }
    ListLines(1)
    Return (Current - SysEndTime) / SysTimeFreq * 1000
}

DefaultErrorBalloonTip(Text, Title, Hwnd) {
    ErrorBalloonTip := Buffer(4 * A_PtrSize)
    NumPut("UInt", ErrorBalloonTip.Size, ErrorBalloonTip, 0)
    NumPut("Ptr", StrPtr(Title), ErrorBalloonTip, A_PtrSize)
    NumPut("Ptr", StrPtr(Text), ErrorBalloonTip, A_PtrSize * 2)
    NumPut("UInt", 3, ErrorBalloonTip, A_PtrSize * 3)
    DllCall("User32.dll\SendMessage", "Ptr", Hwnd, "UInt", 0x1503, "Ptr", 0, "Ptr", ErrorBalloonTip, "Ptr")
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
    , MaxWidth := 600)
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
        TempGUI := Gui()
        TempGUI.SetFont(FontOptions, FontName)
        TempText := TempGUI.Add("Text")
        ResultFont := SendMessage(WM_GETFONT,,,, TempText.Hwnd)
        SendMessage(WM_SETFONT, ResultFont)
        TempGUI.Destroy()
    }
    
    If (X == "" || Y == "")
        DllCall("GetCursorPos", "Int64P", &pt := 0)
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

;=====================================
; Errors
;=====================================

MissingFilesError() {
    MsgBox("It appears that some files are missing!`r`nPlease ensure that you have not moved any files.`r`nThis script will now exit."
        , "Error: file not found!"
        , "OK Icon!")
    ExitApp
}

UnableToCreateFileError() {
    MsgBox("The macro was unable to create needed files!`r`nPlease ensure that the script has enough permissions to do so.`r`nYou may need to run the script as admin.`r`nThis script will now exit."
        , "Error: file not found!"
        , "OK Icon!")
    ExitApp
}
