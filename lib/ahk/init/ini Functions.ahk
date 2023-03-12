UpdateIni(FilePath, Data) {
    Content := ""
    For Header, Pair in Data
    {
        Content .= "[" Header "]`r`n"
        For Key, Value in Pair
            Content .= Key "=" Value "`r`n"
        Content .= "`r`n"
    }
    Try {
        If (FileExist(FilePath))
            FileDelete(FilePath)
        FileAppend(Content, FilePath)
    } Catch Any
        UnableToCreateFileError()
}

ReadIni(FilePath, Data) {
    Content := FileRead(FilePath)
    SectionName := ""
    Loop Parse Content, "`r`n", A_Space A_Tab
    {
        Switch (Substr(A_LoopField, 1, 1))
        {
        Case "[":
            SectionName := Substr(A_LoopField, 2, StrLen(A_LoopField) - 2)
            Try
            Data[SectionName]
            Catch Any
                Data[SectionName] := Map()
        
        Default:
            If (EqualsIndex := InStr(A_LoopField, "="))
                Data[SectionName][SubStr(A_LoopField, 1, EqualsIndex - 1)] := SubStr(A_LoopField, EqualsIndex + 1)
        }
    }
    
    UpdateIni(FilePath, Data)
}

InitialiseIni(ini) {
    If (FileExist(Globals["Constants"]["ini FilePaths"][ini])) ; if the file already exists, read from it
        ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
    Else ; otherwise create it
        UpdateIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini])
    
    ReadIni(Globals["Constants"]["ini FilePaths"][ini], Globals[ini]) ; read it once more for good measure
}