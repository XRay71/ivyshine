HiveToCorner() {
    RunMovement(
        (
            "Move([`"w`"], 800)`r`n"
            "Move([`"d`"], Globals[`"Settings`"][`"Basic Settings`"][`"HiveSlotNumber`"] * 1250)`r`n"
        )
    )
    KeyWait("F14", "D T5 L")
    KeyWait("F14", "T60 L")
    EndMovement()
}