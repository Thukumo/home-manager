{ pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tsukumo";
  home.homeDirectory = "/home/tsukumo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.activation = {
    parallelNoCitation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # ${pkgs.parallel}/bin/parallel --citation
    '';
  };
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

    ffmpeg
    yt-dlp

    webcord
    xfce.thunar

    podman
    podman-compose
    podman-tui
    # podman-desktop

    # yazi用
    vlc
    feh

    # md to pdf
    pandoc
    typst
    parallel
    (pkgs.writeShellScriptBin "convd-md2pdf" (builtins.readFile ./convd-md2pdf))

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  ];
  imports = [
    ./nvim
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
