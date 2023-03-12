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

CurrentTime() { ; returns unix time in seconds
    Return DateDiff(A_NowUTC, 19700101000000, "Seconds")
}