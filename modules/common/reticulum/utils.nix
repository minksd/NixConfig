lib: rec {
  addLine = newLine: original: (lib.concatStringsSep "\n" [original newLine]);
  boolToString = bool: if bool then "yes" else "no";

    retFold = acc: keyval: let
      type = builtins.typeOf keyval.value;
    in
      if type == "string" || type == "path"
      then (addLine "${keyval.name} = ${lib.toString keyval.value}" acc)
      else if type == "bool"
      then (addLine "${keyval.name} = ${boolToString keyval.value}" acc)
      else if type == "int"
      then (addLine "${keyval.name} = ${lib.toString keyval.value}" acc)
      else throw "The provided value ${keyval.value} for key ${keyval.name} was not correct";

    loggingFold = acc: keyval: let
      type = builtins.typeOf keyval.value;
    in
      if type == "int"
      then (addLine "${keyval.name} = ${lib.toString keyval.value}" acc)
      else throw "The provided value for key ${keyval.name} was not correct";

    interfacesFoldHelper = acc: keyval: let
      type = builtins.typeOf keyval.value;
    in
      if keyval == {} then acc else
        if type == "string"
        then (addLine "${keyval.name} = ${keyval.value}" acc)
        else if type == "bool"
        then (addLine "${keyval.name} = ${boolToString keyval.value}" acc)
        else if type == "list"
        then (addLine "${keyval.name} = ${lib.concatStringsSep "," keyval.value}" acc)
        else throw "The provided value ${keyval.value} for key ${keyval.name} was not correct";
    
    interfacesFold = acc: submodule: let
      name = submodule.name;
      enabled = submodule.enabled;
      type = submodule.type;
      additionalSettings = submodule.additionalSettings;
    in
      lib.foldl interfacesFoldHelper (lib.pipe acc [(addLine "[[${name}]]")(addLine "type = ${type}")(addLine "enabled = ${(boolToString enabled)}")]) (lib.attrsToList additionalSettings);
}
