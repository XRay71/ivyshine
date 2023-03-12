IvyshineGUI.SetFont("s10 Norm cBlack", "Calibri")
IvyshineGUI.Add("GroupBox", "xs+129 y28 w106 h223 Section", "Miscellaneous")
IvyshineGUI.Add("Text", "xs+8 ys+20 wp-12 0x10 Section")

IvyshineGUI.SetFont()
IvyshineGUI.SetFont("s8", "Calibri")

MoveSpeedCorrectionCheckBox := IvyshineGUI.Add("CheckBox", "xs ys+4 h18 w90 -Wrap vMoveSpeedCorrectionCheckBox", "Adjust speed?")
MoveSpeedCorrectionCheckBox.OnEvent("Click", SubmitSettings)

ShiftlockMovingCheckBox := IvyshineGUI.Add("CheckBox", "xs yp+17 h18 w90 -Wrap vShiftLockWhenPossibleCheckBox", "Shiftlock move?")
ShiftlockMovingCheckBox.OnEvent("Click", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+20 h17 -Wrap +BackgroundTrans", "Key Delay:")
AdditionalKeyDelayEdit := IvyshineGUI.Add("Edit", "xs+60 yp-2 w30 h17 Right Limit3 Number -Wrap vAdditionalKeyDelayEdit")
AdditionalKeyDelayEdit.OnEvent("LoseFocus", SubmitSettings)

IvyshineGUI.Add("Text", "xs yp+20 h20 -Wrap +BackgroundTrans", "Reset Multiplier: ")
ResetMultiplierSlider := IvyshineGUI.Add("Slider", "xs yp+18 h20 w90 Page1 Range1-5 TickInterval1 ToolTip vResetMultiplierSlider")
ResetMultiplierSlider.OnEvent("Change", SubmitSettings)

ImportSettingsButton := IvyshineGUI.Add("Button", "xs yp+26 h20 w90 -Wrap Center vImportSettingsButton", "Import Settings")
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
                ReadIni(ini, Globals["Field Defaults"])
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

ResetButton := IvyshineGUI.Add("Button", "xs yp+22 h20 w90 vResetButton", "Restore Defaults")
ResetButton.OnEvent("Click", ResetAll)

ResetAll(*) {
    Reset := MsgBox("This will reset the entire macro to its default settings, excluding stats.", "Warning!", "OKCancel Icon! Default2 Owner" IvyshineGUI.Hwnd)
    If (Reset == "OK") {
        Globals := ""
        #IncludeAgain *i ..\..\..\init\Globals.ahk
        For ini in Globals
        {
            If (FileExist(Globals["Constants"]["ini FilePaths"][ini]))
                FileDelete(Globals["Constants"]["ini FilePaths"][ini])
            If (ini != "Field Rotation")
                UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
        }
        Reload
    }
}
