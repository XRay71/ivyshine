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

