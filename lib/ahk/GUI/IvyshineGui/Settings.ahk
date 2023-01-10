MainTabs.UseTab(1)

#Include *i Settings\Basic Settings.ahk
ResetButton := IvyshineGui.Add("Button", "x424 y280 w116 h33 vResetButton", "Restore Defaults")
ResetButton.OnEvent("Click", ResetAll)

ResetAll(*) {
    Global Globals, IvyshineGui
    Reset := MsgBox("This will reset the entire macro to its default settings, excluding stats.", "Warning!", "OKCancel Icon! Default2 Owner" IvyshineGui.Hwnd)
    If (Reset == "OK") {
        #IncludeAgain *i ..\..\init\Globals.ahk
        For ini, Section in Globals
        {
            If (FileExist(Globals["Constants"]["ini FilePaths"][ini]))
                FileDelete(Globals["Constants"]["ini FilePaths"][ini])
            
            UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
            ReloadMacro()
        }
    }
}

SubmitSettingsButton := IvyshineGui.Add("Button", "x0 y0 w1 h1 Hidden +Default")
SubmitSettingsButton.OnEvent("Click", SubmitSettings)

SubmitSettings(ThisControl, *) {
    Global Globals
    Global IvyshineGui
    
    SubmitButton := 0
    Global SubmitSettingsButton
    If (ThisControl.Hwnd == SubmitSettingsButton.Hwnd) {
        ThisControl := IvyshineGui.FocusedCtrl
        SubmitButton := 1
    }
    
    Global MoveSpeedEdit
    If (ThisControl.Hwnd == MoveSpeedEdit.Hwnd) {
        NewMoveSpeed := Trim(MoveSpeedEdit.Value)
        If (IsNumber(NewMoveSpeed) && NewMoveSpeed <= 50 && NewMoveSpeed > 0) {
            NewMoveSpeed := Round(Number(NewMoveSpeed), 2)
            Globals["Settings"]["Basic Settings"]["MoveSpeed"] := NewMoveSpeed
            IniWrite(NewMoveSpeed, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveSpeed")
            SetCueBanner(MoveSpeedEdit.Hwnd, NewMoveSpeed)
        }
        MoveSpeedEdit.Text := MoveSpeedEdit.Value := ""
    }
    
    Global MoveMethodList
    Else If (ThisControl.Hwnd == MoveMethodList.Hwnd) {
        NewMoveMethod := MoveMethodList.Text
        Globals["Settings"]["Basic Settings"]["MoveMethod"] := NewMoveMethod
        IniWrite(NewMoveMethod, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
    }
    
    Global NumberOfSprinklersList
    Else If (ThisControl.Hwnd == NumberOfSprinklersList.Hwnd) {
        NewNumberOfSprinklers := NumberOfSprinklersList.Value
        Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"] := NewNumberOfSprinklers
        IniWrite(NewNumberOfSprinklers, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "NumberOfSprinklers")
    }
    
    Global HiveSlotList
    Else If (ThisControl.Hwnd == HiveSlotList.Hwnd) {
        NewHiveSlotNumber := HiveSlotList.Value
        Globals["Settings"]["Basic Settings"]["HiveSlotNumber"] := NewHiveSlotNumber
        IniWrite(NewHiveSlotNumber, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "HiveSlotNumber")
    }
    
    Global PrivateServerLinkEdit
    Else If (ThisControl.Hwnd == PrivateServerLinkEdit.Hwnd) {
        NewPrivateServerLink := StrReplace(Trim(PrivateServerLinkEdit.Value), " ")
        PrivateServerLinkEdit.Text := PrivateServerLinkEdit.Value := ""
        If (!NewPrivateServerLink && !SubmitButton)
            SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
        Else If ((!NewPrivateServerLink && SubmitButton)|| RegExMatch(NewPrivateServerLink, "i)^((http(s)?):\/\/)?((www|web)\.)?roblox\.com\/games\/(1537690962|4189852503)\/?([^\/]*)\?privateServerLinkCode=.{32}(\&[^\/]*)*$")) {
            Globals["Settings"]["Basic Settings"]["PrivateServerLink"] := NewPrivateServerLink
            IniWrite(NewPrivateServerLink, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "PrivateServerLink")
            SetCueBanner(PrivateServerLinkEdit.Hwnd, NewPrivateServerLink)
        } Else{
            PrivateServerLinkMsgBoxResponded := MsgBox("It appears that the link you provided is invalid!`r`nPlease copy and paste it directly from the private server configuration page.", "Error: invalid link.", "OK Icon! Owner" IvyshineGui.Hwnd)
            SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
        }
    }
}