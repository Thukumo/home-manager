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
    podman
    podman-compose
    podman-tui

    # yazi用
    vlc
    feh
  ];
  programs.fish = {
    enable = true;
    # interactiveShellInit = "fastfetch";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
  home.shell.enableFishIntegration = true;
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Adwaita Mono Nerd Font:size=12";
      };
    };
  };
  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        #   linemode = "mtime";
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tsukumo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
