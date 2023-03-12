MainTabs.UseTab("Settings")

#Include *i Settings\Basic Settings.ahk
#Include *i Settings\Reconnect.ahk
#Include *i Settings\CollectKill.ahk
#Include *i Settings\Unlocks.ahk
#Include *i Settings\Hotkeys.ahk
#Include *i Settings\GUI.ahk
#Include *i Settings\Convert Settings.ahk
#Include *i Settings\rbxfpsunlocker.ahk
#Include *i Settings\AntiAFK.ahk
#Include *i Settings\Miscellaneous.ahk
#Include *i Settings\Autoclicker.ahk

#Include *i Settings\EditHotkeysGUI\Edit Hotkeys.ahk
ShowEditHotkeysGUI := False

Try
EditHotkeysGUI.Show("Hide")
Catch Any
    MissingFilesError()

UpdateMoveMethods(*) {
    MoveMethodList.Delete()
    MoveMethodArray := Array()
    MoveMethodArray.Push("Walk")
    Flag := False
    If (Globals["Settings"]["Unlocks"]["HasRedCannon"]) {
        MoveMethodArray.Push("Cannon Walk")
        If (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Cannon Walk")
            Flag := True
        If (Globals["Settings"]["Unlocks"]["HasParachute"]) {
            MoveMethodArray.Push("Cannon Fly")
            MoveMethodArray.InsertAt(1, "Default")
            If (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Cannon Fly" || Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default")
                Flag := True
        }
    }
    MoveMethodList.Add(MoveMethodArray)
    MoveMethodList.Choose(Flag ? Globals["Settings"]["Basic Settings"]["MoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"] := "Walk")
    HasGliderCheckBox.Enabled := HasParachuteCheckBox.Value
    If (!HasParachuteCheckBox.Value)
        HasGliderCheckBox.Value := HasParachuteCheckBox.Value
}

SubmitSettingsButton := IvyshineGUI.Add("Button", "x0 y0 w1 h1 Hidden vSubmitSettingsButton")
SubmitSettingsButton.OnEvent("Click", SubmitSettings)

SubmitSettings(ThisControl, *) {
    SubmitButton := (ThisControl.Hwnd == SubmitSettingsButton.Hwnd)
    ThisControl := (ThisControl.Hwnd == SubmitSettingsButton.Hwnd ? IvyshineGUI.FocusedCtrl : ThisControl)
    If (!ThisControl)
        Return
    
    Else If (ThisControl.Hwnd == MoveSpeedEdit.Hwnd) {
        MoveSpeed := Trim(MoveSpeedEdit.Value)
        MoveSpeedEdit.Text := MoveSpeedEdit.Value := ""
        If (IsNumber(MoveSpeed) && MoveSpeed <= 50 && MoveSpeed > 0) {
            IniWrite(Globals["Settings"]["Basic Settings"]["MoveSpeed"] := Round(Number(MoveSpeed), 2), Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveSpeed")
            SetCueBanner(MoveSpeedEdit.Hwnd, Globals["Settings"]["Basic Settings"]["MoveSpeed"])
        } Else If (IsNumber(MoveSpeed) && (MoveSpeed > 50 || MoveSpeed <= 0))
            DefaultErrorBalloonTip("Accepted: positive numbers <= 50`r`nMake sure you have no haste."
                , "Out of range!"
                , MoveSpeedEdit.Hwnd)
        Else If (!IsNumber(MoveSpeed) && MoveSpeed != "")
            DefaultErrorBalloonTip("Accepted: positive numbers <= 50"
                , "Not a number!"
                , MoveSpeedEdit.Hwnd)
    }
    
    Else If (ThisControl.Hwnd == MoveMethodList.Hwnd) {
        IniWrite(Globals["Settings"]["Basic Settings"]["MoveMethod"]:= MoveMethodList.Text, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "MoveMethod")
        
        For Field in Globals["Field Defaults"]
            IniWrite(Globals["Field Defaults"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Defaults"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"]), Globals["Constants"]["ini FilePaths"]["Field Defaults"], Field, "MoveMethod")
    }
    
    Else If (ThisControl.Hwnd == NumberOfSprinklersList.Hwnd)
        IniWrite(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"] := NumberOfSprinklersList.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "NumberOfSprinklers")
    
    Else If (ThisControl.Hwnd == HiveSlotNumberList.Hwnd)
        IniWrite(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"] := HiveSlotNumberList.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "HiveSlotNumber")
    
    Else If (ThisControl.Hwnd == PrivateServerLinkEdit.Hwnd) {
        PrivateServerLink := StrReplace(Trim(PrivateServerLinkEdit.Value), " ")
        PrivateServerLinkEdit.Text := PrivateServerLinkEdit.Value := ""
        If (!PrivateServerLink && !SubmitButton)
            SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
        Else If ((!PrivateServerLink && SubmitButton)|| RegExMatch(PrivateServerLink, "i)^((http(s)?):\/\/)?((www|web)\.)?roblox\.com\/games\/(1537690962|4189852503)\/?([^\/]*)\?privateServerLinkCode=.{32}(\&[^\/]*)*$"))
            IniWrite(Globals["Settings"]["Basic Settings"]["PrivateServerLink"] := PrivateServerLink, Globals["Constants"]["ini FilePaths"]["Settings"], "Basic Settings", "PrivateServerLink")
        Else
            DefaultErrorBalloonTip("Please copy the private server link directly from the configuration page."
                , "Invalid Link!"
                , PrivateServerLinkEdit.Hwnd)
        SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
    }
    
    Else If (ThisControl.Hwnd == ReconnectIntervalEdit.Hwnd) {
        If (ReconnectIntervalEdit.Value == "" && !SubmitButton)
            Return
        If (!ReconnectIntervalEdit.Value || Mod(24, ReconnectIntervalEdit.Value) == 0) {
            Globals["Settings"]["Reconnect"]["ReconnectInterval"] := (ReconnectIntervalEdit.Value ? ReconnectIntervalEdit.Value : "")
            IniWrite(Globals["Settings"]["Reconnect"]["ReconnectInterval"], Globals["Constants"]["ini FilePaths"]["Settings"], "Reconnect", "ReconnectInterval")
        } Else
            DefaultErrorBalloonTip("Accepted: factors of 24:`r`n1, 2, 3, 4, 6, 8, 12, 24"
                , "Value not accepted!"
                , ReconnectIntervalEdit.Hwnd)
        ReconnectIntervalEdit.Value := ReconnectIntervalEdit.Text := ""
        SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectInterval"])
        ReconnectIntervalText.Text := (Globals["Settings"]["Reconnect"]["ReconnectInterval"] == 1 ? " hour," : " hours,")
    }
    
    Else If (ThisControl.Hwnd == ReconnectStartHourEdit.Hwnd) {
        If (ReconnectStartHourEdit.Value == "" && !SubmitButton)
            Return
        ReconnectStartHourEdit.Value := Format("{:02}", Number((ReconnectStartHourEdit.Value ? ReconnectStartHourEdit.Value : 0)))
        If (ReconnectStartHourEdit.Value >= 0 && ReconnectStartHourEdit.Value <= 23)
            IniWrite(Globals["Settings"]["Reconnect"]["ReconnectStartHour"] := ReconnectStartHourEdit.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Reconnect", "ReconnectStartHour")
        Else
            DefaultErrorBalloonTip("Accepted: 0 <= n <= 23"
                , "Out of range!"
                , ReconnectStartHourEdit.Hwnd)
        ReconnectStartHourEdit.Value := ReconnectStartHourEdit.Text := ""
        SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartHour"])
    }
    
    Else If (ThisControl.Hwnd == ReconnectStartMinuteEdit.Hwnd) {
        If (ReconnectStartMinuteEdit.Value == "" && !SubmitButton)
            Return
        ReconnectStartMinuteEdit.Value := Format("{:02}", Number((ReconnectStartMinuteEdit.Value ? ReconnectStartMinuteEdit.Value : 0)))
        If (ReconnectStartMinuteEdit.Value >= 0 && ReconnectStartMinuteEdit.Value <= 59)
            IniWrite(Globals["Settings"]["Reconnect"]["ReconnectStartMinute"] := ReconnectStartMinuteEdit.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Reconnect", "ReconnectStartMinute")
        Else
            DefaultErrorBalloonTip("Accepted: 0 <= n <= 59"
                , "Out of range!"
                , ReconnectStartMinuteEdit.Hwnd)
        ReconnectStartMinuteEdit.Value := ReconnectStartMinuteEdit.Text := ""
        SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartMinute"])
    }
    
    Else If (ThisControl.Hwnd == HasGiftedViciousCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"] := HasGiftedViciousCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Collect/Kill", "HasGiftedVicious")
    
    Else If (ThisControl.Hwnd == AutoEquipList.Hwnd) {
        IniWrite(Globals["Settings"]["Collect/Kill"]["AutoEquip"] := AutoEquipList.Text, Globals["Constants"]["ini FilePaths"]["Settings"], "Collect/Kill", "AutoEquip")
        
        For Field in Globals["Field Defaults"]
            IniWrite(Globals["Field Defaults"][Field]["AutoEquip"] := InStr("DefaultAllGather Only", Globals["Settings"]["Collect/Kill"]["AutoEquip"]), Globals["Constants"]["ini FilePaths"]["Field Defaults"], Field, "AutoEquip")
    }
    
    Else If (ThisControl.Hwnd == HasRedCannonCheckBox.Hwnd) {
        IniWrite(Globals["Settings"]["Unlocks"]["HasRedCannon"] := HasRedCannonCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasRedCannon")
        UpdateMoveMethods()
    }
    
    Else If (ThisControl.Hwnd == HasParachuteCheckBox.Hwnd) {
        IniWrite(Globals["Settings"]["Unlocks"]["HasParachute"] := HasParachuteCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasParachute")
        If (!Globals["Settings"]["Unlocks"]["HasParachute"])
            IniWrite(Globals["Settings"]["Unlocks"]["HasGlider"] := 0, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGlider")
        UpdateMoveMethods()
        
        For Field in Globals["Field Defaults"]
            IniWrite(Globals["Field Defaults"][Field]["MoveMethod"] := (Globals["Settings"]["Basic Settings"]["MoveMethod"] == "Default" ? Globals["Field Defaults"][Field]["DefaultMoveMethod"] : Globals["Settings"]["Basic Settings"]["MoveMethod"]), Globals["Constants"]["ini FilePaths"]["Field Defaults"], Field, "MoveMethod")
    }
    
    Else If (ThisControl.Hwnd == HasGliderCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasGlider"] := HasGliderCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGlider")
    
    Else If (ThisControl.Hwnd == HasGummyMaskCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasGummyMask"] := HasGummyMaskCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGummyMask")
    
    Else If (ThisControl.Hwnd == HasDiamondMaskCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasDiamondMask"] := HasDiamondMaskCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDiamondMask")
    
    Else If (ThisControl.Hwnd == HasDemonMaskCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasDemonMask"] := HasDemonMaskCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDemonMask")
    
    Else If (ThisControl.Hwnd == HasPetalWandCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasPetalWand"] := HasPetalWandCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasPetalWand")
    
    Else If (ThisControl.Hwnd == HasGummyballerCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasGummyballer"] := HasGummyballerCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasGummyballer")
    
    Else If (ThisControl.Hwnd == HasTidePopperCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasTidePopper"] := HasTidePopperCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasTidePopper")
    
    Else If (ThisControl.Hwnd == HasDarkScytheCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Unlocks"]["HasDarkScythe"] := HasDarkScytheCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "HasDarkScythe")
    
    Else If (ThisControl.Hwnd == NumberOfBeesEdit.Hwnd) {
        NumberOfBees := Trim(NumberOfBeesEdit.Value)
        NumberOfBeesEdit.Text := NumberOfBeesEdit.Value := ""
        If (IsInteger(NumberOfBees) && NumberOfBees <= 50 && NumberOfBees > 0) {
            IniWrite(Globals["Settings"]["Unlocks"]["NumberOfBees"] := Round(Integer(NumberOfBees)), Globals["Constants"]["ini FilePaths"]["Settings"], "Unlocks", "NumberOfBees")
            SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
        } Else If (IsInteger(NumberOfBees) && (NumberOfBees > 50 || NumberOfBees == 0))
            DefaultErrorBalloonTip("Accepted: positive integers <= 50"
                , "Out of range!"
                , NumberOfBeesEdit.Hwnd)
    }
    
    Else If (ThisControl.Hwnd == AlwaysOnTopCheckBox.Hwnd) {
        IniWrite(Globals["Settings"]["GUI"]["AlwaysOnTop"] := AlwaysOnTopCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "GUI", "AlwaysOnTop")
        IvyshineGUI.Opt((Globals["Settings"]["GUI"]["AlwaysOnTop"] ? "+" : "-") "AlwaysOnTop")
    }
    
    Else If (ThisControl.Hwnd == TransparencyList.Hwnd) {
        IniWrite(Globals["Settings"]["GUI"]["Transparency"] := TransparencyList.Text, Globals["Constants"]["ini FilePaths"]["Settings"], "GUI", "Transparency")
        WinSetTransparent(255 - Floor(Globals["Settings"]["GUI"]["Transparency"] * 2.55), IvyshineGUI)
    }
    
    Else If (ThisControl.Hwnd == ConvertDelayEdit.Hwnd) {
        NewConvertDelay := Trim(ConvertDelayEdit.Value)
        ConvertDelayEdit.Text := ConvertDelayEdit.Value := ""
        If (IsInteger(NewConvertDelay) && NewConvertDelay <= 20 && NewConvertDelay >= 0) {
            IniWrite(Globals["Settings"]["Convert Settings"]["ConvertDelay"] := Round(Integer(NewConvertDelay)), Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "ConvertDelay")
            SetCueBanner(ConvertDelayEdit.Hwnd, Globals["Settings"]["Convert Settings"]["ConvertDelay"])
        } Else If (IsInteger(NewConvertDelay) && NewConvertDelay > 20)
            DefaultErrorBalloonTip("Accepted: non-negative integers <= 20"
                , "Out of range!"
                , ConvertDelayEdit.Hwnd)
    }
    
    Else If (ThisControl.Hwnd == BalloonConvertSettingList.Hwnd) {
        IniWrite(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] := BalloonConvertSettingList.Text, Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "BalloonConvertSetting")
        BalloonConvertIntervalEdit.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
        BalloonConvertIntervalText.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
    }
    
    Else If (ThisControl.Hwnd == BalloonConvertIntervalEdit.Hwnd) {
        If (BalloonConvertIntervalEdit.Value == "" && !SubmitButton)
            Return
        Else If ((BalloonConvertIntervalEdit.Value == "" && SubmitButton) || BalloonConvertIntervalEdit.Value == 0) {
            IniWrite(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] := "Never", Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "BalloonConvertSetting")
            BalloonConvertSettingList.Choose(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"])
            BalloonConvertIntervalEdit.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
            BalloonConvertIntervalText.Visible := (Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"] == "Every")
        } Else
            IniWrite(Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"] := Integer(BalloonConvertIntervalEdit.Value), Globals["Constants"]["ini FilePaths"]["Settings"], "Convert Settings", "BalloonConvertInterval")
        BalloonConvertIntervalEdit.Value := BalloonConvertIntervalEdit.Text := ""
        SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"])
    }
    
    Else If (ThisControl.Hwnd == RunrbxfpsunlockerCheckBox.Hwnd) {
        RunrbxfpsunlockerCheckBox.Enabled := False
        FPSEdit.Enabled := False
        IniWrite(Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"] := RunrbxfpsunlockerCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "rbxfpsunlocker", "Runrbxfpsunlocker")
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
        RunrbxfpsunlockerCheckBox.Enabled := False
        FPSEdit.Enabled := False
        IniWrite(Globals["Settings"]["rbxfpsunlocker"]["FPS"] := (FPSEdit.Value ? FPSEdit.Value : 0), Globals["Constants"]["ini FilePaths"]["Settings"], "rbxfpsunlocker", "FPS")
        SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] == 0 ? "inf" : Globals["Settings"]["rbxfpsunlocker"]["FPS"]))
        FPSEdit.Value := FPSEdit.Text := ""
        RunFPSUnlocker(Globals["Settings"]["rbxfpsunlocker"]["FPS"])
        FPSEdit.Enabled := Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"]
        RunrbxfpsunlockerCheckBox.Enabled := True
    }
    
    Else If (ThisControl.Hwnd == MoveSpeedCorrectionCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Miscellaneous"]["MoveSpeedCorrection"] := MoveSpeedCorrectionCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "MoveSpeedCorrection")
    
    Else If (ThisControl.Hwnd == RunAntiAFKCheckBox.Hwnd) {
        IniWrite(Globals["Settings"]["AntiAFK"]["RunAntiAFK"] := RunAntiAFKCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "AntiAFK", "RunAntiAFK")
        If (Globals["Settings"]["AntiAFK"]["RunAntiAFK"]) {
            AntiAFKIntervalEdit.Enabled := True
            AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
            SetCueBanner(AntiAFKIntervalEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKInterval"])
            AntiAFKIntervalText.Text := (Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] == 1 ? " minute." : " minutes.")
            Globals["Settings"]["AntiAFK"]["LastRun"] := CurrentTime()
            SetTimer(AntiAFK, 500, -1)
        } Else {
            AntiAFKIntervalEdit.Enabled := False
            SetTimer(AntiAFK, 0)
            AntiAFKIntervalText.Text := " minutes."
        }
        AntiAFKProgress.Value := 0
    }
    
    Else If (ThisControl.Hwnd == AntiAFKIntervalEdit.Hwnd) {
        If (IsNumber(AntiAFKIntervalEdit.Value) && AntiAFKIntervalEdit.Value > 0 && AntiAFKIntervalEdit.Value <= 20) {
            IniWrite(Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] := Round(Number(AntiAFKIntervalEdit.Value)), Globals["Constants"]["ini FilePaths"]["Settings"], "AntiAFK", "AntiAFKInterval")
            SetCueBanner(AntiAFKIntervalEdit.Hwnd, Globals["Settings"]["AntiAFK"]["AntiAFKInterval"])
            AntiAFKIntervalText.Text := (Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] == 1 ? " minute." : " minutes.")
            AntiAFKProgress.Opt("Range0-" (Globals["Settings"]["AntiAFK"]["AntiAFKInterval"] * 60))
        } Else If (IsNumber(AntiAFKIntervalEdit.Value) && (AntiAFKIntervalEdit.Value == 0 || AntiAFKIntervalEdit.Value > 20))
            DefaultErrorBalloonTip("Accepted: positive Integers <= 20"
                , "Out of range!"
                , AntiAFKIntervalEdit.Hwnd)
        AntiAFKIntervalEdit.Value := AntiAFKIntervalEdit.Text := ""
    }
    
    Else If (ThisControl.Hwnd == ShiftlockMovingCheckBox.Hwnd)
        IniWrite(Globals["Settings"]["Miscellaneous"]["ShiftlockMoving"] := ShiftlockMovingCheckBox.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ShiftlockMoving")
    
    Else If (ThisControl.Hwnd == AdditionalKeyDelayEdit.Hwnd) {
        If (AdditionalKeyDelayEdit.Value == "" && !SubmitButton)
            Return
        IniWrite(Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"] := Round(Number((AdditionalKeyDelayEdit.Value ? AdditionalKeyDelayEdit.Value : 0))), Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "AdditionalKeyDelay")
        SetCueBanner(AdditionalKeyDelayEdit.Hwnd, Globals["Settings"]["Miscellaneous"]["AdditionalKeyDelay"])
        AdditionalKeyDelayEdit.Value := AdditionalKeyDelayEdit.Text := ""
    }
    
    Else If (ThisControl.Hwnd == ResetMultiplierSlider.Hwnd)
        IniWrite(Globals["Settings"]["Miscellaneous"]["ResetMultiplier"] := ResetMultiplierSlider.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Miscellaneous", "ResetMultiplier")
    
    Else If (ThisControl.Hwnd == ClickIntervalEdit.Hwnd) {
        If (IsNumber(ClickIntervalEdit.Value) && ClickIntervalEdit.Value > 0) {
            IniWrite(Globals["Settings"]["Autoclicker"]["ClickInterval"] := ClickIntervalEdit.Value, Globals["Constants"]["ini FilePaths"]["Settings"], "Autoclicker", "ClickInterval")
            SetCueBanner(ClickIntervalEdit.Hwnd, Globals["Settings"]["Autoclicker"]["ClickInterval"])
        } Else If (IsNumber(ClickIntervalEdit.Value) && ClickIntervalEdit.Value == 0)
            DefaultErrorBalloonTip("Accepted: positive integers"
                , "0 ms will break your computer"
                , ClickIntervalEdit.Hwnd)
        ClickIntervalEdit.Value := ClickIntervalEdit.Text := ""
    }
    
    Else If (ThisControl.Hwnd == ClickAmountEdit.Hwnd) {
        If (ClickAmountEdit.Value == "" && !SubmitButton)
            Return
        IniWrite(Globals["Settings"]["Autoclicker"]["ClickAmount"] := (ClickAmountEdit.Value ? ClickAmountEdit.Value : "0"), Globals["Constants"]["ini FilePaths"]["Settings"], "Autoclicker", "ClickAmount")
        SetCueBanner(ClickAmountEdit.Hwnd, (Globals["Settings"]["Autoclicker"]["ClickAmount"] ? Globals["Settings"]["Autoclicker"]["ClickAmount"] : "infinite"))
        ClickAmountEdit.Value := ClickAmountEdit.Text := ""
        Globals["Settings"]["Autoclicker"]["ClickCounter"] := 0
    }
}

SetSettingsTabValues(*) {
    MoveSpeedEdit.Value := MoveSpeedEdit.Text := ""
    SetCueBanner(MoveSpeedEdit.Hwnd, Round(Number(Globals["Settings"]["Basic Settings"]["MoveSpeed"]), 2))
    
    NumberOfSprinklersList.Choose(Globals["Settings"]["Basic Settings"]["NumberOfSprinklers"])
    
    HiveSlotNumberList.Choose(Globals["Settings"]["Basic Settings"]["HiveSlotNumber"])
    
    PrivateServerLinkEdit.Value := PrivateServerLinkEdit.Text := ""
    SetCueBanner(PrivateServerLinkEdit.Hwnd, Globals["Settings"]["Basic Settings"]["PrivateServerLink"])
    
    ReconnectIntervalEdit.Value := ReconnectIntervalEdit.Text := ""
    SetCueBanner(ReconnectIntervalEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectInterval"])
    
    ReconnectStartHourEdit.Value := ReconnectStartHourEdit.Text := ""
    SetCueBanner(ReconnectStartHourEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartHour"])
    
    ReconnectStartMinuteEdit.Value := ReconnectStartMinuteEdit.Text := ""
    SetCueBanner(ReconnectStartMinuteEdit.Hwnd, Globals["Settings"]["Reconnect"]["ReconnectStartMinute"])
    
    HasGiftedViciousCheckBox.Value := Globals["Settings"]["Collect/Kill"]["HasGiftedVicious"]
    
    AutoEquipList.Choose(Globals["Settings"]["Collect/Kill"]["AutoEquip"])
    
    HasRedCannonCheckBox.Value := Globals["Settings"]["Unlocks"]["HasRedCannon"]
    
    HasParachuteCheckBox.Value := Globals["Settings"]["Unlocks"]["HasParachute"]
    
    HasGliderCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGlider"]
    
    UpdateMoveMethods()
    
    HasGummyMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGummyMask"]
    
    HasDiamondMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDiamondMask"]
    
    HasDemonMaskCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDemonMask"]
    
    HasPetalWandCheckBox.Value := Globals["Settings"]["Unlocks"]["HasPetalWand"]
    
    HasGummyballerCheckBox.Value := Globals["Settings"]["Unlocks"]["HasGummyballer"]
    
    HasTidePopperCheckBox.Value := Globals["Settings"]["Unlocks"]["HasTidePopper"]
    
    HasDarkScytheCheckBox.Value := Globals["Settings"]["Unlocks"]["HasDarkScythe"]
    
    NumberOfBeesEdit.Value := NumberOfBeesEdit.Text := ""
    SetCueBanner(NumberOfBeesEdit.Hwnd, Globals["Settings"]["Unlocks"]["NumberOfBees"])
    
    HotkeysListBox.Delete()
    HotkeysListBox.Add(["Start (" Globals["Settings"]["Hotkeys"]["StartHotkey"] ")", "Pause (" Globals["Settings"]["Hotkeys"]["PauseHotkey"] ")", "Stop (" Globals["Settings"]["Hotkeys"]["StopHotkey"] ")", "Autoclicker (" Globals["Settings"]["Hotkeys"]["AutoclickerHotkey"] ")", "Tray (" Globals["Settings"]["Hotkeys"]["TrayHotkey"] ")", "Debug (" Globals["Settings"]["Hotkeys"]["DebugHotkey"] ")", "Suspend (" Globals["Settings"]["Hotkeys"]["SuspendHotkey"] ")"])
    
    AlwaysOnTopCheckBox.Value := Globals["Settings"]["GUI"]["AlwaysOnTop"]
    
    TransparencyList.Choose(Globals["Settings"]["GUI"]["Transparency"])
    
    ConvertDelayEdit.Value := ConvertDelayEdit.Text := ""
    SetCueBanner(ConvertDelayEdit.Hwnd, Globals["Settings"]["Convert Settings"]["ConvertDelay"])
    
    BalloonConvertSettingList.Choose(Globals["Settings"]["Convert Settings"]["BalloonConvertSetting"])
    
    BalloonConvertIntervalEdit.Value := BalloonConvertIntervalEdit.Text := ""
    SetCueBanner(BalloonConvertIntervalEdit.Hwnd, Globals["Settings"]["Convert Settings"]["BalloonConvertInterval"])
    
    RunrbxfpsunlockerCheckBox.Value := Globals["Settings"]["rbxfpsunlocker"]["Runrbxfpsunlocker"]
    
    FPSEdit.Value := FPSEdit.Text := ""
    SetCueBanner(FPSEdit.Hwnd, (Globals["Settings"]["rbxfpsunlocker"]["FPS"] ? Globals["Settings"]["rbxfpsunlocker"]["FPS"] : "inf"))
    
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
    
    HotkeysListBox.Enabled := SettingsTabOn
    
    HotkeysInfoButton.Enabled := SettingsTabOn
    
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
}