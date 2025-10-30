{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    webcord
    xfce.thunar
  ];
  # Mattermost Desktopが~/.config/autostart/electron.desktopを作ってきて困るので、
  # 先に/dev/nullへのシンボリックリンクにしておく
  xdg.configFile."autostart/electron.desktop".source = config.lib.file.mkOutOfStoreSymlink /dev/null;
  home.file = {
    # 手抜きのため、ホームディレクトリ直下に~/.config/home-managerへのシンボリックリンクを作成する
    "home-manager".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager";
  };
  # wayland.windowManager.sway = {
  #   enable = true;
  # };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        use-bold = true;
      };
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Adwaita Mono Nerd Font:size=12";
      };
      mouse = {
        hide-when-typing = true;
      };

    };
  };
  services.mako = {
    enable = true;
    settings = {
      # ignore-timeout = true;
      ignore-timeout = 1;
      default-timeout = 7000;
      max-visible = 10;
    };
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}

