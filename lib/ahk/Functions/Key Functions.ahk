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

PressKey(Key, State := "") { ; presses a specified key in a specified state, returns unslept time
    Diff := 0
    If (State)
        Send("{" Globals["Constants"]["Scan Codes"][Key] " " State "}")
    Else {
        Send("{" Globals["Constants"]["Scan Codes"][Key] " Down}")
        Diff := HyperSleep(30 + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"]) ; least amount of time Roblox requires to detect keypress
        Send("{" Globals["Constants"]["Scan Codes"][Key] " Up}")
    }
    Return Diff
}