{ lib, ... }:

{
  xdg.configFile."xremap/config.yml".text = (import ./gen_yaml.nix {inherit lib;}) {
    virtual_modifiers = ["Ctrl_R" "PROG1"];
    modmap = [
      {
        name = "Global";
        remap = {
          Shift_L = {
            alone = "GRAVE";
            held = "Shift_L";
            free_hold = true;
          };
          CapsLock = {
            alone = "Esc";
            held = "LEFTMETA";
            free_hold = true;
          };
          Space = {
            alone = "Space";
            held = "PROG1";
            free_hold = true;
          };
          GRAVE = "ALT_L";
          Shift_R = "LEFTMETA";
          Muhenkan = "Home";
          Henkan = "End";
          KatakanaHiragana = "End";
        };
      }
    ];
    keymap = [
      {
        name = "power";
        exact_match = true;
        remap = {
          Ctrl_L-Alt-Shift-P = "POWER";
          Ctrl_L-Alt-Shift-R = "RESTART";
        };
      }
      {
        name = "arrow";
        remap = {
          PROG1-H = "left";
          PROG1-J = "down";
          PROG1-K = "up";
          PROG1-L = "right";
        };
      }
      {
        name = "Chromium";
        application = {
          only = "chromium";
        };
        remap = {
          left = "Ctrl-PageUp";
          right = "Ctrl-PageDown";
          up = "Alt-left";
          down = "Alt-right";
        };
      }
      {
        name = "digicre";
        remap = (builtins.listToAttrs 
          (lib.lists.flatten 
            (builtins.attrValues 
              (builtins.mapAttrs (
                name: value: (lib.lists.imap0 (
                  i: val: [
                    {
                      name = "Ctrl_R-${if i == 0 then "" else "Shift-"}${name}";
                      value = {
                        launch = ["fish" "-c" "wtype ${val}"];
                      };
                    }
                    {
                      name = "Ctrl_R-Alt-${if i == 0 then "" else "Shift-"}${name}";
                      value = {
                        launch = ["fish" "-c" "wtype :${val}:"];
                      };
                    }
                  ]
                ) value)
              ) (builtins.groupBy (builtins.substring 0 1) [
                  "inu_downer"
                  "good_story"
                  "kawaiine"
                  "ohayo"
                  "digicre"
                  "kusa"
                  "soukamo"
                  "soukana"
                  "thonk"
                  "mattermost"
                  "yosasou"
                ])
              )
            )
          )
        ) // {
            Ctrl_R-b = {
              launch = ["fish" "-c" "wtype cat_beluga"];
            };
            Ctrl_R-Alt-b = {
              launch = ["fish" "-c" "wtype :cat_beluga:"];
            };
          };
      }
    ];
  };
}
