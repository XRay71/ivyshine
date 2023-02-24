HiveToCorner() {
    RunMovement(
        (
            "Move([`"w`"], 800)`r`n"
            "Move([`"d`"], Globals[`"Settings`"][`"Basic Settings`"][`"HiveSlotNumber`"] * 1250)`r`n"
        )
    )
    While (!MovementFlag)
        Sleep(0)
    While (MovementFlag)
        Sleep(0)
    EndMovement()
}