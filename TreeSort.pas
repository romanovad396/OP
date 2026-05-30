UNIT TreeSort;

USES StringsWorking;

INTERFACE

TYPE
  Tree = ^Node;
  Node = RECORD
           Word: STRING;
           Count: INTEGER;
           Left, Right: Tree
         END;
         
PROCEDURE AddWord(Word: STRING);
PROCEDURE CallWriteWordSorted(VAR OutFile: TEXT);

IMPLEMENTATION

VAR
  Root: Tree;

PROCEDURE AddWordToNode(VAR Root: Tree; Word: STRING);
{Встаавляет слово в узел дерева}
BEGIN {AddWordToNode}
  IF Root = NIL 
  THEN
    BEGIN
      NEW(Root);
      Root^.Word := Word;
      Root^.Count := 1;
      Root^.Left := NIL;
      Root^.Right := NIL
    END
  ELSE
    IF Word = Root^.Word 
    THEN
      Root^.Count := Root^.Count + 1
    ELSE
      {Если новое слово меньше текущего, идёт влево, иначе вправо}
      IF StringLess(Word, Root^.Word) 
      THEN
        AddWordToNode(Root^.Left, Word)
      ELSE
        AddWordToNode(Root^.Right, Word)
END; {AddWordToNode}


PROCEDURE AddWord(Word: STRING);
{Вызывает процедуру AddWordToNode}
BEGIN {AddWord}
  AddWordToNode(Root, Word)
END; {AddWord}

PROCEDURE WriteWordSorted(VAR OutFile: TEXT; Root: Tree);
BEGIN {WriteWordSorted}
  IF Root <> NIL 
  THEN
    BEGIN
      WriteWordSorted(OutFile, Root^.Left);
      WRITELN(OutFile, Root^.Word, ' ', Root^.Count);
      WriteWordSorted(OutFile, Root^.Right)
    END
END; {WriteWordSorted}

PROCEDURE CallWriteWordSorted(VAR OutFile: TEXT);
{Вызывает процедуру WriteWordSorted}
BEGIN {CallWriteWordSorted}
  WriteWordSorted(OutFile, Root)
END; {CallWriteWordSorted}

BEGIN {TreeSort}
  Root := NIL
END. {TreeSort}
