PressKey(Key, State := "") { ; presses a specified key in a specified state, returns unslept time
    Diff := 0
    If (State)
        Send("{" Globals["Constants"]["Scan Codes"][Key] " " State "}")
    Else {
        Send("{" Globals["Constants"]["Scan Codes"][Key] " Down}")
        Diff := HyperSleep(20) ; least amount of time Roblox requires to detect keypress
        Send("{" Globals["Constants"]["Scan Codes"][Key] " Up}")
    }
    Return Diff
}

Move(Keys, MoveTime) { ; movement in game, in ms. Returns difference
    For Key in Keys
        PressKey(Key, "Down")
    Diff := HyperSleep(MoveTime * Globals["Settings"]["Basic Settings"]["MoveSpeed"] / Globals["Constants"]["Game Values"]["Base MoveSpeed"] + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
    For Key in Keys
        PressKey(Key, "Up")
    Return Diff
}

MoveFlowers(Keys, NumFlowers) { ; movement in game, in terms of flower tiles. Returns difference
    For Key in Keys
        PressKey(Key, "Down")
    Diff := HyperSleep(NumFlowers * Globals["Constants"]["Game Values"]["Flower Length"] * Globals["Constants"]["Game Values"]["Base MoveSpeed"] / Globals["Settings"]["Basic Settings"]["MoveSpeed"] + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
    For Key in Keys
        PressKey(Key, "Up")
    Return Diff
}

Jump(Duration := 150) { ; jumps. Default is apex of movement
    Diff := PressKey("Space")
    Return HyperSleep(Abs(Duration - Diff) + Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
}

DeployGlider(OnGround := 0) { ; deploys glider
    Jump(OnGround ? Globals["Constants"]["Game Values"]["Jump Duration"] / 2 : 75)
    Jump(0)
}

