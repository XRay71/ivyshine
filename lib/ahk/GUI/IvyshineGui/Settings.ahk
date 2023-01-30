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
    Reset := MsgBox("This will reset the entire macro to its default settings, excluding stats.", "Warning!", "OKCancel Icon! Default2 Owner" IvyshineGui.Hwnd)
    If (Reset == "OK") {
        #IncludeAgain *i ..\..\init\Globals.ahk
        For ini, Section in Globals
        {
            If (FileExist(Globals["Constants"]["ini FilePaths"][ini]))
                FileDelete(Globals["Constants"]["ini FilePaths"][ini])
            If (ini != "Field Rotation")
                UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
            ReloadMacro()
        }
    }
}

SubmitSettingsButton := IvyshineGui.Add("Button", "x0 y0 w1 h1 Hidden +Default vSubmitSettingsButton")
SubmitSettingsButton.OnEvent("Click", SubmitSettings)

SubmitSettings(ThisControl, *) {
    
    SubmitButton := False
    If (ThisControl.Hwnd == SubmitSettingsButton.Hwnd) {
        ThisControl := IvyshineGui.FocusedCtrl
        SubmitButton := True
    }
    
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
    
    Else If (ThisControl.Hwnd == MoveMethodList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["MoveMethod"] := MoveMethodList.Text
        IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
        
        For Field in Globals["Field Defaults"] {
            Globals["Field Defaults"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Defaults"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"])
            IniWrite(Globals["Field Defaults"][Field]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Field Defaults"], Field, "MoveMethod")
        }
    }
    
    Else If (ThisControl.Hwnd == NumberOfSprinklersList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"] := NumberOfSprinklersList.Value
        IniWrite(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "NumberOfSprinklers")
    }
    
    Else If (ThisControl.Hwnd == HiveSlotNumberList.Hwnd) {
        Globals["Settings"]["Basic Settings"]["HiveSlotNumber"] := HiveSlotNumberList.Value
        IniWrite(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"], Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "HiveSlotNumber")
    }
    
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
    
    Else If (ThisControl.Hwnd == AutoEquipList.Hwnd) {
        Globals["Settings"]["Collect/Kill"]["AutoEquip"] := AutoEquipList.Text
        IniWrite(Globals["Settings"]["Collect/Kill"]["AutoEquip"], Globals["Constants"]["ini FilePaths"]["Settings"], "Collect/Kill", "AutoEquip")
    }
    
    Else If (ThisControl.Hwnd == HasGiftedViciousCheckBox.Hwnd) {
        Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"] := HasGiftedViciousCheckBox.Value
        IniWrite(Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"], Globals["Constants"]["ini FilePaths"]["Settings"], "Collect/Kill", "HasGiftedVicious")
    }
    
    Else If (ThisControl.Hwnd == HasRedCannonCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasRedCannon"] := HasRedCannonCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasRedCannon"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasRedCannon")
    }
    
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
            For Field in Globals["Field Defaults"] {
                Globals["Field Defaults"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Defaults"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"])
                IniWrite(Globals["Field Defaults"][Field]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Field Defaults"], Field, "MoveMethod")
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
            For Field in Globals["Field Defaults"] {
                Globals["Field Defaults"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Defaults"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"])
                IniWrite(Globals["Field Defaults"][Field]["MoveMethod"], Globals["Constants"]["ini FilePaths"]["Field Defaults"], Field, "MoveMethod")
            }
        }
    }
    
    Else If (ThisControl.Hwnd == HasGliderCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasGlider"] := HasGliderCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasGlider"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGlider")
    }
    
    Else If (ThisControl.Hwnd == HasGummyMaskCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasGummyMask"] := HasGummyMaskCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasGummyMask"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGummyMask")
    }
    
    Else If (ThisControl.Hwnd == HasDiamondMaskCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasDiamondMask"] := HasDiamondMaskCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasDiamondMask"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDiamondMask")
    }
    
    Else If (ThisControl.Hwnd == HasDemonMaskCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasDemonMask"] := HasDemonMaskCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasDemonMask"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDemonMask")
    }
    
    Else If (ThisControl.Hwnd == HasPetalWandCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasPetalWand"] := HasPetalWandCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasPetalWand"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasPetalWand")
    }
    
    Else If (ThisControl.Hwnd == HasGummyballerCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasGummyballer"] := HasGummyballerCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasGummyballer"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGummyballer")
    }
    
    Else If (ThisControl.Hwnd == HasTidePopperCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasTidePopper"] := HasTidePopperCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasTidePopper"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasTidePopper")
    }
    
    Else If (ThisControl.Hwnd == HasDarkScytheCheckBox.Hwnd) {
        Globals["Settings"]["Unlocks"]["HasDarkScythe"] := HasDarkScytheCheckBox.Value
        IniWrite(Globals["Settings"]["Unlocks"]["HasDarkScythe"], Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDarkScythe")
    }
    
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
    
    Else If (ThisControl.Hwnd == AlwaysOnTopCheckBox.Hwnd) {
        Globals["Settings"]["GUI"]["AlwaysOnTop"] := AlwaysOnTopCheckBox.Value
        IniWrite(Globals["Settings"]["GUI"]["AlwaysOnTop"], Globals["Constants"]["ini FilePaths"]["Settings"], "GUI", "AlwaysOnTop")
        IvyshineGui.Opt((Globals["Settings"]["GUI"]["AlwaysOnTop"] ? "+" : "-") "AlwaysOnTop")
    }
    
    Else If (ThisControl.Hwnd == TransparencyList.Hwnd) {
        Globals["Settings"]["GUI"]["Transparency"] := TransparencyList.Text
        IniWrite(Globals["Settings"]["GUI"]["Transparency"], Globals["Constants"]["ini FilePaths"]["Settings"], "GUI", "Transparency")
        IvyshineGui.Opt("+LastFound")
        WinSetTransparent(255 - Floor(Globals["Settings"]["GUI"]["Transparency"] * 2.55))
    }
    
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
        ReconnectIntervalText.Text := (Globals["Settings"]["Reconnect"]["ReconnectInterval"] == 1 ? " hour," : " hours,")
    }
    
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
    
    Else If (ThisControl.Hwnd == MoveSpeedCorrectionCheckBox.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"] := MoveSpeedCorrectionCheckBox.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "MoveSpeedCorrection")
    }
    
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
    
    Else If (ThisControl.Hwnd == ShiftlockMovingCheckBox.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"] := ShiftlockMovingCheckBox.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ShiftlockMoving")
    }
    
    Else If (ThisControl.Hwnd == AdditionalKeyDelayEdit.Hwnd) {
        If (AdditionalKeyDelayEdit.Value == "" && !SubmitButton)
            Return
        Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"] := Round(Number((AdditionalKeyDelayEdit.Value ? AdditionalKeyDelayEdit.Value : 0)))
        IniWrite(Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "AdditionalKeyDelay")
        SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
        AdditionalKeyDelayEdit.Value := AdditionalKeyDelayEdit.Text := ""
    }
    
    Else If (ThisControl.Hwnd == ResetMultiplierSlider.Hwnd) {
        Globals["Settings"]["Miscellaneous"]["ResetMultiplier"] := ResetMultiplierSlider.Value
        IniWrite(Globals["Settings"]["Miscellaneous"]["ResetMultiplier"], Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ResetMultiplier")
    }
    
    Else If (ThisControl.Hwnd == ClickIntervalEdit.Hwnd) {
        If (IsNumber(ClickIntervalEdit.Value) && ClickIntervalEdit.Value > 0) {
            Globals["Settings"]["Autoclicker"]["ClickInterval"] := ClickIntervalEdit.Value
            IniWrite(Globals["Settings"]["Autoclicker"]["ClickInterval"], Globals["Constants"]["ini FilePaths"]["Settings"], "Autoclicker", "ClickInterval")
            SetCueBanner(ClickIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])
        }
        ClickIntervalEdit.Value := ClickIntervalEdit.Text := ""
    }
    
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
    MoveSpeedEdit.Value := MoveSpeedEdit.Text := ""
    SetCueBanner(MoveSpeedEdit.Hwnd, Round(Number(Globals["Settings"]["Basic Settings"]["MoveSpeed"]), 2))
    
    MoveMethodList.Choose(Globals["Settings"]["Basic Settings"]["MoveMethod"])
    
    NumberOfSprinklersList.Choose(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"])
    
    HiveSlotNumberList.Choose(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"])
    
    PrivateServerLinkEdit.Value := PrivateServerLinkEdit.Text := ""
    SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
    
    RunrbxfpsunlockerCheckBox.Value := Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"]
    
    FPSEdit.Value := FPSEdit.Text := ""
    SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] ? Globals["Settings"]["rbxfpsunlocker"]["FPS"] : "inf"))
    
    AutoEquipList.Choose(Globals["Settings"]["Collect/Kill"]["AutoEquip"])
    
    HasGiftedViciousCheckBox.Value := Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"]
    
    HasRedCannonCheckBox.Value := Globals["Settings"]["Unlocks"]["HasRedCannon"]
    
    HasParachuteCheckBox.Value := Globals["Settings"]["Unlocks"]["HasParachute"]
    
    HasGliderCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGlider"]
    
    HasGummyMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGummyMask"]
    
    HasDiamondMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDiamondMask"]
    
    HasDemonMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDemonMask"]
    
    HasPetalWandCheckBox.Value := Globals["Settings"]["Unlocks"]["HasPetalWand"]
    
    HasGummyballerCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGummyballer"]
    
    HasTidePopperCheckBox.Value := Globals["Settings"]["Unlocks"]["HasTidePopper"]
    
    HasDarkScytheCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDarkScythe"]
    
    NumberOfBeesEdit.Value := NumberOfBeesEdit.Text := ""
    SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
    
    StartHotkeyButton.Text := " Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")"
    
    PauseHotkeyButton.Text := " Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")"
    
    StopHotkeyButton.Text := " Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")"
    
    AlwaysOnTopCheckBox.Value := Globals["Settings"]["GUI"]["AlwaysOnTop"]
    
    TransparencyList.Choose(Globals["Settings"]["GUI"]["Transparency"])
    
    ConvertDelayEdit.Value := ConvertDelayEdit.Text := ""
    SetCueBanner(ConvertDelayEdit.Hwnd, Globals["Settings"]["Convert Settings"]["ConvertDelay"])
    
    BalloonConvertSettingList.Choose(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"])
    
    BalloonConvertIntervalEdit.Value := BalloonConvertIntervalEdit.Text := ""
    SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"])
    
    ReconnectIntervalEdit.Value := ReconnectIntervalEdit.Text := ""
    SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectInterval"])
    
    ReconnectStartHourEdit.Value := ReconnectStartHourEdit.Text := ""
    SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartHour"])
    
    ReconnectStartMinuteEdit.Value := ReconnectStartMinuteEdit.Text := ""
    SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartMinute"])
    
    RunAntiAFKCheckBox.Value := Globals["Settings"]["AntiAFK"]["RunAntiAFK"]
    
    AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
    SetCueBanner(AntiAFKIntervalEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKInterval"])
    
    MoveSpeedCorrectionCheckBox.Value := Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"]
    
    ShiftlockMovingCheckBox.Value := Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"]
    
    AdditionalKeyDelayEdit.Value := AdditionalKeyDelayEdit.Text := ""
    SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
    
    ResetMultiplierSlider.Value := Globals["Settings"]["Miscellaneous"]["ResetMultiplier"]
    
    ClickIntervalEdit.Value := ClickIntervalEdit.Text := ""
    SetCueBanner(ClickIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])
    
    ClickAmountEdit.Value := ClickAmountEdit.Text := ""
    SetCueBanner(ClickAmountEdit.Hwnd, (Globals["Settings"]["Autoclicker"]["ClickAmount"] ? Globals["Settings"]["Autoclicker"]["ClickAmount"] : "infinite"))
    
    AutoclickerHotkeyButton.Text := "Hotkey: " Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"]
}

SettingsTabOn := True

SettingsTabSwitch(*) {
    
    SetSettingsTabValues()
    
    Global SettingsTabOn
    
    SettingsTabOn := !SettingsTabOn
    
    SubmitSettingsButton.Enabled := SettingsTabOn
    
    MoveSpeedEdit.Enabled := SettingsTabOn
    
    MoveMethodList.Enabled := SettingsTabOn
    
    NumberOfSprinklersList.Enabled := SettingsTabOn
    
    HiveSlotNumberList.Enabled := SettingsTabOn
    
    PrivateServerLinkEdit.Enabled := SettingsTabOn
    
    RunrbxfpsunlockerCheckBox.Enabled := SettingsTabOn
    
    FPSEdit.Enabled := (SettingsTabOn ? Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"] : False)
    
    AutoEquipList.Enabled := SettingsTabOn
    
    HasGiftedViciousCheckBox.Enabled := SettingsTabOn
    
    ResetButton.Enabled := SettingsTabOn
    
    HasRedCannonCheckBox.Enabled := SettingsTabOn
    
    HasParachuteCheckBox.Enabled := SettingsTabOn
    
    HasGliderCheckBox.Enabled := (SettingsTabOn ? Globals["Settings"]["Unlocks"]["HasParachute"] : False)
    
    HasGummyMaskCheckBox.Enabled := SettingsTabOn
    
    HasDiamondMaskCheckBox.Enabled := SettingsTabOn
    
    HasDemonMaskCheckBox.Enabled := SettingsTabOn
    
    HasPetalWandCheckBox.Enabled := SettingsTabOn
    
    HasGummyballerCheckBox.Enabled := SettingsTabOn
    
    HasTidePopperCheckBox.Enabled := SettingsTabOn
    
    HasDarkScytheCheckBox.Enabled := SettingsTabOn
    
    NumberOfBeesEdit.Enabled := SettingsTabOn
    
    HotkeysInfoButton.Enabled := SettingsTabOn
    
    StartHotkeyButton.Enabled := SettingsTabOn
    
    PauseHotkeyButton.Enabled := SettingsTabOn
    
    StopHotkeyButton.Enabled := SettingsTabOn
    
    AlwaysOnTopCheckBox.Enabled := SettingsTabOn
    
    TransparencyList.Enabled := SettingsTabOn
    
    ConvertDelayEdit.Enabled := SettingsTabOn
    
    BalloonConvertSettingList.Enabled := SettingsTabOn
    
    BalloonConvertIntervalEdit.Enabled := SettingsTabOn
    
    ReconnectIntervalEdit.Enabled := SettingsTabOn
    
    ReconnectStartHourEdit.Enabled := SettingsTabOn
    
    ReconnectStartMinuteEdit.Enabled := SettingsTabOn
    
    AntiAFKInfoButton.Enabled := SettingsTabOn
    
    RunAntiAFKCheckBox.Enabled := SettingsTabOn
    
    AntiAFKIntervalEdit.Enabled := (SettingsTabOn ? Globals["Settings"]["AntiAFK"]["RunAntiAFK"] : False)
    
    MoveSpeedCorrectionCheckBox.Enabled := SettingsTabOn
    
    ShiftlockMovingCheckBox.Enabled := SettingsTabOn
    
    AdditionalKeyDelayEdit.Enabled := SettingsTabOn
    
    ResetMultiplierSlider.Enabled := SettingsTabOn
    
    ImportSettingsButton.Enabled := SettingsTabOn
    
    ClickIntervalEdit.Enabled := SettingsTabOn
    
    ClickAmountEdit.Enabled := SettingsTabOn
    
    AutoclickerHotkeyButton.Enabled := SettingsTabOn
}