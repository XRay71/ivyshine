Globals := Map()

Globals["Constants"] := Map()

Globals["Constants"]["ini FilePaths"] := Map(
"Constants", "lib\init\constants.ini",
"GUI", "lib\init\gui.ini",
"Settings", "lib\init\settings.ini",
"Fields", "lib\init\fields.ini",
"Field Settings", "lib\init\fieldsettings.ini",
"Boost", "lib\init\boost.ini",
"Boost Settings", "lib\init\boostsettings.ini"
)

Globals["GUI"] := Map()

Globals["GUI"]["Position"] := Map(
"GUIX", "0",
"GUIY", "350"
)

Globals["GUI"]["Settings"] := Map(
"AlwaysOnTop", "0",
"Transparency", "0",
"CurrentGUITab", "1"
)

Globals["Settings"] := Map()

Globals["Settings"]["AntiAFK"] := Map(
"RunAntiAFK", "0",
"AntiAFKInterval", "10",
"LastRun", A_NowUTC
)

Globals["Settings"]["Autoclicker"] := Map(
"ClickAmount", "0",
"ClickInterval", "10",
"ClickCounter", "0"
)

Globals["Settings"]["Basic Settings"] := Map(
"MoveSpeed", "28",
"MoveMethod", "Default",
"NumberOfSprinklers", "1",
"HiveSlotNumber", "1",
"PrivateServerLink", ""
)

Globals["Settings"]["Collect/Kill"] := Map(
"AutoEquip", "Default",
"HasGiftedVicious", "1"
)

Globals["Settings"]["Hotkeys"] := Map(
"StartHotkey", "F1",
"PauseHotkey", "F2",
"StopHotkey", "F3",
"AutoclickerHotkey", "F4"
)

Globals["Settings"]["Keybinds"] := Map(
"ForwardKey", "w",
"BackwardKey", "s",
"LeftKey", "a",
"RightKey", "d",
"CameraRightKey", ".",
"CameraLeftKey", ",",
"CameraInKey", "i",
"CameraOutKey", "o",
"CameraUpKey", "PgDn",
"CameraDownKey", "PgUp",
"ResetKey", "r",
"ChatKey", "/",
"AdditionalKeyDelay", "0"
)

Globals["Settings"]["Miscellaneous"] := Map(
"MoveSpeedCorrection", "1",
"ShiftlockMoving", "1",
"BalloonConvertSetting", "Auto",
"BalloonConvertInterval", "30",
"ResetMultiplier", "1",
"ReconnectInterval", "",
"ReconnectStartHour", "",
"ReconnectStartMinute", ""
)

Globals["Settings"]["rbxfpsunlocker"] := Map(
"Runrbxfpsunlocker", "0",
"rbxfpsunlockerDirectory", "",
"FPS", "30"
)

Globals["Settings"]["Unlocks"] := Map(
"HasRedCannon", "1",
"HasParachute", "1",
"HasGlider", "1",
"HasDiamondMask", "1",
"HasDemonMask", "1",
"HasGummyMask", "1",
"HasPetalWand", "1",
"HasTidePopper", "0",
"HasDarkScythe", "0",
"HasGummyballer", "0",
"NumberOfBees", "50"
)

Globals["Fields"] := Map()

Globals["Fields"]["Field Rotation"] := Map(
"FieldRotationList", "Pine Tree|",
"CurrentlySelectedField", "Pine Tree",
"NonFieldRotationList", "Bamboo|Blue Flower|Cactus|Clover|Coconut|Dandelion|Mountain Top|Mushroom|Pepper|Pineapple|Pumpkin|Rose|Spider|Strawberry|Stump|Sunflower|"
)

Globals["Field Settings"] := Map()

Globals["Field Settings"]["Bamboo"] := Map(
"SettingsModified", "",
"FlowerLength", "18",
"FlowerWidth", "39",
"NorthWall", "1",
"EastWall", "1",
"SouthWall", "1",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "1",
"SouthWallDistance", "1",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "5",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "12",
"StartPositionWidth", "20",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Settings"]["BlueFlower"] := Map(
"SettingsModified", "",
"FlowerLength", "17",
"FlowerWidth", "43",
"NorthWall", "1",
"EastWall", "0",
"SouthWall", "1",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "5",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "8",
"StartPositionWidth", "23",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Settings"]["Cactus"] := Map(
"SettingsModified", "",
"FlowerLength", "18",
"FlowerWidth", "33",
"NorthWall", "0",
"EastWall", "1",
"SouthWall", "0",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "2",
"PatternWidth", "5",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "10",
"StartPositionWidth", "17",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Mixed"
)

Globals["Field Settings"]["Clover"] := Map(
"SettingsModified", "",
"FlowerLength", "27",
"FlowerWidth", "39",
"NorthWall", "0",
"EastWall", "0",
"SouthWall", "1",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "12",
"StartPositionWidth", "20",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "Right",
"TurnCameraNum", "4",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Mixed"
)

Globals["Field Settings"]["Coconut"] := Map(
"SettingsModified", "",
"FlowerLength", "21",
"FlowerWidth", "30",
"NorthWall", "0",
"EastWall", "1",
"SouthWall", "1",
"WestWall", "1",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "6",
"StartPositionWidth", "10",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "Right",
"TurnCameraNum", "4",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Settings"]["Dandelion"] := Map(
"SettingsModified", "",
"FlowerLength", "18",
"FlowerWidth", "36",
"NorthWall", "0",
"EastWall", "1",
"SouthWall", "0",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "2",
"PatternWidth", "5",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "9",
"StartPositionWidth", "20",
"MoveMethod", "Walk",
"DefaultMoveMethod", "Walk",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Settings"]["MountainTop"] := Map(
"SettingsModified", "",
"FlowerLength", "28",
"FlowerWidth", "24",
"NorthWall", "1",
"EastWall", "0",
"SouthWall", "1",
"WestWall", "1",
"NorthWallDistance", "7",
"EastWallDistance", "0",
"SouthWallDistance", "1",
"WestWallDistance", "4",
"GatherPattern", "",
"PatternLength", "2",
"PatternWidth", "2",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "13",
"StartPositionWidth", "13",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Mixed"
)

Globals["Field Settings"]["Mushroom"] := Map(
"SettingsModified", "",
"FlowerLength", "23",
"FlowerWidth", "32",
"NorthWall", "1",
"EastWall", "1",
"SouthWall", "0",
"WestWall", "1",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "18",
"StartPositionWidth", "16",
"MoveMethod", "Walk",
"DefaultMoveMethod", "Walk",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Red"
)

Globals["Field Settings"]["Pepper"] := Map(
"SettingsModified", "",
"FlowerLength", "27",
"FlowerWidth", "21",
"NorthWall", "1",
"EastWall", "0",
"SouthWall", "1",
"WestWall", "1",
"NorthWallDistance", "",
"EastWallDistance", "6",
"SouthWallDistance", "6",
"WestWallDistance", "3",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "14",
"StartPositionWidth", "12",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Red"
)

Globals["Field Settings"]["PineTree"] := Map(
"SettingsModified", "",
"FlowerLength", "31",
"FlowerWidth", "23",
"NorthWall", "1",
"EastWall", "0",
"SouthWall", "0",
"WestWall", "1",
"NorthWallDistance", "1",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "17",
"StartPositionWidth", "10",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Settings"]["Pineapple"] := Map(
"SettingsModified", "",
"FlowerLength", "23",
"FlowerWidth", "35",
"NorthWall", "1",
"EastWall", "1",
"SouthWall", "0",
"WestWall", "1",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "14",
"StartPositionWidth", "14",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Settings"]["Pumpkin"] := Map(
"SettingsModified", "",
"FlowerLength", "17",
"FlowerWidth", "33",
"NorthWall", "1",
"EastWall", "1",
"SouthWall", "0",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "2",
"PatternWidth", "5",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "10",
"StartPositionWidth", "17",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Settings"]["Rose"] := Map(
"SettingsModified", "",
"FlowerLength", "20",
"FlowerWidth", "31",
"NorthWall", "1",
"EastWall", "1",
"SouthWall", "1",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "2",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "17",
"StartPositionWidth", "25",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Red"
)

Globals["Field Settings"]["Spider"] := Map(
"SettingsModified", "",
"FlowerLength", "25",
"FlowerWidth", "28",
"NorthWall", "1",
"EastWall", "0",
"SouthWall", "0",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "20",
"StartPositionWidth", "14",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Settings"]["Strawberry"] := Map(
"SettingsModified", "",
"FlowerLength", "26",
"FlowerWidth", "22",
"NorthWall", "1",
"EastWall", "0",
"SouthWall", "1",
"WestWall", "1",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "2",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "3",
"PatternWidth", "3",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "20",
"StartPositionWidth", "10",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Red"
)

Globals["Field Settings"]["Stump"] := Map(
"SettingsModified", "",
"FlowerLength", "27",
"FlowerWidth", "25",
"NorthWall", "0",
"EastWall", "1",
"SouthWall", "0",
"WestWall", "0",
"NorthWallDistance", "0",
"EastWallDistance", "6",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "2",
"PatternWidth", "2",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "14",
"StartPositionWidth", "13",
"MoveMethod", "Glider",
"DefaultMoveMethod", "Glider",
"ReturnMethod", "Reset",
"TurnCamera", "Right",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Settings"]["Sunflower"] := Map(
"SettingsModified", "",
"FlowerLength", "33",
"FlowerWidth", "20",
"NorthWall", "0",
"EastWall", "0",
"SouthWall", "0",
"WestWall", "1",
"NorthWallDistance", "0",
"EastWallDistance", "0",
"SouthWallDistance", "0",
"WestWallDistance", "0",
"GatherPattern", "",
"PatternLength", "5",
"PatternWidth", "2",
"GatherWithShiftLock", "0",
"InvertFB", "0",
"InvertRL", "0",
"GatherTime", "10",
"BagPercent", "95",
"StartPositionLength", "17",
"StartPositionWidth", "5",
"MoveMethod", "Walk",
"DefaultMoveMethod", "Walk",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Boost"] := Map()

Globals["Boost"]["Boost Rotation"] := Map(
"BoostRotationList", "Sprinkler|",
"CurrentlySelectedBoost", "Sprinkler",
"NonBoostRotationList", "Gumdrops|Coconut|Stinger|Microconvertor|Honeysuckle|Whirligig|Field Dice|Jellybeans|Red Extract|Blue Extract|Glitter|Glue|Oil|Enzymes|Tropical Drink|"
)

Globals["Boost"]["Hotbar"] := Map(
"HotbarList", "None|",
"HotbarSlot1", "Sprinkler",
"HotbarSlot2", "",
"HotbarSlot3", "",
"HotbarSlot4", "",
"HotbarSlot5", "",
"HotbarSlot6", "",
"HotbarSlot7", "",
"HotbarSlot1Auto", "2",
"HotbarSlot2Auto", "2",
"HotbarSlot3Auto", "2",
"HotbarSlot4Auto", "2",
"HotbarSlot5Auto", "2",
"HotbarSlot6Auto", "2",
"HotbarSlot7Auto", "2"
)

Globals["Boost Settings"] := Map()

