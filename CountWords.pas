PROGRAM CountWords(INPUT, OUTPUT);

USES TextWorking;

VAR
  InFile, OutFile: TEXT;

BEGIN {CountWords}
  ASSIGN(InFile, 'voina-i-mir.txt');
  RESET(InFile);
  ASSIGN(OutFile, 'SortedWords.txt');
  REWRITE(OutFile);
  CallTextWorking(InFile, OutFile)
END. {CountWords}
