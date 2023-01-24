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
#Include *i Settings\GUI.ahk
#Include *i Settings\Convert Settings.ahk
#Include *i Settings\Reconnect.ahk
#Include *i Settings\AntiAFK.ahk
#Include *i Settings\Miscellaneous.ahk
#Include *i Settings\Autoclicker.ahk

#Include *i Settings\EditHotkeysGui\Edit Hotkeys.ahk
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
        } Else If (IsNumber(NewMoveSpeed) && (NewMoveSpeed > 50 || NewMoveSpeed <= 0))
            DefaultErrorBalloonTip("Accepted: positive numbers <= 50`r`nMake sure you have no haste.", "Out of range!", MoveSpeedEdit.Hwnd)
        Else If (!IsNumber(NewMoveSpeed) && NewMoveSpeed != "")
            DefaultErrorBalloonTip("Accepted: positive numbers <= 50", "Not a number!", MoveSpeedEdit.Hwnd)
        MoveSpeedEdit.Text := MoveSpeedEdit.Value := ""
    }
    
    Global MoveMethodList
    Else If (ThisControl.Hwnd == MoveMethodList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["MoveMethod"] := MoveMethodList.Text
        IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
        
        For Field in Globals["Field Settings"] {
            If (!InStr(Globals["Field Settings"][Field]["SettingsModified"], "MoveMethod")) {
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
        } Else
            DefaultErrorBalloonTip("Please copy the private server link directly from the configuration page.", "Invalid Link!", PrivateServerLinkEdit.Hwnd)
        SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
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
        } Else
            CloseFPSUnlocker()
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
    
    Global HasGummyballerCheckBox
    Else If (ThisControl.Hwnd == HasGummyballerCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasGummyballer"] := HasGummyballerCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasGummyballer"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGummyballer")
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
            Globals["Settings"]["Unlocks"]["NumberOfBees"] := NewNumberOfBees
            IniWrite(Globals["Settings"]["Unlocks"]["NumberOfBees"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "NumberOfBees")
            SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
        } Else If (IsInteger(NewNumberOfBees) && (NewNumberOfBees > 50 || NewNumberOfBees == 0))
            DefaultErrorBalloonTip("Accepted: positive integers <= 50", "Out of range!", NumberOfBeesEdit.Hwnd)
        NumberOfBeesEdit.Text := NumberOfBeesEdit.Value := ""
    }
    
    Global AlwaysOnTopCheckBox
    Else If (ThisControl.Hwnd == AlwaysOnTopCheckBox.Hwnd) {
        Globals["Settings"]["GUI"]["AlwaysOnTop"] := AlwaysOnTopCheckBox.Value
        IniWrite(Globals["Settings"]["GUI"]["AlwaysOnTop"], Globals["Constants"]["ini FilePaths"]["Settings"], "GUI", "AlwaysOnTop")
        IvyshineGui.Opt((Globals["Settings"]["GUI"]["AlwaysOnTop"] ? "+" : "-") "AlwaysOnTop")
    }
    
    Global TransparencyList
    Else If (ThisControl.Hwnd == TransparencyList.Hwnd) {
        Globals["Settings"]["GUI"]["Transparency"] := TransparencyList.Text
        IniWrite(Globals["Settings"]["GUI"]["Transparency"], Globals["Constants"]["ini FilePaths"]["Settings"], "GUI", "Transparency")
        IvyshineGui.Opt("+LastFound")
        WinSetTransparent(255 - Floor(Globals["Settings"]["GUI"]["Transparency"] * 2.55))
    }
    
    Global ConvertDelayEdit
    Else If (ThisControl.Hwnd == ConvertDelayEdit.Hwnd) {
        NewConvertDelay := Trim(ConvertDelayEdit.Value)
        If (IsInteger(NewConvertDelay) && NewConvertDelay <= 20 && NewConvertDelay >= 0) {
            NewConvertDelay := Round(Integer(NewConvertDelay))
            Globals["Settings"]["Convert Settings"]["ConvertDelay"] := NewConvertDelay
            IniWrite(Globals["Settings"]["Convert Settings"]["ConvertDelay"], Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "ConvertDelay")
            SetCueBanner(ConvertDelayEdit.Hwnd, Globals["Settings"]["Convert Settings"]["ConvertDelay"])
        } Else If (IsInteger(NewConvertDelay) && NewConvertDelay > 20)
            DefaultErrorBalloonTip("Accepted: non-negative integers <= 20", "Out of range!", ConvertDelayEdit.Hwnd)
        ConvertDelayEdit.Text := ConvertDelayEdit.Value := ""
    }
    
    Global BalloonConvertSettingList, BalloonConvertIntervalEdit, BalloonConvertIntervalText
    Else If (ThisControl.Hwnd == BalloonConvertSettingList.Hwnd) {
        Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] := BalloonConvertSettingList.Text
        IniWrite(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"], Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "BalloonConvertSetting")
        BalloonConvertIntervalEdit.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
        BalloonConvertIntervalText.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
    }
    
    Else If (ThisControl.Hwnd == BalloonConvertIntervalEdit.Hwnd) {
        If (BalloonConvertIntervalEdit.Value == "" && !SubmitButton)
            Return
        If ((BalloonConvertIntervalEdit.Value == "" && SubmitButton) || BalloonConvertIntervalEdit.Value == 0) {
            Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] := "Never"
            BalloonConvertSettingList.Choose(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"])
            IniWrite(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"], Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "BalloonConvertSetting")
            BalloonConvertIntervalEdit.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
            BalloonConvertIntervalText.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
        } Else {
            Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"] := Integer(BalloonConvertIntervalEdit.Value)
            IniWrite(Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"], Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "BalloonConvertInterval")
        }
        BalloonConvertIntervalEdit.Value := BalloonConvertIntervalEdit.Text := ""
        SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"])
    }
    
    Global ReconnectIntervalEdit
    Else If (ThisControl.Hwnd == ReconnectIntervalEdit.Hwnd) {
        If (ReconnectIntervalEdit.Value == "" && !SubmitButton)
            Return
        If (!ReconnectIntervalEdit.Value || Mod(24, ReconnectIntervalEdit.Value) == 0) {
            Globals["Settings"]["Reconnect"]["ReconnectInterval"] := (ReconnectIntervalEdit.Value ? ReconnectIntervalEdit.Value : "")
            IniWrite(Globals["Settings"]["Reconnect"]["ReconnectInterval"], Globals["Constants"]["ini FilePaths"]["Settings"], "Reconnect", "ReconnectInterval")
        } Else
            DefaultErrorBalloonTip("Accepted: factors of 24`r`n1, 2, 3, 4, 6, 8, 12, 24", "Value not accepted!", ReconnectIntervalEdit.Hwnd)
        ReconnectIntervalEdit.Value := ReconnectIntervalEdit.Text := ""
        SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectInterval"])
        Global ReconnectIntervalText
        ReconnectIntervalText.Text := (Globals["Settings"]["Reconnect"]["ReconnectInterval"] == 1 ? " hour," : " hours,")
    }
    
    Global ReconnectStartHourEdit
    Else If (ThisControl.Hwnd == ReconnectStartHourEdit.Hwnd) {
        If (ReconnectStartHourEdit.Value == "" && !SubmitButton)
            Return
        ReconnectStartHourEdit.Value := Format("{:02}", Number((ReconnectStartHourEdit.Value ? ReconnectStartHourEdit.Value : 0)))
        If (ReconnectStartHourEdit.Value >= 0 && ReconnectStartHourEdit.Value <= 23) {
            Globals["Settings"]["Reconnect"]["ReconnectStartHour"] := ReconnectStartHourEdit.Value
            IniWrite(Globals["Settings"]["Reconnect"]["ReconnectStartHour"], Globals["Constants"]["ini FilePaths"]["Settings"], "Reconnect", "ReconnectStartHour")
        } Else
            DefaultErrorBalloonTip("Accepted: 0 <= n <= 23", "Out of range!", ReconnectStartHourEdit.Hwnd)
        ReconnectStartHourEdit.Value := ReconnectStartHourEdit.Text := ""
        SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartHour"])
    }
    
    Global ReconnectStartMinuteEdit
    Else If (ThisControl.Hwnd == ReconnectStartMinuteEdit.Hwnd) {
        If (ReconnectStartMinuteEdit.Value == "" && !SubmitButton)
            Return
        ReconnectStartMinuteEdit.Value := Format("{:02}", Number((ReconnectStartMinuteEdit.Value ? ReconnectStartMinuteEdit.Value : 0)))
        If (ReconnectStartMinuteEdit.Value >= 0 && ReconnectStartMinuteEdit.Value <= 59) {
            Globals["Settings"]["Reconnect"]["ReconnectStartMinute"] := ReconnectStartMinuteEdit.Value
            IniWrite(Globals["Settings"]["Reconnect"]["ReconnectStartMinute"], Globals["Constants"]["ini FilePaths"]["Settings"], "Reconnect", "ReconnectStartMinute")
        } Else
            DefaultErrorBalloonTip("Accepted: 0 <= n <= 59", "Out of range!", ReconnectStartMinuteEdit.Hwnd)
        ReconnectStartMinuteEdit.Value := ReconnectStartMinuteEdit.Text := ""
        SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartMinute"])
    }
    
    Global MoveSpeedCorrectionCheckBox
    Else If (ThisControl.Hwnd == MoveSpeedCorrectionCheckBox.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"] := MoveSpeedCorrectionCheckBox.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "MoveSpeedCorrection")
    }
    
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
        } Else If (IsNumber(AntiAFKIntervalEdit.Value) && (AntiAFKIntervalEdit.Value == 0 || AntiAFKIntervalEdit.Value > 20))
            DefaultErrorBalloonTip("Accepted: positive Integers <= 20", "Out of range!", AntiAFKIntervalEdit.Hwnd)
        AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
    }
    
    Global ShiftlockMovingCheckBox
    Else If (ThisControl.Hwnd == ShiftlockMovingCheckBox.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"] := ShiftlockMovingCheckBox.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ShiftlockMoving")
    }
    
    Global AdditionalKeyDelayEdit
    Else If (ThisControl.Hwnd == AdditionalKeyDelayEdit.Hwnd) {
        If (AdditionalKeyDelayEdit.Value == "" && !SubmitButton)
            Return
        Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"] := Round(Number((AdditionalKeyDelayEdit.Value ? AdditionalKeyDelayEdit.Value : 0)))
        IniWrite(Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "AdditionalKeyDelay")
        SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
        AdditionalKeyDelayEdit.Value := AdditionalKeyDelayEdit.Text := ""
    }
    
    Global ResetMultiplierSlider
    Else If (ThisControl.Hwnd == ResetMultiplierSlider.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["ResetMultiplier"] := ResetMultiplierSlider.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["ResetMultiplier"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ResetMultiplier")
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
    
    Global HasGummyballerCheckBox
    HasGummyballerCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGummyballer"]
    
    Global HasTidePopperCheckBox
    HasTidePopperCheckBox.Value := Globals["Settings"]["Unlocks"]["HasTidePopper"]
    
    Global HasDarkScytheCheckBox
    HasDarkScytheCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDarkScythe"]
    
    Global NumberOfBeesEdit
    NumberOfBeesEdit.Value := NumberOfBeesEdit.Text := ""
    SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
    
    Global StartHotkeyButton
    StartHotkeyButton.Text := " Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")"
    
    Global PauseHotkeyButton
    PauseHotkeyButton.Text := " Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")"
    
    Global StopHotkeyButton
    StopHotkeyButton.Text := " Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")"
    
    Global AlwaysOnTopCheckBox
    AlwaysOnTopCheckBox.Value := Globals["Settings"]["GUI"]["AlwaysOnTop"]
    
    Global TransparencyList
    TransparencyList.Choose(Globals["Settings"]["GUI"]["Transparency"])
    
    Global ConvertDelayEdit
    ConvertDelayEdit.Value := ConvertDelayEdit.Text := ""
    SetCueBanner(ConvertDelayEdit.Hwnd, Globals["Settings"]["Convert Settings"]["ConvertDelay"])
    
    Global BalloonConvertSettingList
    BalloonConvertSettingList.Choose(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"])
    
    Global BalloonConvertIntervalEdit
    BalloonConvertIntervalEdit.Value := BalloonConvertIntervalEdit.Text := ""
    SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"])
    
    Global ReconnectIntervalEdit
    ReconnectIntervalEdit.Value := ReconnectIntervalEdit.Text := ""
    SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectInterval"])
    
    Global ReconnectStartHourEdit
    ReconnectStartHourEdit.Value := ReconnectStartHourEdit.Text := ""
    SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartHour"])
    
    Global ReconnectStartMinuteEdit
    ReconnectStartMinuteEdit.Value := ReconnectStartMinuteEdit.Text := ""
    SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartMinute"])
    Global RunAntiAFKCheckBox
    RunAntiAFKCheckBox.Value := Globals["Settings"]["AntiAFK"]["RunAntiAFK"]
    
    Global AntiAFKIntervalEdit
    AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
    SetCueBanner(AntiAFKIntervalEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKInterval"])
    
    Global MoveSpeedCorrectionCheckBox
    MoveSpeedCorrectionCheckBox.Value := Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"]
    
    Global ShiftlockMovingCheckBox
    ShiftlockMovingCheckBox.Value := Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"]
    
    Global AdditionalKeyDelayEdit
    AdditionalKeyDelayEdit.Value := AdditionalKeyDelayEdit.Text := ""
    SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
    
    Global ResetMultiplierSlider
    ResetMultiplierSlider.Value := Globals["Settings"]["Miscellaneous"]["ResetMultiplier"]
    
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
    
    Global HasGummyballerCheckBox
    HasGummyballerCheckBox.Enabled := SettingsTabOn
    
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
    
    Global TransparencyList
    TransparencyList.Enabled := SettingsTabOn
    
    Global ConvertDelayEdit
    ConvertDelayEdit.Enabled := SettingsTabOn
    
    Global BalloonConvertSettingList
    BalloonConvertSettingList.Enabled := SettingsTabOn
    
    Global BalloonConvertIntervalEdit
    BalloonConvertIntervalEdit.Enabled := SettingsTabOn
    Global ReconnectIntervalEdit
    ReconnectIntervalEdit.Enabled := SettingsTabOn
    
    Global ReconnectStartHourEdit
    ReconnectStartHourEdit.Enabled := SettingsTabOn
    
    Global ReconnectStartMinuteEdit
    ReconnectStartMinuteEdit.Enabled := SettingsTabOn
    
    Global AntiAFKInfoButton
    AntiAFKInfoButton.Enabled := SettingsTabOn
    
    Global RunAntiAFKCheckBox
    RunAntiAFKCheckBox.Enabled := SettingsTabOn
    
    Global AntiAFKIntervalEdit
    AntiAFKIntervalEdit.Enabled := (SettingsTabOn ? Globals["Settings"]["AntiAFK"]["RunAntiAFK"] : False)
    
    Global MoveSpeedCorrectionCheckBox
    MoveSpeedCorrectionCheckBox.Enabled := SettingsTabOn
    
    Global ShiftlockMovingCheckBox
    ShiftlockMovingCheckBox.Enabled := SettingsTabOn
    
    Global AdditionalKeyDelayEdit
    AdditionalKeyDelayEdit.Enabled := SettingsTabOn
    
    Global ResetMultiplierSlider
    ResetMultiplierSlider.Enabled := SettingsTabOn
    
    Globals ImportSettingsButton
    ImportSettingsButton.Enabled := SettingsTabOn
    
    Global ClickIntervalEdit
    ClickIntervalEdit.Enabled := SettingsTabOn
    
    Global ClickAmountEdit
    ClickAmountEdit.Enabled := SettingsTabOn
    
    Global AutoclickerHotkeyButton
    AutoclickerHotkeyButton.Enabled := SettingsTabOn
}