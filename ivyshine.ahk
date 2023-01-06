#NoTrayIcon
#WinActivateForce
#UseHook True
#MaxThreads 255
#SingleInstance Force
#Include "%A_ScriptDir%"
#Requires AutoHotkey v2.0 32-bit

SetWorkingDir(A_ScriptDir)
CoordMode("Pixel", "Client")
CoordMode("Mouse", "Client")

;=====================================
; Check Resolution
;=====================================
; CheckResolution()
CheckResolution() {
    if (A_ScreenDPI != 96 || A_ScreenWidth != 1280 || A_ScreenHeight != 720) {
        CurrentScaling := Floor(A_ScreenDPI / 96 * 100)
        MsgBox("The images taken for this macro were created for 1280x720p resolution on 100`% scaling.`r`nYou are currently on " A_ScreenWidth "x" A_ScreenHeight "p with " CurrentScaling "`% scaling.`r`nThe Windows display settings tab will now be opened.`r`nPlease change the resolution to be correct.", "Warning!", "OK Iconx")
        Run("ms-settings:display")
        DoReload := MsgBox("Press `"OK`" when you have changed your resolution to 1280x720p with 100`% scaling. Press `"Cancel`" to continue regardless.",, "OKCancel Iconx")
        if (DoReload == "OK")
            Reload
    }
    
    WinClose("Settings")
}

;=====================================
; Check for updates
;=====================================
CurrentVersionID := "001"
; CheckForUpdates()
CheckForUpdates() {
    WinHttpRequest := ComObject("WinHttp.WinHttpRequest.5.1")
    WinHttpRequest.Open("GET", "https://raw.githubusercontent.com/XRay71/ivyshine/main/version.txt", true)
    WinHttpRequest.Send()
    WinHttpRequest.WaitForResponse()
    NewVersionID := RegExReplace(Trim(WinHttpRequest.ResponseText), "\.? *(\n|\r)+")
    
    if (IsNumber(NewVersionID) && CurrentVersionID != NewVersionID) {
        if (!A_IsAdmin)
            Update := MsgBox("You are currently running version v" CurrentVersionID ".`r`nWould you like to install the newest version: v" NewVersionID "?"
                , "New version found!"
                , "YesNo Icon!")
        else
            Update := True
        
        if (Update != "No") {
            if (!A_IsAdmin) {
                try {
                    Run("*RunAs " A_AhkPath " /restart " A_ScriptFullPath)
                    ExitApp
                }
            }
            
            Try {
                Download("https://github.com/XRay71/ivyshine/archive/main.zip", "NewVersion.zip")
            } Catch Any {
                MsgBox("Something went wrong while downloading the update!`r`nNothing has been changed.", "Error!", "OK Iconx")
                if (FileExist("NewVersion.zip"))
                    FileDelete("NewVersion.zip")
                Return
            }
            
            PowerShell := ComObject("Shell.Application")
            PowerShell.Namespace(A_WorkingDir).CopyHere(PowerShell.Namespace(A_WorkingDir "\NewVersion.zip").items, 4|16)
            PowerShell.Namespace(A_WorkingDir).MoveHere(PowerShell.Namespace(A_WorkingDir "\ivyshine-main").items, 4|16)
            FileDelete("NewVersion.zip")
            DirDelete("ivyshine-main")
            
            Run("ivyshine.ahk")
            ExitApp
        }
    }
    
    if (FileExist("version.txt")) {
        FileDelete("version.txt")
        MsgBox("You have successfully been updated to the newest version: v" CurrentVersionID "!", "Update success!")
    }
}

;=====================================
; Initialising
;=====================================

Globals := Map()

Globals["GUI"] := Map()

Globals["GUI"]["Settings"] := Map(
"GuiX", "0",
"GuiY", "340",
"AlwaysOnTop", "0",
"Transparency", "0",
"CurrentGUITab", "Settings"
)

Globals["Settings"] := Map()

Globals["Settings"]["Basic Settings"] := Map(
"MoveSpeed", "28",
"MoveMethod", "Glider",
"NumberOfSprinklers", "1",
"HiveSlotNumber", "1",
"PrivateServerLink", ""
)

Globals["Settings"]["Bees"] := Map(
"HasBearBee", "1",
"HasGiftedVicious", "1"
)

Globals["Settings"]["Hotkeys"] := Map(
"StartHotkey", "F1",
"PauseHotkey", "F2",
"StopHotkey", "F3"
)

Globals["Settings"]["Keybinds"] := Map(
"KeyboardLayout", "qwerty",
"BaseForwardKey", "w",
"BaseBackwardKey", "s",
"BaseLeftKey", "a",
"BaseRightKey", "d",
"CameraRightKey", ".",
"CameraLeftKey", ",",
"CameraInKey", "i",
"CameraOutKey", "o",
"CameraUpKey", "PgDn",
"CameraDownKey", "PgUp",
"AdditionalKeyDelay", "0"
)

Globals["Settings"]["rbxfpsunlocker"] := Map(
"Runrbxfpsunlocker", "1",
"FPSNumber", "30"
)

Globals["Settings"]["Unlocks"] := Map(
"UnlockedRedCannon", "1",
"UnlockedParachute", "1",
"UnlockedGlider", "1",
"NumberOfBees", "50"
)

Globals["Fields"] := Map()

Globals["Fields"]["Field Rotation"] := Map(
"FieldRotationList", "Pine Tree|",
"CurrentlySelectedField", "Pine Tree",
"NonRotationList", "Bamboo|Blue Flower|Cactus|Clover|Coconut|Dandelion|Mountain Top|Mushroom|Pepper|Pineapple|Pumpkin|Rose|Spider|Strawberry|Stump|Sunflower|"
)

Globals["FieldConfigs"] := Map()

Globals["FieldConfigs"]["Bamboo"] := Map(
"BambooFlowerLength", "18",
"BambooFlowerWidth", "39",
"BambooNorthWall", "1",
"BambooEastWall", "1",
"BambooSouthWall", "1",
"BambooWestWall", "0",
"BambooNorthWallDistance", "0",
"BambooEastWallDistance", "1",
"BambooSouthWallDistance", "1",
"BambooWestWallDistance", "0",
"BambooGatherPattern", "",
"BambooPatternLength", "3",
"BambooPatternWidth", "5",
"BambooGatherWithShiftLock", "0",
"BambooInvertFB", "0",
"BambooInvertRL", "0",
"BambooGatherTime", "10",
"BambooBagPercent", "95",
"BambooStartPositionLength", "12",
"BambooStartPositionWidth", "20",
"BambooReturnMethod", "Reset",
"BambooTurnCamera", "None",
"BambooTurnCameraNum", "0"
)

Globals["FieldConfigs"]["BlueFlower"] := Map(
"BlueFlowerFlowerLength", "17",
"BlueFlowerFlowerWidth", "43",
"BlueFlowerNorthWall", "1",
"BlueFlowerEastWall", "0",
"BlueFlowerSouthWall", "1",
"BlueFlowerWestWall", "0",
"BlueFlowerNorthWallDistance", "0",
"BlueFlowerEastWallDistance", "0",
"BlueFlowerSouthWallDistance", "0",
"BlueFlowerWestWallDistance", "0",
"BlueFlowerGatherPattern", "",
"BlueFlowerPatternLength", "3",
"BlueFlowerPatternWidth", "5",
"BlueFlowerGatherWithShiftLock", "0",
"BlueFlowerInvertFB", "0",
"BlueFlowerInvertRL", "0",
"BlueFlowerGatherTime", "10",
"BlueFlowerBagPercent", "95",
"BlueFlowerStartPositionLength", "8",
"BlueFlowerStartPositionWidth", "23",
"BlueFlowerReturnMethod", "Reset",
"BlueFlowerTurnCamera", "None",
"BlueFlowerTurnCameraNum", "0"
)

Globals["FieldConfigs"]["Cactus"] := Map(
"CactusFlowerLength", "18",
"CactusFlowerWidth", "33",
"CactusNorthWall", "0",
"CactusEastWall", "1",
"CactusSouthWall", "0",
"CactusWestWall", "0",
"CactusNorthWallDistance", "0",
"CactusEastWallDistance", "0",
"CactusSouthWallDistance", "0",
"CactusWestWallDistance", "0",
"CactusGatherPattern", "",
"CactusPatternLength", "3",
"CactusPatternWidth", "5",
"CactusGatherWithShiftLock", "0",
"CactusInvertFB", "0",
"CactusInvertRL", "0",
"CactusGatherTime", "10",
"CactusBagPercent", "95",
"CactusStartPositionLength", "10",
"CactusStartPositionWidth", "17",
"CactusReturnMethod", "Reset",
"CactusTurnCamera", "None",
"CactusTurnCameraNum", "0"
)

Globals["FieldConfigs"]["Clover"] := Map(
"CloverFlowerLength", "27",
"CloverFlowerWidth", "39",
"CloverNorthWall", "0",
"CloverEastWall", "0",
"CloverSouthWall", "1",
"CloverWestWall", "0",
"CloverNorthWallDistance", "0",
"CloverEastWallDistance", "0",
"CloverSouthWallDistance", "0",
"CloverWestWallDistance", "0",
"CloverGatherPattern", "",
"CloverPatternLength", "3",
"CloverPatternWidth", "3",
"CloverGatherWithShiftLock", "0",
"CloverInvertFB", "0",
"CloverInvertRL", "0",
"CloverGatherTime", "10",
"CloverBagPercent", "95",
"CloverStartPositionLength", "12",
"CloverStartPositionWidth", "20",
"CloverReturnMethod", "Reset",
"CloverTurnCamera", "Right",
"CloverTurnCameraNum", "4"
)

Globals["FieldConfigs"]["Coconut"] := Map(
"CoconutFlowerLength", "21",
"CoconutFlowerWidth", "30",
"CoconutNorthWall", "0",
"CoconutEastWall", "1",
"CoconutSouthWall", "1",
"CoconutWestWall", "1",
"CoconutNorthWallDistance", "0",
"CoconutEastWallDistance", "0",
"CoconutSouthWallDistance", "0",
"CoconutWestWallDistance", "0",
"CoconutGatherPattern", "",
"CoconutPatternLength", "3",
"CoconutPatternWidth", "3",
"CoconutGatherWithShiftLock", "0",
"CoconutInvertFB", "0",
"CoconutInvertRL", "0",
"CoconutGatherTime", "10",
"CoconutBagPercent", "95",
"CoconutStartPositionLength", "6",
"CoconutStartPositionWidth", "10",
"CoconutReturnMethod", "Reset",
"CoconutTurnCamera", "Right",
"CoconutTurnCameraNum", "4"
)

Globals["FieldConfigs"]["Dandelion"] := Map(
"DandelionFlowerLength", "18",
"DandelionFlowerWidth", "36",
"DandelionNorthWall", "0",
"DandelionEastWall", "1",
"DandelionSouthWall", "0",
"DandelionWestWall", "0",
"DandelionNorthWallDistance", "0",
"DandelionEastWallDistance", "0",
"DandelionSouthWallDistance", "0",
"DandelionWestWallDistance", "0",
"DandelionGatherPattern", "",
"DandelionPatternLength", "2",
"DandelionPatternWidth", "5",
"DandelionGatherWithShiftLock", "0",
"DandelionInvertFB", "0",
"DandelionInvertRL", "0",
"DandelionGatherTime", "10",
"DandelionBagPercent", "95",
"DandelionStartPositionLength", "9",
"DandelionStartPositionWidth", "20",
"DandelionReturnMethod", "Reset",
"DandelionTurnCamera", "None",
"DandelionTurnCameraNum", "0"
)

Globals["FieldConfigs"]["MountainTop"] := Map(
"MountainTopFlowerLength", "28",
"MountainTopFlowerWidth", "24",
"MountainTopNorthWall", "1",
"MountainTopEastWall", "0",
"MountainTopSouthWall", "1",
"MountainTopWestWall", "1",
"MountainTopNorthWallDistance", "7",
"MountainTopEastWallDistance", "0",
"MountainTopSouthWallDistance", "1",
"MountainTopWestWallDistance", "4",
"MountainTopGatherPattern", "",
"MountainTopPatternLength", "2",
"MountainTopPatternWidth", "2",
"MountainTopGatherWithShiftLock", "0",
"MountainTopInvertFB", "0",
"MountainTopInvertRL", "0",
"MountainTopGatherTime", "10",
"MountainTopBagPercent", "95",
"MountainTopStartPositionLength", "13",
"MountainTopStartPositionWidth", "13",
"MountainTopReturnMethod", "Reset",
"MountainTopTurnCamera", "Left",
"MountainTopTurnCameraNum", "2"
)

Globals["FieldConfigs"]["Mushroom"] := Map(
"MushroomFlowerLength", "23",
"MushroomFlowerWidth", "32",
"MushroomNorthWall", "1",
"MushroomEastWall", "1",
"MushroomSouthWall", "0",
"MushroomWestWall", "1",
"MushroomNorthWallDistance", "0",
"MushroomEastWallDistance", "0",
"MushroomSouthWallDistance", "0",
"MushroomWestWallDistance", "0",
"MushroomGatherPattern", "",
"MushroomPatternLength", "3",
"MushroomPatternWidth", "3",
"MushroomGatherWithShiftLock", "0",
"MushroomInvertFB", "0",
"MushroomInvertRL", "0",
"MushroomGatherTime", "10",
"MushroomBagPercent", "95",
"MushroomStartPositionLength", "18",
"MushroomStartPositionWidth", "16",
"MushroomReturnMethod", "Reset",
"MushroomTurnCamera", "None",
"MushroomTurnCameraNum", "0"
)

Globals["FieldConfigs"]["Pepper"] := Map(
"PepperFlowerLength", "27",
"PepperFlowerWidth", "21",
"PepperNorthWall", "1",
"PepperEastWall", "0",
"PepperSouthWall", "1",
"PepperWestWall", "1",
"PepperNorthWallDistance", "",
"PepperEastWallDistance", "6",
"PepperSouthWallDistance", "6",
"PepperWestWallDistance", "3",
"PepperGatherPattern", "",
"PepperPatternLength", "3",
"PepperPatternWidth", "3",
"PepperGatherWithShiftLock", "0",
"PepperInvertFB", "0",
"PepperInvertRL", "0",
"PepperGatherTime", "10",
"PepperBagPercent", "95",
"PepperStartPositionLength", "14",
"PepperStartPositionWidth", "12",
"PepperReturnMethod", "Reset",
"PepperTurnCamera", "Left",
"PepperTurnCameraNum", "2"
)

Globals["FieldConfigs"]["PineTree"] := Map(
"PineTreeFlowerLength", "31",
"PineTreeFlowerWidth", "23",
"PineTreeNorthWall", "1",
"PineTreeEastWall", "0",
"PineTreeSouthWall", "0",
"PineTreeWestWall", "1",
"PineTreeNorthWallDistance", "1",
"PineTreeEastWallDistance", "0",
"PineTreeSouthWallDistance", "0",
"PineTreeWestWallDistance", "0",
"PineTreeGatherPattern", "",
"PineTreePatternLength", "3",
"PineTreePatternWidth", "3",
"PineTreeGatherWithShiftLock", "0",
"PineTreeInvertFB", "0",
"PineTreeInvertRL", "0",
"PineTreeGatherTime", "10",
"PineTreeBagPercent", "95",
"PineTreeStartPositionLength", "17",
"PineTreeStartPositionWidth", "10",
"PineTreeReturnMethod", "Reset",
"PineTreeTurnCamera", "Left",
"PineTreeTurnCameraNum", "2"
)

Globals["FieldConfigs"]["Pineapple"] := Map(
"PineappleFlowerLength", "23",
"PineappleFlowerWidth", "35",
"PineappleNorthWall", "1",
"PineappleEastWall", "1",
"PineappleSouthWall", "0",
"PineappleWestWall", "1",
"PineappleNorthWallDistance", "0",
"PineappleEastWallDistance", "0",
"PineappleSouthWallDistance", "0",
"PineappleWestWallDistance", "0",
"PineappleGatherPattern", "",
"PineapplePatternLength", "3",
"PineapplePatternWidth", "3",
"PineappleGatherWithShiftLock", "0",
"PineappleInvertFB", "0",
"PineappleInvertRL", "0",
"PineappleGatherTime", "10",
"PineappleBagPercent", "95",
"PineappleStartPositionLength", "14",
"PineappleStartPositionWidth", "14",
"PineappleReturnMethod", "Reset",
"PineappleTurnCamera", "None",
"PineappleTurnCameraNum", "0"
)

Globals["FieldConfigs"]["TestField"] := Map(
"TestFieldFlowerLength",        "",
"TestFieldFlowerWidth",         "",
"TestFieldNorthWall",           "",
"TestFieldEastWall",            "",
"TestFieldSouthWall",           "",
"TestFieldWestWall",            "",
"TestFieldNorthWallDistance",   "",
"TestFieldEastWallDistance",    "",
"TestFieldSouthWallDistance",   "",
"TestFieldWestWallDistance",    "",
"TestFieldGatherPattern",       "",
"TestFieldPatternLength",       "",
"TestFieldPatternWidth",        "",
"TestFieldGatherWithShiftLock", "0",
"TestFieldInvertFB",            "0",
"TestFieldInvertRL",            "0",
"TestFieldGatherTime",          "10",
"TestFieldBagPercent",          "95",
"TestFieldStartPositionLength", "",
"TestFieldStartPositionWidth",  "",
"TestFieldReturnMethod",        "Reset",
"TestFieldTurnCamera",          "",
"TestFieldTurnCameraNum",       ""
)