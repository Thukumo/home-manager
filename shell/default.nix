{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    lazygit
    gh

    nerd-fonts.adwaita-mono
    fastfetch
    btop
    gotop
    speedtest-cli
    bluetui
    zellij
    trash-cli

    # yazi用
    vlc
    feh
    fd
    ripgrep
  ];
  imports = [
    ./nvim
    ./convd-md2pdf
  ];
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
  home.shell.enableFishIntegration = true;
  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
          linemode = "mtime";
      };
      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
          }
        ];
        play = [
          {
            run = ''vlc "$@"'';
          }
        ];
      };
    };
  };
  home.file = {
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
