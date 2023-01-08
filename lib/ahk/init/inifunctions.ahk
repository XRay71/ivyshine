CreateIni(FilePath, Data) {
    For Header, Pair in Data
    {
        For Key, Value in Pair
        {
            Try
            IniWrite(Value, FilePath, Header, Key)
            Catch Any
                UnableToCreateFileError()
        }
    }
    Return 1
}

UpdateIni(FilePath, Data) {
    For Header, Pair in Data
    {
        For Key, Value in Pair
        {
            Try
            IniWrite(Data[Header][Key], FilePath, Header, Key)
            Catch Any
                UnableToCreateFileError()
        }
    }
    Return 1
}

ReadIni(FilePath, Data) {
    For Header, Pair in Data
    {
        For Key, Value in Pair
        {
            Try
            Data[Header][Key] := IniRead(FilePath, Header, Key)
            Catch Any
                MissingFilesError()
        }
    }
    Return 1
}