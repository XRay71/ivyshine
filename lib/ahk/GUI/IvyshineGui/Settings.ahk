MainTabs.UseTab(1)

#Include *i Settings\Basic Settings.ahk
ResetButton := IvyshineGui.Add("Button", "x424 y280 w116 h33 vResetButton", "Restore Defaults")
ResetButton.OnEvent("Click", ResetAll)

ResetAll(*) {
    Global Globals
    Reset := MsgBox("This will reset the entire macro to its default settings, excluding stats.", "Warning!", "OKCancel Icon! Default2")
    If (Reset == "OK") {
        #IncludeAgain *i ..\..\init\Globals.ahk
        For ini, Section in Globals
        {
            If (FileExist(Globals["Constants"]["Ini FilePaths"][ini]))
                FileDelete(Globals["Constants"]["Ini FilePaths"][ini])
            
            UpdateIni(Globals["Constants"]["Ini FilePaths"][ini], Globals[ini])
            ReloadMacro()
        }
    }
}

SubmitSettingsButton := IvyshineGui.Add("Button", "x0 y0 w1 h1 Hidden Default -Tabstop")
SubmitSettingsButton.OnEvent("Click", SubmitSettings)

SubmitSettings(*) {
    Global Globals
    Global MoveSpeedEdit
    NewMoveSpeed := MoveSpeedEdit.Value
    If (IsNumber(NewMoveSpeed) && NewMoveSpeed <= 50 && NewMoveSpeed > 0) {
        NewMoveSpeed := Round(Number(NewMoveSpeed), 2)
        Globals["Settings"]["Basic Settings"]["MoveSpeed"] := NewMoveSpeed
        IniWrite(NewMoveSpeed, Globals["Constants"]["Ini FilePaths"]["Settings"], "Basic Settings", "MoveSpeed")
        SetCueBanner(MoveSpeedEdit.Hwnd, NewMoveSpeed)
    }
    MoveSpeedEdit.Text := MoveSpeedEdit.Value := ""
}