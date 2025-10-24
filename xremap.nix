{ pkgs, ... }:

{
  home.packages = [pkgs.xremap];
  services.xremap = {
    enable = true;
    config = {
      modmap = [
        {
          name = "Global";
          remap = {
            Shift_L = {
              alone_timeout_millis = 150;
              alone = "GRAVE";
              held = "Shift_L";
            };
            CTRL_R = "ESC";
            GRAVE = "ESC";
            CapsLock = "LEFTMETA";
            Shift_R = "LEFTMETA";
            Muhenkan = "Home";
            Henkan = "End";
            KatakanaHiragana = "End";
          };
        }
      ];
    }
  };
}
