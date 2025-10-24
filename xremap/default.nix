{ config, pkgs, ... }:

{
  home.packages = [pkgs.xremap];
  xdg.configFile."xremap/config.yml".source = ./config.yml;
  systemd.user.services.xremap = {
    Unit = {
      Description = "xremap auto start";
    };
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.xremap}/bin/xremap ${config.home.homeDirectory}/.config/xremap/config.yml";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
