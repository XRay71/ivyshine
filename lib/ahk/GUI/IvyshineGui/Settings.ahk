MainTabs.UseTab(1)

#Include *i Settings\Basic Settings.ahk
#Include *i Settings\rbxfpsunlocker.ahk
#Include *i Settings\CollectKill.ahk

IvyshineGui.SetFont()
IvyshineGui.SetFont("s10 Norm cBlack", "Calibri")

ResetButton := IvyshineGui.Add("Button", "x7 ys+50 w151 h20 vResetButton", "Restore Defaults")
ResetButton.OnEvent("Click", ResetAll)

#Include *i Settings\Unlocks.ahk
#Include *i Settings\Hotkeys.ahk
#Include *i Settings\Miscellaneous.ahk
#Include *i Settings\AntiAFK.ahk
#Include *i Settings\Keybinds.ahk
#Include *i Settings\Autoclicker.ahk

#Include *i ..\EditHotkeysGui\Edit Hotkeys.ahk
ShowEditHotkeysGui := False

Try
EditHotkeysGui.Show("Hide")
Catch Any
    MissingFilesError()

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

SubmitSettingsButton := IvyshineGui.Add("Button", "x0 y0 w1 h1 Hidden +Default vSubmitSettingsButton")
SubmitSettingsButton.OnEvent("Click", SubmitSettings)

SubmitSettings(ThisControl, *) {
    Global Globals
    Global IvyshineGui
    
    SubmitButton := False
    Global SubmitSettingsButton
    If (ThisControl.Hwnd == SubmitSettingsButton.Hwnd) {
        ThisControl := IvyshineGui.FocusedCtrl
        SubmitButton := True
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
    
    Global HiveSlotNumberList
    Else If (ThisControl.Hwnd == HiveSlotNumberList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["HiveSlotNumber"] := HiveSlotNumberList.Value
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
        } Else {
            PrivateServerLinkMsgBoxResponded := MsgBox("It appears that the link you provided is invalid!`r`nPlease copy and paste it directly from the private server configuration page.", "Error: invalid link.", "OK Icon! Owner" IvyshineGui.Hwnd)
            SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
        }
    }
    
    Global RunrbxfpsunlockerCheckBox
    Global FPSEdit
    Else If (ThisControl.Hwnd == RunrbxfpsunlockerCheckBox.Hwnd) {
        RunrbxfpsunlockerCheckBox.Enabled := False
        FPSEdit.Enabled := False
        Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"] := RunrbxfpsunlockerCheckBox.Value
        IniWrite(Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"], Globals["Constants"]["ini FilePaths"]["Settings"], "rbxfpsunlocker", "Runrbxfpsunlocker")
        If (Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"]) {
            SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] == 0 ? "inf" : Globals["Settings"]["rbxfpsunlocker"]["FPS"]))
            RunFPSUnlocker(Globals["Settings"]["rbxfpsunlocker"]["FPS"])
        } Else {
            RestoreFPSUnlocker()
        }
        FPSEdit.Enabled := Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"]
        RunrbxfpsunlockerCheckBox.Enabled := True
    }
    
    Else If (ThisControl.Hwnd == FPSEdit.Hwnd) {
        If (FPSEdit.Value == "" && !SubmitButton)
            Return
        Globals["Settings"]["rbxfpsunlocker"]["FPS"] := (FPSEdit.Value ? FPSEdit.Value : 0)
        IniWrite(Globals["Settings"]["rbxfpsunlocker"]["FPS"], Globals["Constants"]["ini FilePaths"]["Settings"], "rbxfpsunlocker", "FPS")
        SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] == 0 ? "inf" : Globals["Settings"]["rbxfpsunlocker"]["FPS"]))
        FPSEdit.Value := FPSEdit.Text := ""
        RunFPSUnlocker(Globals["Settings"]["rbxfpsunlocker"]["FPS"])
    }
    
    Global AutoEquipList
    Else If (ThisControl.Hwnd == AutoEquipList.Hwnd) {
        Globals["Settings"]["Collect/Kill"]["AutoEquip"] := AutoEquipList.Text
        IniWrite(Globals["Settings"]["Collect/Kill"]["AutoEquip"], Globals["Constants"]["ini FilePaths"]["Settings"], "Collect/Kill", "AutoEquip")
    }
    
    Global HasGiftedViciousCheckBox
    Else If (ThisControl.Hwnd == HasGiftedViciousCheckBox.Hwnd) {
        Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"] := HasGiftedViciousCheckBox.Value
        IniWrite(Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"], Globals["Constants"]["ini FilePaths"]["Settings"], "Collect/Kill", "HasGiftedVicious")
    }
    
    Global HasRedCannonCheckBox
    Else If (ThisControl.Hwnd == HasRedCannonCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasRedCannon"] := HasRedCannonCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasRedCannon"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasRedCannon")
    }
    
    Global HasParachuteCheckBox
    Global HasGliderCheckBox
    Else If (ThisControl.Hwnd == HasParachuteCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasParachute"] := HasParachuteCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasParachute"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasParachute")
        
        If (Globals["Settings"]["Unlocks"]["HasParachute"]) {
            MoveMethodList.Delete()
            MoveMethodList.Add(["Default", "Walk", "Glider", "Cannon"])
            MoveMethodList.Choose(Globals["Settings"]["Basic Settings"]["MoveMethod"])
            Globals["Settings"]["Basic Settings"]["MoveMethod"] := MoveMethodList.Text
            IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
            HasGliderCheckBox.Enabled := True
            For Field in Globals["Field Settings"] {
                If (!Globals["Field Settings"][Field]["SettingsModified"]) {
                    Globals["Field Settings"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Settings"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"])
                    IniWrite(Globals["Field Settings"][Field]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Field Settings"], Field, "MoveMethod")
                }
            }
        } Else {
            MoveMethodList.Delete()
            MoveMethodList.Add(["Walk"])
            MoveMethodList.Choose("Walk")
            Globals["Settings"]["Basic Settings"]["MoveMethod"] := MoveMethodList.Text
            IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
            HasGliderCheckBox.Enabled := False
            HasGliderCheckBox.Value := False
            Globals["Settings"]["Unlocks"]["HasGlider"] := HasGliderCheckBox.Value
            IniWrite(Globals["Settings"]["Unlocks"]["HasGlider"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGlider")
            For Field in Globals["Field Settings"] {
                Globals["Field Settings"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Settings"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"])
                IniWrite(Globals["Field Settings"][Field]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Field Settings"], Field, "MoveMethod")
            }
        }
    }
    
    Else If (ThisControl.Hwnd == HasGliderCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasGlider"] := HasGliderCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasGlider"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGlider")
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
    
    Global AlwaysOnTopCheckBox
    Else If (ThisControl.Hwnd == AlwaysOnTopCheckBox.Hwnd) {
        Globals["GUI"]["Settings"]["AlwaysOnTop"] := AlwaysOnTopCheckBox.Value
        IniWrite(Globals["GUI"]["Settings"]["AlwaysOnTop"], Globals["Constants"]["ini FilePaths"]["GUI"], "Settings", "AlwaysOnTop")
        IvyshineGui.Opt((Globals["GUI"]["Settings"]["AlwaysOnTop"] ? "+" : "-") "AlwaysOnTop")
    }
    
    Global MoveSpeedCorrectionCheckBox
    Else If (ThisControl.Hwnd == MoveSpeedCorrectionCheckBox.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"] := MoveSpeedCorrectionCheckBox.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "MoveSpeedCorrection")
    }
    
    Global ShiftlockMovingCheckBox
    Else If (ThisControl.Hwnd == ShiftlockMovingCheckBox.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"] := ShiftlockMovingCheckBox.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ShiftlockMoving")
    }
    
    Global TransparencyList
    Else If (ThisControl.Hwnd == TransparencyList.Hwnd) {
        Globals["GUI"]["Settings"]["Transparency"] := TransparencyList.Text
        IniWrite(Globals["GUI"]["Settings"]["Transparency"], Globals["Constants"]["ini FilePaths"]["GUI"], "Settings", "Transparency")
        IvyshineGui.Opt("+LastFound")
        WinSetTransparent(255 - Floor(Globals["GUI"]["Settings"]["Transparency"] * 2.55))
    }
    
    Global BalloonConvertSettingList, BalloonConvertIntervalEdit, BalloonConvertIntervalText
    Else If (ThisControl.Hwnd == BalloonConvertSettingList.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"] := BalloonConvertSettingList.Text
        IniWrite(Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "BalloonConvertSetting")
        BalloonConvertIntervalEdit.Visible := (Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"] == "Every")
        BalloonConvertIntervalText.Visible := (Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"] == "Every")
    }
    
    Else If (ThisControl.Hwnd == BalloonConvertIntervalEdit.Hwnd) {
        If (BalloonConvertIntervalEdit.Value == "" && !SubmitButton)
            Return
        If ((BalloonConvertIntervalEdit.Value == "" && SubmitButton) || BalloonConvertIntervalEdit.Value == 0) {
            Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"] := "Never"
            BalloonConvertSettingList.Choose(Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"])
            IniWrite(Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "BalloonConvertSetting")
            BalloonConvertIntervalEdit.Visible := (Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"] == "Every")
            BalloonConvertIntervalText.Visible := (Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"] == "Every")
        } Else {
            Globals["Settings"]["Miscellaneous"]["BalloonConvertInterval"] := Integer(BalloonConvertIntervalEdit.Value)
            IniWrite(Globals["Settings"]["Miscellaneous"]["BalloonConvertInterval"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "BalloonConvertInterval")
        }
        BalloonConvertIntervalEdit.Value := BalloonConvertIntervalEdit.Text := ""
        SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["BalloonConvertInterval"])
    }
    
    Global ResetMultiplierList
    Else If (ThisControl.Hwnd == ResetMultiplierList.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["ResetMultiplier"] := ResetMultiplierList.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["ResetMultiplier"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ResetMultiplier")
    }
    
    Global ReconnectIntervalEdit
    Global ReconnectStartHourEdit
    Global ReconnectStartMinuteEdit
    
    Global RunAntiAFKCheckBox, AntiAFKIntervalEdit, AntiAFKIntervalText, AntiAFKProgress
    Else If (ThisControl.Hwnd == RunAntiAFKCheckBox.Hwnd) {
        Globals["Settings"]["AntiAFK"]["RunAntiAFK"] := RunAntiAFKCheckBox.Value
        IniWrite(Globals["Settings"]["AntiAFK"]["RunAntiAFK"], Globals["Constants"]["ini FilePaths"]["Settings"], "AntiAFK", "RunAntiAFK")
        If (Globals["Settings"]["AntiAFK"]["RunAntiAFK"]) {
            AntiAFKIntervalEdit.Enabled := True
            AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
            SetCueBanner(AntiAFKIntervalEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKInterval"])
            AntiAFKIntervalText.Text := (Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] == 1 ? " minute." : " minutes.")
            Globals["Settings"]["AntiAFK"]["LastRun"] := A_NowUTC
            SetTimer(AntiAFK, 500, -1)
            AntiAFKProgress.Value := 0
        } Else {
            AntiAFKIntervalEdit.Enabled := False
            SetTimer(AntiAFK, 0)
            AntiAFKProgress.Value := 0
            AntiAFKIntervalText.Text := " minutes."
        }
    }
    
    Else If (ThisControl.Hwnd == AntiAFKIntervalEdit.Hwnd) {
        If (IsNumber(AntiAFKIntervalEdit.Value) && AntiAFKIntervalEdit.Value > 0 && AntiAFKIntervalEdit.Value <= 20) {
            Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] := Round(Number(AntiAFKIntervalEdit.Value))
            IniWrite(Globals["Settings"]["AntiAFK"]["AntiAFKInterval"], Globals["Constants"]["ini FilePaths"]["Settings"], "AntiAFK", "AntiAFKInterval")
            SetCueBanner(AntiAFKIntervalEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKInterval"])
            AntiAFKIntervalText.Text := (Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] == 1 ? " minute." : " minutes.")
            AntiAFKProgress.Opt("Range0-" (Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] * 60))
        }
        AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
    }
    
    Global ForwardKeyEdit
    Else If (ThisControl.Hwnd == ForwardKeyEdit.Hwnd) {
        If (ForwardKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["ForwardKey"] := ForwardKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["ForwardKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "ForwardKey")
        SetCueBanner(ForwardKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ForwardKey"])
        ForwardKeyEdit.Value := ForwardKeyEdit.Text := ""
    }
    
    Global LeftKeyEdit
    Else If (ThisControl.Hwnd == LeftKeyEdit.Hwnd) {
        If (LeftKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["LeftKey"] := LeftKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["LeftKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "LeftKey")
        SetCueBanner(LeftKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["LeftKey"])
        LeftKeyEdit.Value := LeftKeyEdit.Text := ""
    }
    
    Global BackwardKeyEdit
    Else If (ThisControl.Hwnd == BackwardKeyEdit.Hwnd) {
        If (BackwardKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["BackwardKey"] := BackwardKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["BackwardKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "BackwardKey")
        SetCueBanner(BackwardKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["BackwardKey"])
        BackwardKeyEdit.Value := BackwardKeyEdit.Text := ""
    }
    
    Global RightKeyEdit
    Else If (ThisControl.Hwnd == RightKeyEdit.Hwnd) {
        If (RightKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["RightKey"] := RightKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["RightKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "RightKey")
        SetCueBanner(RightKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["RightKey"])
        RightKeyEdit.Value := RightKeyEdit.Text := ""
    }
    
    Global CameraRightKeyEdit
    Else If (ThisControl.Hwnd == CameraRightKeyEdit.Hwnd) {
        If (CameraRightKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["CameraRightKey"] := CameraRightKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["CameraRightKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "CameraRightKey")
        SetCueBanner(CameraRightKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraRightKey"])
        CameraRightKeyEdit.Value := CameraRightKeyEdit.Text := ""
    }
    
    Global CameraLeftKeyEdit
    Else If (ThisControl.Hwnd == CameraLeftKeyEdit.Hwnd) {
        If (CameraLeftKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["CameraLeftKey"] := CameraLeftKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["CameraLeftKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "CameraLeftKey")
        SetCueBanner(CameraLeftKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraLeftKey"])
        CameraLeftKeyEdit.Value := CameraLeftKeyEdit.Text := ""
    }
    
    Global CameraInKeyEdit
    Else If (ThisControl.Hwnd == CameraInKeyEdit.Hwnd) {
        If (CameraInKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["CameraInKey"] := CameraInKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["CameraInKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "CameraInKey")
        SetCueBanner(CameraInKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraInKey"])
        CameraInKeyEdit.Value := CameraInKeyEdit.Text := ""
    }
    
    Global CameraOutKeyEdit
    Else If (ThisControl.Hwnd == CameraOutKeyEdit.Hwnd) {
        If (CameraOutKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["CameraOutKey"] := CameraOutKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["CameraOutKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "CameraOutKey")
        SetCueBanner(CameraOutKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraOutKey"])
        CameraOutKeyEdit.Value := CameraOutKeyEdit.Text := ""
    }
    
    Global ResetKeyEdit
    Else If (ThisControl.Hwnd == ResetKeyEdit.Hwnd) {
        If (ResetKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["ResetKey"] := ResetKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["ResetKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "ResetKey")
        SetCueBanner(ResetKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ResetKey"])
        ResetKeyEdit.Value := ResetKeyEdit.Text := ""
    }
    
    Global ChatKeyEdit
    Else If (ThisControl.Hwnd == ChatKeyEdit.Hwnd) {
        If (ChatKeyEdit.Value == "")
            Return
        Globals["Settings"]["Keybinds"]["ChatKey"] := ChatKeyEdit.Value
        IniWrite(Globals["Settings"]["Keybinds"]["ChatKey"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "ChatKey")
        SetCueBanner(ChatKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ChatKey"])
        ChatKeyEdit.Value := ChatKeyEdit.Text := ""
    }
    
    Global AdditionalKeyDelayEdit
    Else If (ThisControl.Hwnd == AdditionalKeyDelayEdit.Hwnd) {
        If (AdditionalKeyDelayEdit.Value == "" && !SubmitButton)
            Return
        Globals["Settings"]["Keybinds"]["AdditionalKeyDelay"] := Round(Number((AdditionalKeyDelayEdit.Value ? AdditionalKeyDelayEdit.Value : 0)))
        IniWrite(Globals["Settings"]["Keybinds"]["AdditionalKeyDelay"], Globals["Constants"]["ini FilePaths"]["Settings"], "Keybinds", "AdditionalKeyDelay")
        SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Keybinds"]["AdditionalKeyDelay"])
        AdditionalKeyDelayEdit.Value := AdditionalKeyDelayEdit.Text := ""
    }
    
    Global ClickIntervalEdit
    Else If (ThisControl.Hwnd == ClickIntervalEdit.Hwnd) {
        If (IsNumber(ClickIntervalEdit.Value) && ClickIntervalEdit.Value > 0) {
            Globals["Settings"]["Autoclicker"]["ClickInterval"] := ClickIntervalEdit.Value
            IniWrite(Globals["Settings"]["Autoclicker"]["ClickInterval"], Globals["Constants"]["ini FilePaths"]["Settings"], "Autoclicker", "ClickInterval")
            SetCueBanner(ClickIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])
        }
        ClickIntervalEdit.Value := ClickIntervalEdit.Text := ""
    }
    
    Global ClickAmountEdit
    Else If (ThisControl.Hwnd == ClickAmountEdit.Hwnd) {
        If (ClickAmountEdit.Value == "" && !SubmitButton)
            Return
        Globals["Settings"]["Autoclicker"]["ClickAmount"] := (ClickAmountEdit.Value ? ClickAmountEdit.Value : "0")
        IniWrite(Globals["Settings"]["Autoclicker"]["ClickAmount"], Globals["Constants"]["ini FilePaths"]["Settings"], "Autoclicker", "ClickAmount")
        SetCueBanner(ClickAmountEdit.Hwnd, (Globals["Settings"]["Autoclicker"]["ClickAmount"] ? Globals["Settings"]["Autoclicker"]["ClickAmount"] : "infinite"))
        ClickAmountEdit.Value := ClickAmountEdit.Text := ""
        Globals["Settings"]["Autoclicker"]["ClickCounter"] := 0
    }
}

SetSettingsTabValues(*) {
    Global Globals
    Global IvyshineGui
    
    Global MoveSpeedEdit
    MoveSpeedEdit.Value := MoveSpeedEdit.Text := ""
    SetCueBanner(MoveSpeedEdit.Hwnd, Round(Number(Globals["Settings"]["Basic Settings"]["MoveSpeed"]), 2))
    
    Global MoveMethodList
    MoveMethodList.Choose(Globals["Settings"]["Basic Settings"]["MoveMethod"])
    
    Global NumberOfSprinklersList
    NumberOfSprinklersList.Choose(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"])
    
    Global HiveSlotNumberList
    HiveSlotNumberList.Choose(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"])
    
    Global PrivateServerLinkEdit
    PrivateServerLinkEdit.Value := PrivateServerLinkEdit.Text := ""
    SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
    
    Global RunrbxfpsunlockerCheckBox
    RunrbxfpsunlockerCheckBox.Value := Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"]
    
    Global FPSEdit
    FPSEdit.Value := FPSEdit.Text := ""
    SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] ? Globals["Settings"]["rbxfpsunlocker"]["FPS"] : "inf"))
    
    Global AutoEquipList
    AutoEquipList.Choose(Globals["Settings"]["Collect/Kill"]["AutoEquip"])
    
    Global HasGiftedViciousCheckBox
    HasGiftedViciousCheckBox.Value := Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"]
    
    Global HasRedCannonCheckBox
    HasRedCannonCheckBox.Value := Globals["Settings"]["Unlocks"]["HasRedCannon"]
    
    Global HasParachuteCheckBox
    HasParachuteCheckBox.Value := Globals["Settings"]["Unlocks"]["HasParachute"]
    
    Global HasGliderCheckBox
    HasGliderCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGlider"]
    
    Global HasGummyMaskCheckBox
    HasGummyMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGummyMask"]
    
    Global HasDiamondMaskCheckBox
    HasDiamondMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDiamondMask"]
    
    Global HasDemonMaskCheckBox
    HasDemonMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDemonMask"]
    
    Global HasPetalWandCheckBox
    HasPetalWandCheckBox.Value := Globals["Settings"]["Unlocks"]["HasPetalWand"]
    
    Global HasTidePopperCheckBox
    HasTidePopperCheckBox.Value := Globals["Settings"]["Unlocks"]["HasTidePopper"]
    
    Global HasDarkScytheCheckBox
    HasDarkScytheCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDarkScythe"]
    
    Global NumberOfBeesEdit
    NumberOfBeesEdit.Value := NumberOfBeesEdit.Text := ""
    SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
    
    Global StartHotkeyButton
    StartHotkeyButton.Text := "Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")"
    
    Global PauseHotkeyButton
    PauseHotkeyButton.Text := "Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")"
    
    Global StopHotkeyButton
    StopHotkeyButton.Text := "Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")"
    
    Global AlwaysOnTopCheckBox
    AlwaysOnTopCheckBox.Value := Globals["GUI"]["Settings"]["AlwaysOnTop"]
    
    Global MoveSpeedCorrectionCheckBox
    MoveSpeedCorrectionCheckBox.Value := Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"]
    
    Global ShiftlockMovingCheckBox
    ShiftlockMovingCheckBox.Value := Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"]
    
    Global TransparencyList
    TransparencyList.Choose(Globals["GUI"]["Settings"]["Transparency"])
    
    Global BalloonConvertSettingList
    BalloonConvertSettingList.Choose(Globals["Settings"]["Miscellaneous"]["BalloonConvertSetting"])
    
    Global BalloonConvertIntervalEdit
    BalloonConvertIntervalEdit.Value := BalloonConvertIntervalEdit.Text := ""
    SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["BalloonConvertInterval"])
    
    Global ResetMultiplierList
    ResetMultiplierList.Choose(Globals["Settings"]["Miscellaneous"]["ResetMultiplier"])
    
    Global ReconnectIntervalEdit
    Global ReconnectStartHourEdit
    Global ReconnectStartMinuteEdit
    
    Global RunAntiAFKCheckBox
    RunAntiAFKCheckBox.Value := Globals["Settings"]["AntiAFK"]["RunAntiAFK"]
    
    Global AntiAFKIntervalEdit
    AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
    SetCueBanner(AntiAFKIntervalEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKInterval"])
    
    Global ForwardKeyEdit
    ForwardKeyEdit.Value := ForwardKeyEdit.Text := ""
    SetCueBanner(ForwardKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ForwardKey"])
    
    Global LeftKeyEdit
    LeftKeyEdit.Value := LeftKeyEdit.Text := ""
    SetCueBanner(LeftKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["LeftKey"])
    
    Global BackwardKeyEdit
    BackwardKeyEdit.Value := BackwardKeyEdit.Text := ""
    SetCueBanner(BackwardKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["BackwardKey"])
    
    Global RightKeyEdit
    RightKeyEdit.Value := RightKeyEdit.Text := ""
    SetCueBanner(RightKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["RightKey"])
    
    Global CameraRightKeyEdit
    CameraRightKeyEdit.Value := CameraRightKeyEdit.Text := ""
    SetCueBanner(CameraRightKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraRightKey"])
    
    Global CameraLeftKeyEdit
    CameraLeftKeyEdit.Value := CameraLeftKeyEdit.Text := ""
    SetCueBanner(CameraLeftKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraLeftKey"])
    
    Global CameraInKeyEdit
    CameraInKeyEdit.Value := CameraInKeyEdit.Text := ""
    SetCueBanner(CameraInKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraInKey"])
    
    Global CameraOutKeyEdit
    CameraOutKeyEdit.Value := CameraOutKeyEdit.Text := ""
    SetCueBanner(CameraOutKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["CameraOutKey"])
    
    Global ResetKeyEdit
    ResetKeyEdit.Value := ResetKeyEdit.Text := ""
    SetCueBanner(ResetKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ResetKey"])
    
    Global ChatKeyEdit
    ChatKeyEdit.Value := ChatKeyEdit.Text := ""
    SetCueBanner(ChatKeyEdit.Hwnd, Globals["Settings"]["Keybinds"]["ChatKey"])
    
    Global AdditionalKeyDelayEdit
    AdditionalKeyDelayEdit.Value := AdditionalKeyDelayEdit.Text := ""
    SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Keybinds"]["AdditionalKeyDelay"])
    
    Global ClickIntervalEdit
    ClickIntervalEdit.Value := ClickIntervalEdit.Text := ""
    SetCueBanner(ClickIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])
    
    Global ClickAmountEdit
    ClickAmountEdit.Value := ClickAmountEdit.Text := ""
    SetCueBanner(ClickAmountEdit.Hwnd, (Globals["Settings"]["Autoclicker"]["ClickAmount"] ? Globals["Settings"]["Autoclicker"]["ClickAmount"] : "infinite"))
    
    Global AutoclickerHotkeyButton
    AutoclickerHotkeyButton.Text := "Hotkey: " Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"]
}

SettingsTabOn := True

SettingsTabSwitch(*) {
    
    SetSettingsTabValues()
    
    Global Globals
    Global IvyshineGui
    Global SettingsTabOn
    
    SettingsTabOn := !SettingsTabOn
    
    Global SubmitSettingsButton
    SubmitSettingsButton.Enabled := SettingsTabOn
    
    Global MoveSpeedEdit
    MoveSpeedEdit.Enabled := SettingsTabOn
    
    Global MoveMethodList
    MoveMethodList.Enabled := SettingsTabOn
    
    Global NumberOfSprinklersList
    NumberOfSprinklersList.Enabled := SettingsTabOn
    
    Global HiveSlotNumberList
    HiveSlotNumberList.Enabled := SettingsTabOn
    
    Global PrivateServerLinkEdit
    PrivateServerLinkEdit.Enabled := SettingsTabOn
    
    Global RunrbxfpsunlockerCheckBox
    RunrbxfpsunlockerCheckBox.Enabled := SettingsTabOn
    
    Global FPSEdit
    FPSEdit.Enabled := (SettingsTabOn ? Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"] : False)
    
    Global AutoEquipList
    AutoEquipList.Enabled := SettingsTabOn
    
    Global HasGiftedViciousCheckBox
    HasGiftedViciousCheckBox.Enabled := SettingsTabOn
    
    Global ResetButton
    ResetButton.Enabled := SettingsTabOn
    
    Global HasRedCannonCheckBox
    HasRedCannonCheckBox.Enabled := SettingsTabOn
    
    Global HasParachuteCheckBox
    HasParachuteCheckBox.Enabled := SettingsTabOn
    
    Global HasGliderCheckBox
    HasGliderCheckBox.Enabled := (SettingsTabOn ? Globals["Settings"]["Unlocks"]["HasParachute"] : False)
    
    Global HasGummyMaskCheckBox
    HasGummyMaskCheckBox.Enabled := SettingsTabOn
    
    Global HasDiamondMaskCheckBox
    HasDiamondMaskCheckBox.Enabled := SettingsTabOn
    
    Global HasDemonMaskCheckBox
    HasDemonMaskCheckBox.Enabled := SettingsTabOn
    
    Global HasPetalWandCheckBox
    HasPetalWandCheckBox.Enabled := SettingsTabOn
    
    Global HasTidePopperCheckBox
    HasTidePopperCheckBox.Enabled := SettingsTabOn
    
    Global HasDarkScytheCheckBox
    HasDarkScytheCheckBox.Enabled := SettingsTabOn
    
    Global NumberOfBeesEdit
    NumberOfBeesEdit.Enabled := SettingsTabOn
    
    Global HotkeysInfoButton
    HotkeysInfoButton.Enabled := SettingsTabOn
    
    Global StartHotkeyButton
    StartHotkeyButton.Enabled := SettingsTabOn
    
    Global PauseHotkeyButton
    PauseHotkeyButton.Enabled := SettingsTabOn
    
    Global StopHotkeyButton
    StopHotkeyButton.Enabled := SettingsTabOn
    
    Global AlwaysOnTopCheckBox
    AlwaysOnTopCheckBox.Enabled := SettingsTabOn
    
    Global MoveSpeedCorrectionCheckBox
    MoveSpeedCorrectionCheckBox.Enabled := SettingsTabOn
    
    Global ShiftlockMovingCheckBox
    ShiftlockMovingCheckBox.Enabled := SettingsTabOn
    
    Global TransparencyList
    TransparencyList.Enabled := SettingsTabOn
    
    Global BalloonConvertSettingList
    BalloonConvertSettingList.Enabled := SettingsTabOn
    
    Global BalloonConvertIntervalEdit
    BalloonConvertIntervalEdit.Enabled := SettingsTabOn
    
    Global ResetMultiplierList
    ResetMultiplierList.Enabled := SettingsTabOn
    
    Global ReconnectIntervalEdit
    Global ReconnectStartHourEdit
    Global ReconnectStartMinuteEdit
    
    Global AntiAFKInfoButton
    AntiAFKInfoButton.Enabled := SettingsTabOn
    
    Global RunAntiAFKCheckBox
    RunAntiAFKCheckBox.Enabled := SettingsTabOn
    
    Global AntiAFKIntervalEdit
    AntiAFKIntervalEdit.Enabled := (SettingsTabOn ? Globals["Settings"]["AntiAFK"]["RunAntiAFK"] : False)
    
    Global ForwardKeyEdit
    ForwardKeyEdit.Enabled := SettingsTabOn
    
    Global LeftKeyEdit
    LeftKeyEdit.Enabled := SettingsTabOn
    
    Global BackwardKeyEdit
    BackwardKeyEdit.Enabled := SettingsTabOn
    
    Global RightKeyEdit
    RightKeyEdit.Enabled := SettingsTabOn
    
    Global CameraRightKeyEdit
    CameraRightKeyEdit.Enabled := SettingsTabOn
    
    Global CameraLeftKeyEdit
    CameraLeftKeyEdit.Enabled := SettingsTabOn
    
    Global CameraInKeyEdit
    CameraInKeyEdit.Enabled := SettingsTabOn
    
    Global CameraOutKeyEdit
    CameraOutKeyEdit.Enabled := SettingsTabOn
    
    Global ResetKeyEdit
    ResetKeyEdit.Enabled := SettingsTabOn
    
    Global ChatKeyEdit
    ChatKeyEdit.Enabled := SettingsTabOn
    
    Global AdditionalKeyDelayEdit
    AdditionalKeyDelayEdit.Enabled := SettingsTabOn
    
    Global ClickIntervalEdit
    ClickIntervalEdit.Enabled := SettingsTabOn
    
    Global ClickAmountEdit
    ClickAmountEdit.Enabled := SettingsTabOn
    
    Global AutoclickerHotkeyButton
    AutoclickerHotkeyButton.Enabled := SettingsTabOn
}