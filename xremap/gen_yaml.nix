{ lib, input }:
let
  yaml_generator = count: wasList: data:
    let
      s = if builtins.isString data then "\"${data}\""
      else
        if builtins.isBool data then
          if data then "true"
          else "false"
        else
          if builtins.isNull data then "null"
          else
            if builtins.isList data then
              lib.concatStringsSep "\n" (builtins.map (x: "${lib.strings.replicate count "  "}- ${x}") (builtins.map (yaml_generator (count + 1) true) data))
            else
              if builtins.isAttrs data then
                lib.strings.concatMapAttrsStringSep "\n" (name: value: "${lib.strings.replicate count "   "}${name}: ${yaml_generator (count + 1) false value}") data
              else builtins.toString data;
    in if 0 == count || !(builtins.isAttrs data) && !(builtins.isList data) then s else if wasList && builtins.isAttrs data then lib.strings.trimWith {start = true;} s else "\n" + s;
in yaml_generator 0 false input
