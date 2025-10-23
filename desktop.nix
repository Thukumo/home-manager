{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    webcord
    xfce.thunar
  ];
  # Mattermost Desktopが$(config.home.homeDirectory)/autostart/electron.desktopを作ってきて困るので、
  # 先に/dev/nullへのシンボリックリンクにしておく
  xdg.configFile."autostart/electron.desktop".source = config.lib.file.mkOutOfStoreSymlink /dev/null;
  home.file = {
  };
  
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        use-bold = true;
      };
    };
  };
  services.mako = {
    enable = true;
    settings = {
      ignore-timeout = true;
      default-timeout = 7000;
      max-visible = 10;
    };
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
