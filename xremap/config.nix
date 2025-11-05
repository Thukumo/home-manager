{ lib, pkgs, ... }:

{
  xdg.configFile."xremap/config.yml".source = (pkgs.formats.yaml {}).generate "xremap-config.yml" {
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
          Ctrl-Alt-Shift-P = "POWER";
          Ctrl-Alt-Shift-R = "RESTART";
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
        name = "launch";
        exact_match = true;
        remap = builtins.mapAttrs
          (_: builtins.mapAttrs
            (_: x: ["fish" "-c" x])
          )
          {
            Win-C = {
              launch = "chromium --incognito";
            };
            Win-Shift-C = {
              launch = "google-chrome-stable";
            };
            Win-M = {
              launch = "mattermost-desktop";
            };
            Win-X = {
              launch = "chromium https://x.com/home";
            };
            Win-Shift-X = {
              launch = "google-chrome-stable https://x.com/home";
            };
          };
      }
      {
        name = "Chromium";
        application = {
          only = [
            "chromium"
            "google-chrome"
          ];
        };
        remap = {
          up = "Ctrl-PageDown";
          down = "Ctrl-PageUp";
          right = "Alt-right";
          left = "Alt-left";
        };
      }
      {
        name = "digicre";
        remap = (builtins.listToAttrs
          (lib.lists.flatten
            (builtins.attrValues
              (builtins.mapAttrs (
                name: (lib.zipListsWith (
                  shift: val: [
                    {
                      name = "Ctrl_R-${shift}${name}";
                      value = {
                        launch = ["fish" "-c" "wtype ${val}"];
                      };
                    }
                    {
                      name = "Ctrl_R-Alt-${shift}${name}";
                      value = {
                        launch = ["fish" "-c" "wtype :${val}:"];
                      };
                    }

                  ]
                ) ["" "Shift-"])
              ) (builtins.groupBy (builtins.substring 0 1) [
                  "digicre"
                  "good_story"
                  "inu_downer"
                  "kawaiine"
                  "kusa"
                  "ohayo"
                  "mattermost"
                  "soukamo"
                  "soukana"
                  "thonk"
                  "tadashii"
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
