{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    xremap
    wtype
  ];
  xdg.configFile."xremap/config.yml".text = (import ./gen_yaml.nix { 
    lib = lib; 
    input = {
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
      ];
    };
  });
  systemd.user.services.xremap = {
    Unit = {
      Description = "xremap auto start";
    };
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.xremap}/bin/xremap --watch ${config.home.homeDirectory}/.config/xremap/config.yml";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
