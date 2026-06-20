lib: ini: let
  lines = lib.strings.splitString "\n" ini;

  parseLine = line:
    let
      trimmedLine = lib.trim line;
    in
      if builtins.stringLength trimmedLine == 0
      then { type = "empty"; }
      else if lib.hasPrefix "#" trimmedLine
      then { type = "comment"; }
      else if lib.hasPrefix "[" trimmedLine
      then if lib.hasPrefix "[" (lib.removePrefix "[" trimmedLine)
           then {
             type = "subsection";
             name = lib.pipe trimmedLine [(lib.removePrefix "[[") (lib.removeSuffix "]]")];
           }
           else
             {
               type = "section";
               name = lib.pipe trimmedLine [(lib.removePrefix "[") (lib.removeSuffix "]")];
             }
      else let
        parts = lib.splitString "=" trimmedLine;
        key = lib.removeSuffix " " (lib.elemAt parts 0);
        litVal = lib.removePrefix " " (lib.elemAt parts 1);
      in {
        type = "property";
        inherit key;
        val = lib.pipe litVal [(lib.removePrefix "'") (lib.removeSuffix "'")];
      }
  ;

  parsedLines = map parseLine lines;
  
  foldState = acc: line:
    if line.type == "empty"
    then acc
    else if line.type == "comment"
    then acc
    else if line.type == "section"
    then acc // { ${line.name} = {}; currentSection = {name = line.name; currentSubsection = { name = {};};}; }
    else if line.type == "subsection"
    then acc // lib.traceValSeq { ${acc.currentSection.name}.${line.name} = {}; currentSection = {name = acc.currentSection.name; currentSubsection = {name = line.name;};};}
    else if line.type == "property"
    then lib.updateManyAttrsByPath
      [{
        path = lib.traceValSeq (lib.flatten [
          "val"
          (lib.optional (builtins.isString acc.currentSection.name) acc.currentSection.name)
          (lib.optional (builtins.isString acc.currentSection.currentSubsection.name) acc.currentSection.currentSubsection.name)
          line.key
        ]) ;
        update = _: line.val;
      }]
      acc
    else throw "no such type ${line.type}"
  ;
  
  endState = lib.foldl foldState { val = {}; currentSection = null; } parsedLines;

in
  endState.val
