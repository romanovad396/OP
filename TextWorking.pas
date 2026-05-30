UNIT TextWorking;

USES WordWorking, TreeSort;
                                               
INTERFACE
              
PROCEDURE CallTextWorking(VAR InFile: TEXT; VAR OutFile: TEXT);

IMPLEMENTATION

PROCEDURE CallTextWorking(VAR InFile: TEXT; VAR OutFile: TEXT);
CONST
  MaxWords = 200;
VAR
  Word: STRING;
  Processed: INTEGER; 
BEGIN {CallTextWorking}  
  Processed := 0;
  WHILE (NOT EOF(InFile)) AND (Processed < MaxWords) 
  DO
    BEGIN
      ReadWord(InFile, Word);
      IF Word <> '' 
      THEN
        BEGIN
          AddWord(Word);
          Processed := Processed + 1
        END
    END;
  {Записываем отсортированные слова и их количество в выходной файл}
  CallWriteWordSorted(OutFile);
  IF Processed >= MaxWords 
  THEN
    WRITELN('Обработано ', Processed, ' слов — достигнут лимит ', MaxWords, '.', ' В тексте могут быть ещё слова.')
  ELSE
    WRITELN('Обработано слов: ', Processed)
END; {CallTextWorking}

BEGIN {TextWorking}
END. {TextWorking}
