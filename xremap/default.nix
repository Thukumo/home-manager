{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xremap
    wtype
  ];
  imports = [
    ./config.nix
  ];
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
