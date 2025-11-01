{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xremap
    wtype
  ];
  xdg.configFile."xremap/config.yml".source = ./config.yml;
  systemd.user.services.xremap = {
    Unit = {
      Description = "xremap auto start";
    };
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.xremap}/bin/xremap --watch ${config.home.homeDirectory}/.config/xremap/config.yml";
      X-ReloadTriggers = [
        (builtins.hashFile "sha256" ./config.yml)
      ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
