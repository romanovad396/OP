UNIT StringsWorking;

USES WordWorking; 

INTERFACE

FUNCTION EncodeChar(Ch: CHAR): INTEGER;
FUNCTION StringLess(String1, String2: STRING): BOOLEAN;

IMPLEMENTATION

CONST
  BigOfSet = 1000; 
  {Смещение для русских слов, чтобы они шли после латиницы}

FUNCTION EncodeChar(Ch: CHAR): INTEGER;
{Возвращает индекс символа: латиница 1..26, русские BigOfSet+1..BigOfSet+33, остальные символы возвращают 0}
VAR
  LowerCh: CHAR;
  CharPos: INTEGER;
BEGIN {EncodeChar}
  LowerCh := ConvertLowercase(Ch); 
  {Использует ConvertLowercase из модуля WordWorking}
  CharPos := Pos(LowerCh, LatinLower);
  IF CharPos > 0 
  THEN
    EncodeChar := CharPos
  ELSE
    BEGIN
      CharPos := Pos(LowerCh, RussianLower);
      IF CharPos > 0 
      THEN
        EncodeChar := BigOfSet + CharPos
      ELSE
        EncodeChar := 0
    END
END; {EncodeChar}

FUNCTION StringLess(String1, String2: STRING): BOOLEAN;
{Простое лексикографическое сравнение слов по индексам символов}
VAR
  I, MinLength, CharCode1, CharCode2: INTEGER;
BEGIN {StringLess}
  MinLength := Length(String1);
  IF Length(String2) < MinLength 
  THEN 
    MinLength := Length(String2);
  I := 1;
  WHILE I <= MinLength 
  DO
    BEGIN
      IF String1[I] <> String2[I] 
      THEN
        BEGIN
          CharCode1 := EncodeChar(String1[I]);
          CharCode2 := EncodeChar(String2[I]);
          IF CharCode1 < CharCode2 
          THEN
              StringLess := TRUE
          ELSE
              StringLess := FALSE
        END;
      I := I + 1
    END;
  {Если все символы в общей части совпали, короче слово, которое меньше}
  IF Length(String1) < Length(String2)
  THEN
    StringLess := TRUE
  ELSE
    StringLess := FALSE
END; {StringLess}

BEGIN {StringsWorking}
END. {StringsWorking}
