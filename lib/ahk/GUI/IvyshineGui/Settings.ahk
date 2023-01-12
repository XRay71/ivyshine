MainTabs.UseTab(1)

#Include *i Settings\Basic Settings.ahk

IvyshineGui.SetFont()
IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")

ResetButton := IvyshineGui.Add("Button", "x7 yp+26 w151 h36 vResetButton", "Restore Defaults")
ResetButton.OnEvent("Click", ResetAll)

#Include *i Settings\Unlocks.ahk

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
            IniWrite(Globals["Settings"]["Basic Settings"]["MoveSpeed"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveSpeed")
            SetCueBanner(MoveSpeedEdit.Hwnd, Globals["Settings"]["Basic Settings"]["MoveSpeed"])
        }
        MoveSpeedEdit.Text := MoveSpeedEdit.Value := ""
    }
    
    Global MoveMethodList
    Else If (ThisControl.Hwnd == MoveMethodList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["MoveMethod"] := MoveMethodList.Text
        IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
        
        For Field in Globals["Field Settings"] {
            If (!Globals["Field Settings"][Field]["SettingsModified"]) {
                Globals["Field Settings"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Settings"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"])
                IniWrite(Globals["Field Settings"][Field]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Field Settings"], Field, "MoveMethod")
            }
        }
    }
    
    Global NumberOfSprinklersList
    Else If (ThisControl.Hwnd == NumberOfSprinklersList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"] := NumberOfSprinklersList.Value
        IniWrite(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "NumberOfSprinklers")
    }
    
    Global HiveSlotList
    Else If (ThisControl.Hwnd == HiveSlotList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["HiveSlotNumber"] := HiveSlotList.Value
        IniWrite(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "HiveSlotNumber")
    }
    
    Global PrivateServerLinkEdit
    Else If (ThisControl.Hwnd == PrivateServerLinkEdit.Hwnd) {
        NewPrivateServerLink := StrReplace(Trim(PrivateServerLinkEdit.Value), " ")
        PrivateServerLinkEdit.Text := PrivateServerLinkEdit.Value := ""
        If (!NewPrivateServerLink && !SubmitButton)
            SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
        Else If ((!NewPrivateServerLink && SubmitButton)|| RegExMatch(NewPrivateServerLink, "i)^((http(s)?):\/\/)?((www|web)\.)?roblox\.com\/games\/(1537690962|4189852503)\/?([^\/]*)\?privateServerLinkCode=.{32}(\&[^\/]*)*$")) {
            Globals["Settings"]["Basic Settings"]["PrivateServerLink"] := NewPrivateServerLink
            IniWrite(Globals["Settings"]["Basic Settings"]["PrivateServerLink"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "PrivateServerLink")
            SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
        } Else{
            PrivateServerLinkMsgBoxResponded := MsgBox("It appears that the link you provided is invalid!`r`nPlease copy and paste it directly from the private server configuration page.", "Error: invalid link.", "OK Icon! Owner" IvyshineGui.Hwnd)
            SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
        }
    }
    
    Global UnlockedRedCannonCheckBox
    Else If (ThisControl.Hwnd == UnlockedRedCannonCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["UnlockedRedCannon"] := UnlockedRedCannonCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["UnlockedRedCannon"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "UnlockedRedCannon")
    }
    
    Global UnlockedParachuteCheckBox
    Global UnlockedGliderCheckBox
    Else If (ThisControl.Hwnd == UnlockedParachuteCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["UnlockedParachute"] := UnlockedParachuteCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["UnlockedParachute"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "UnlockedParachute")
        
        If (Globals["Settings"]["Unlocks"]["UnlockedParachute"]) {
            MoveMethodList.Delete()
            MoveMethodList.Add(["Default", "Walk", "Glider", "Cannon"])
            MoveMethodList.Choose(Globals["Settings"]["Basic Settings"]["MoveMethod"])
            Globals["Settings"]["Basic Settings"]["MoveMethod"] := MoveMethodList.Text
            IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
            UnlockedGliderCheckBox.Enabled := True
        } Else {
            MoveMethodList.Delete()
            MoveMethodList.Add(["Walk"])
            MoveMethodList.Choose("Walk")
            Globals["Settings"]["Basic Settings"]["MoveMethod"] := MoveMethodList.Text
            IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
            UnlockedGliderCheckBox.Enabled := False
            UnlockedGliderCheckBox.Value := 0
            Globals["Settings"]["Unlocks"]["UnlockedGlider"] := UnlockedGliderCheckBox.Value
            IniWrite(Globals["Settings"]["Unlocks"]["UnlockedGlider"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "UnlockedGlider")
        }
    }
    
    Else If (ThisControl.Hwnd == UnlockedGliderCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["UnlockedGlider"] := UnlockedGliderCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["UnlockedGlider"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "UnlockedGlider")
    }
    
    Global HasGummyMaskCheckBox
    Else If (ThisControl.Hwnd == HasGummyMaskCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasGummyMask"] := HasGummyMaskCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasGummyMask"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGummyMask")
    }
    
    Global HasDiamondMaskCheckBox
    Else If (ThisControl.Hwnd == HasDiamondMaskCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasDiamondMask"] := HasDiamondMaskCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasDiamondMask"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDiamondMask")
    }
    
    Global HasDemonMaskCheckBox
    Else If (ThisControl.Hwnd == HasDemonMaskCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasDemonMask"] := HasDemonMaskCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasDemonMask"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDemonMask")
    }
    
    Global HasPetalWandCheckBox
    Else If (ThisControl.Hwnd == HasPetalWandCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasPetalWand"] := HasPetalWandCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasPetalWand"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasPetalWand")
    }
    
    Global HasTidePopperCheckBox
    Else If (ThisControl.Hwnd == HasTidePopperCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasTidePopper"] := HasTidePopperCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasTidePopper"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasTidePopper")
    }
    
    Global HasDarkScytheCheckBox
    Else If (ThisControl.Hwnd == HasDarkScytheCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasDarkScythe"] := HasDarkScytheCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasDarkScythe"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDarkScythe")
    }
    
    Global NumberOfBeesEdit
    Else If (ThisControl.Hwnd == NumberOfBeesEdit.Hwnd) {
        NewNumberOfBees := Trim(NumberOfBeesEdit.Value)
        If (IsInteger(NewNumberOfBees) && NewNumberOfBees <= 50 && NewNumberOfBees > 0) {
            NewNumberOfBees := Round(Integer(NewNumberOfBees))
            Globals["Settings"]["Basic Settings"]["NumberOfBees"] := NewNumberOfBees
            IniWrite(Globals["Settings"]["Basic Settings"]["NumberOfBees"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "NumberOfBees")
            SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Basic Settings"]["NumberOfBees"])
        }
        NumberOfBeesEdit.Text := NumberOfBeesEdit.Value := ""
    }
}