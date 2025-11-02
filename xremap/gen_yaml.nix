{ lib, input }: 
let
  yaml_generator = count: old_data: data:
    let
      s1 = if builtins.isString data then "\"${data}\""
      else
        if builtins.isBool data then
        if data then "true"
        else "false"
      else
        if builtins.isNull data then "null"
      else
        if builtins.isList data then 
        lib.concatStrings (builtins.map (x: "${lib.strings.replicate count "  "}- ${x}") (builtins.map (yaml_generator (count + 1) data) data))
      else
        if builtins.isAttrs data then 
        lib.concatStrings (map (att: att.value) (lib.attrsets.attrsToList (builtins.mapAttrs (name: value: "${lib.strings.replicate count "  "}${name}: ${yaml_generator (count + 1) data value}") data)))
      else builtins.toString data;
      s = if builtins.isList data || builtins.isAttrs data then s1 else s1 + "\n";
    in if 0 == count || !(builtins.isAttrs data) && !(builtins.isList data) then s else if builtins.isList old_data && builtins.isAttrs data then lib.strings.trimWith {start = true;} s else "\n" + s;
in yaml_generator 0 "gomi" input

