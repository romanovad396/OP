UNIT WordWorking;

INTERFACE

PROCEDURE ReadWord(VAR File: TEXT; VAR Word: STRING);
FUNCTION ConvertLowercase(Ch: CHAR): CHAR;
PROCEDURE AddHyphen(VAR Word: STRING);

CONST
  LatinLower = 'abcdefghijklmnopqrstuvwxyz';
  LatinUpper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  RussianLower = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя';
  RussianUpper = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';

IMPLEMENTATION

FUNCTION ConvertLowercase(Ch: CHAR): CHAR;
{Приводит символы латиницы и кириллицы к нижнему регистру, обрабатывает Ё, ё}
VAR
  CharPos: INTEGER;
BEGIN {ConvertLowercase} 
  CharPos := Pos(Ch, LatinUpper);
  IF CharPos > 0                                                                              
  THEN
    ConvertLowercase := LatinLower[CharPos]
  ELSE
    BEGIN
      CharPos := Pos(Ch, RussianUpper);
      IF CharPos > 0 
      THEN
        ConvertLowercase := RussianLower[CharPos]
      ELSE
        IF (Ch = 'Ё') OR (Ch = 'ё') 
        THEN
          ConvertLowercase := 'ё'
        ELSE
          ConvertLowercase := Ch
    END
END; {ConvertLowercase}

FUNCTION IsLetter(Ch: CHAR): BOOLEAN;
{Проверяет, является ли символ буквой латинского или русского алфавита в нижнем регистре}
VAR
  CharPos: INTEGER;
BEGIN {IsLetter} 
  CharPos := Pos(Ch, LatinLower);
  IF CharPos > 0 
  THEN
    IsLetter := TRUE
  ELSE
    BEGIN
      CharPos := Pos(Ch, RussianLower);
      IF CharPos > 0 
      THEN
        IsLetter := TRUE
      ELSE
        IsLetter := FALSE
    END
END; {IsLetter} 

PROCEDURE AddHyphen(VAR Word: STRING);
{Добавляет дефис в слово только если: слово уже началось (Length(Word) > 0) и предыдущий символ не дефис}
BEGIN {AddHyphen}
  IF (Length(Word) > 0) AND (Word[Length(Word)] <> '-') 
  THEN
    Word := Word + '-'
END; {AddHyphen}

PROCEDURE ReadWord(VAR File: TEXT; VAR Word: STRING);
{Читает слова из файла File, пропуская не буквенные символы до начала слова; 
пока встречаются буквы, добавляет их в Word и обрабатывает дефис}
VAR
  Ch: CHAR;
  InWord: BOOLEAN;
  LowerCh: CHAR;
BEGIN {ReadWord}
  Word := '';
  InWord := FALSE;
  {Пропускает символы до начала слова, в том числе и дефис, читает первый символ слова}
  WHILE (NOT EOF(File)) AND (NOT InWord) 
  DO
    BEGIN
      READ(File, Ch);
      LowerCh := ConvertLowercase(Ch);
      IF IsLetter(LowerCh) 
      THEN
        BEGIN
          Word := Word + LowerCh;
          InWord := TRUE
        END
    END;
  {Если не вошли в слово и EOF — возвращает пустую строку}
  IF NOT InWord 
  THEN
    Word := '';
  {Читает оставшуюся часть слова}
  WHILE (NOT EOF(File)) AND InWord 
  DO
    BEGIN
      READ(File, Ch);
      LowerCh := ConvertLowercase(Ch);
      IF IsLetter(LowerCh) 
      THEN
        Word := Word + LowerCh
      ELSE
        IF Ch = '-' 
        THEN
          AddHyphen(Word)
        ELSE
          InWord := FALSE
    END;
  {Если слово закончилось на дефис — убрать последний символ}
  IF (Length(Word) > 0) AND (Word[Length(Word)] = '-') 
  THEN
    SetLength(Word, Length(Word) - 1)
END; {ReadWord}

BEGIN {WordWorking}
END. {WordWorking}
