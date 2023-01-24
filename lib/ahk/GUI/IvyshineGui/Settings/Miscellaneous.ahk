IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGui.Add("GroupBox", "x434 y28 w106 h223 Section", "Miscellaneous")
IvyshineGui.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGui.SetFont()
IvyshineGui.SetFont("s8", "Calibri")

MoveSpeedCorrectionCheckBox := IvyshineGui.Add("CheckBox", "xs yp+6 h18 w90 -Wrap vMoveSpeedCorrectionCheckBox Checked" Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"], "Correct speed?")
MoveSpeedCorrectionCheckBox.OnEvent("Click", SubmitSettings)

ShiftlockMovingCheckBox := IvyshineGui.Add("CheckBox", "xs yp+17 h18 w90 -Wrap vShiftLockWhenPossibleCheckBox Checked" Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"], "Shiftlock move?")
ShiftlockMovingCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+20 h17 -Wrap +BackgroundTrans", "Key Delay:")
AdditionalKeyDelayEdit := IvyshineGui.Add("Edit", "xs+60 yp-2 w30 h17 Right Limit3 Number -Wrap vAdditionalKeyDelayEdit")
SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
AdditionalKeyDelayEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGui.Add("Text", "xs yp+20 h20 -Wrap +BackgroundTrans", "Reset Multiplier: ")
ResetMultiplierSlider := IvyshineGui.Add("Slider", "xs yp+18 h20 w90 Page1 Range1-5 TickInterval1 ToolTip vResetMultiplierSlider", Globals["Settings"]["Miscellaneous"]["ResetMultiplier"])
ResetMultiplierSlider.OnEvent("Change", SubmitSettings)

ImportSettingsButton := IvyshineGui.Add("Button", "xs yp+26 h20 w90 -Wrap Center", "Import Settings")
ImportSettingsButton.OnEvent("Click", ImportSettings)

ImportSettings(*) {
    OpenedFiles := FileSelect("M 3",,, "Configuration Files (*.ini)")
    If (OpenedFiles.Length) {
        For ini in OpenedFiles {
            If (InStr(ini, "\constants.ini"))
                ReadIni(ini, Globals["Constants"])
            Else If (InStr(ini, "\settings.ini"))
                ReadIni(ini, Globals["Settings"])
            Else If (InStr(ini, "\gui.ini"))
                ReadIni(ini, Globals["GUI"])
            Else If (InStr(ini, "\fieldsettings.ini"))
                ReadIni(ini, Globals["Field Settings"])
            Else If (InStr(ini, "\fields.ini"))
                ReadIni(ini, Globals["Fields"])
            Else If (InStr(ini, "\boostsettings.ini"))
                ReadIni(ini, Globals["Boost Settings"])
            Else If (InStr(ini, "\boost.ini"))
                ReadIni(ini, Globals["Boost"])
            Else If (InStr(ini, "\stats.ini"))
                Responded := MsgBox("You are not allowed to import stats!", "Error: invalid ini!", "OK Iconx")
            Else
                Responded := MsgBox("That ini file does not correspond with any known settings in the macro!", "Error: invalid ini!", "OK Icon!")
        }
        
        For ini, Section in Globals
            UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        
        ReloadMacro()
    }
}