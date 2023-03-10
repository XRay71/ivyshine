Globals := Map()

Globals["Constants"] := Map()

Globals["Constants"]["ini FilePaths"] := Map(
"Constants", "lib\init\constants.ini",
"Variables", "lib\init\variables.ini",
"GUI", "lib\init\gui.ini",
"Settings", "lib\init\settings.ini",
"Fields", "lib\init\fields.ini",
"Field Defaults", "lib\init\fielddefaults.ini",
"Field Rotation", "lib\init\fieldrotation.ini",
"Boost", "lib\init\boost.ini",
"Boost Settings", "lib\init\boostsettings.ini"
)

Globals["Constants"]["Scan Codes"] := Map(
"Escape", "SC001",
"F1", "SC03B",
"F2", "SC03C",
"F3", "SC03D",
"F4", "SC03E",
"F5", "SC03F",
"F6", "SC040",
"F7", "SC041",
"F8", "SC042",
"F9", "SC043",
"F10", "SC044",
"F11", "SC057",
"F12", "SC058",
"PrtScr", "SC137",
"Insert", "SC152",
"Delete", "SC153",
"PgUp", "SC149",
"PgDn", "SC151",
"PgDn", "SC147",
"PgDn", "SC14F",
"Numlock", "SC145",
"Numpad/", "SC135",
"Numpad*", "SC037",
"Numpad+", "SC04E",
"NumpadEnter", "SC11C",
"Numpad1", "SC04F",
"Numpad2", "SC050",
"Numpad3", "SC051",
"Numpad4", "SC04B",
"Numpad5", "SC04C",
"Numpad6", "SC04D",
"Numpad7", "SC047",
"Numpad8", "SC048",
"Numpad9", "SC049",
"Numpad.", "SC053",
"``", "SC029",
"1", "SC002",
"2", "SC003",
"3", "SC004",
"4", "SC005",
"5", "SC006",
"6", "SC007",
"7", "SC008",
"8", "SC009",
"9", "SC00A",
"0", "SC00B",
"-", "SC00C",
"Equals", "SC00D",
"Backspace", "SC00E",
"Tab", "SC00F",
"q", "SC010",
"w", "SC011",
"e", "SC012",
"r", "SC013",
"t", "SC014",
"y", "SC015",
"u", "SC016",
"i", "SC017",
"o", "SC018",
"p", "SC019",
"\", "SC02B",
"LSquareBracket", "SC01A",
"]", "SC01B",
"CapsLock", "SC03A",
"a", "SC01E",
"s", "SC01F",
"d", "SC020",
"f", "SC021",
"g", "SC022",
"h", "SC023",
"j", "SC024",
"k", "SC025",
"l", "SC026",
";", "SC027",
"`'", "SC028",
"Enter", "SC01C",
"LShift", "SC02A",
"z", "SC02C",
"x", "SC02D",
"c", "SC02E",
"v", "SC02F",
"b", "SC030",
"n", "SC031",
"m", "SC032",
"," ,"SC033",
".", "SC034",
"/", "SC035",
"RShift", "SC136",
"LControl", "SC01D",
"WinKey", "SC15B",
"LAlt", "SC038",
"Space", "SC039",
"RAlt", "SC138",
"RControl", "SC11D",
"Left", "SC14B",
"Down", "SC150",
"Up", "SC148",
"Right", "SC14D"
)

Globals["Constants"]["Game Values"] := Map(
"Flower Length", "140",
"Base MoveSpeed", "28",
"Jump Duration", "800",
"Base Jump Power", "77"
)

Globals["Variables"] := Map()

Globals["Variables"]["Externals"] := Map(
"CurrentMovePID", "0",
"CurrentMoveName", ""
)

Globals["Variables"]["Keystates"] := Map(
"SC001", "0",
"SC03B", "0",
"SC03C", "0",
"SC03D", "0",
"SC03E", "0",
"SC03F", "0",
"SC040", "0",
"SC041", "0",
"SC042", "0",
"SC043", "0",
"SC044", "0",
"SC057", "0",
"SC058", "0",
"SC137", "0",
"SC152", "0",
"SC153", "0",
"SC149", "0",
"SC151", "0",
"SC147", "0",
"SC14F", "0",
"SC145", "0",
"SC135", "0",
"SC037", "0",
"SC04E", "0",
"SC11C", "0",
"SC04F", "0",
"SC050", "0",
"SC051", "0",
"SC04B", "0",
"SC04C", "0",
"SC04D", "0",
"SC047", "0",
"SC048", "0",
"SC049", "0",
"SC053", "0",
"SC029", "0",
"SC002", "0",
"SC003", "0",
"SC004", "0",
"SC005", "0",
"SC006", "0",
"SC007", "0",
"SC008", "0",
"SC009", "0",
"SC00A", "0",
"SC00B", "0",
"SC00C", "0",
"SC00D", "0",
"SC00E", "0",
"SC00F", "0",
"SC010", "0",
"SC011", "0",
"SC012", "0",
"SC013", "0",
"SC014", "0",
"SC015", "0",
"SC016", "0",
"SC017", "0",
"SC018", "0",
"SC019", "0",
"SC02B", "0",
"SC01A", "0",
"SC01B", "0",
"SC03A", "0",
"SC01E", "0",
"SC01F", "0",
"SC020", "0",
"SC021", "0",
"SC022", "0",
"SC023", "0",
"SC024", "0",
"SC025", "0",
"SC026", "0",
"SC027", "0",
"SC028", "0",
"SC01C", "0",
"SC02A", "0",
"SC02C", "0",
"SC02D", "0",
"SC02E", "0",
"SC02F", "0",
"SC030", "0",
"SC031", "0",
"SC032", "0",
"SC033", "0",
"SC034", "0",
"SC035", "0",
"SC136", "0",
"SC01D", "0",
"SC15B", "0",
"SC038", "0",
"SC039", "0",
"SC138", "0",
"SC11D", "0",
"SC14B", "0",
"SC150", "0",
"SC148", "0",
"SC14D", "0",
"LButton", "0"
)

Globals["GUI"] := Map()

Globals["GUI"]["Position"] := Map(
"GUIX", "5",
"GUIY", "5"
)

Globals["GUI"]["Settings"] := Map(
"CurrentGUITab", "Settings"
)

Globals["Settings"] := Map()

Globals["Settings"]["AntiAFK"] := Map(
"RunAntiAFK", "0",
"AntiAFKInterval", "10",
"LastRun", CurrentTime()
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
"HasGiftedVicious", "1",
"AutoEquip", "Default"
)

Globals["Settings"]["Hotkeys"] := Map(
"StartHotkey", "F1",
"PauseHotkey", "F2",
"StopHotkey", "F3",
"AutoclickerHotkey", "F4",
"TrayHotkey", "F5",
"DebugHotkey", "^F2",
"SuspendHotkey", "^F3"
)

Globals["Settings"]["GUI"] := Map(
"AlwaysOnTop", "0",
"Transparency", "0",
)

Globals["Settings"]["Convert Settings"] := Map(
"ConvertDelay", "1",
"BalloonConvertSetting", "Auto",
"BalloonConvertInterval", "30",
)

Globals["Settings"]["Miscellaneous"] := Map(
"MoveSpeedCorrection", "1",
"ShiftlockMoving", "1",
"ResetMultiplier", "1",
"AdditionalKeyDelay", "0"
)

Globals["Settings"]["rbxfpsunlocker"] := Map(
"Runrbxfpsunlocker", "0",
"FPS", "30",
"rbxfpsunlockerDirectory", ""
)

Globals["Settings"]["Reconnect"] := Map(
"ReconnectInterval", "",
"ReconnectStartHour", "",
"ReconnectStartMinute", ""
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

Globals["Fields"]["Settings"] := Map(
"CurrentlySelectedField",1
)

Globals["Field Rotation"] := Map()

Globals["Field Rotation"]["1"] := Map(
"FieldName", "Pine Tree",
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Defaults"] := Map()

Globals["Field Defaults"]["Bamboo"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Defaults"]["Blue Flower"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Defaults"]["Cactus"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Mixed"
)

Globals["Field Defaults"]["Clover"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "Right",
"TurnCameraNum", "4",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Mixed"
)

Globals["Field Defaults"]["Coconut"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "Right",
"TurnCameraNum", "4",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Defaults"]["Dandelion"] := Map(
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

Globals["Field Defaults"]["Mountain Top"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Mixed"
)

Globals["Field Defaults"]["Mushroom"] := Map(
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

Globals["Field Defaults"]["Pepper"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Red"
)

Globals["Field Defaults"]["Pine Tree"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "Left",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Defaults"]["Pineapple"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Defaults"]["Pumpkin"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Defaults"]["Rose"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Red"
)

Globals["Field Defaults"]["Spider"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "White"
)

Globals["Field Defaults"]["Strawberry"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "None",
"TurnCameraNum", "0",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Red"
)

Globals["Field Defaults"]["Stump"] := Map(
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
"MoveMethod", "Cannon Fly",
"DefaultMoveMethod", "Cannon Fly",
"ReturnMethod", "Reset",
"TurnCamera", "Right",
"TurnCameraNum", "2",
"RepeatTimes", "1",
"AutoEquip", "1",
"Type", "Blue"
)

Globals["Field Defaults"]["Sunflower"] := Map(
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
"CurrentlySelectedBoost", "Sprinkler"
)

Globals["Boost"]["Hotbar"] := Map(
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

Globals["Boost Settings"]["Sprinkler"] := Map(
"Sprinkler1X","",
"Sprinkler1Y","",
"Sprinkler2X","",
"Sprinkler2Y","",
"Sprinkler3X","",
"Sprinkler3Y","",
"Sprinkler4X","",
"Sprinkler4Y",""
)

