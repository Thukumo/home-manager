{ config, pkgs, lib, ... }:

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
      # ${pkgs.parallel}/bin/parallel --citatione
    '';
  };
  home.packages = with pkgs; [
    # neovimのプラグイン用
    deno
    rust-analyzer

    lazygit
    nerd-fonts.adwaita-mono
    vlc
    fastfetch
    pandoc
    typst
    parallel

    (pkgs.writeShellScriptBin "convd-md-to-pdf" ''
#!/bin/sh
if [ -z $1 ]; then
echo ディレクトリへのパスを引数として与えてください。
exit 1
fi
if [ -d $1 ]; then
parallel pandoc {} --pdf-engine typst -o {.}.pdf ::: ''${1%/}/*.md
else
echo ディレクトリではありません。
exit 2
fi
    '')

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

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
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      lualine-nvim
      denops-vim
      markdown-preview-nvim
      nvim-treesitter-context
      vim-repeat
      dropbar-nvim
      hlchunk-nvim
      zen-mode-nvim
      tokyonight-nvim
      # hlchunkの依存プラグイン
      # とりあえず対応してる全言語のパーサを入れとく
      nvim-treesitter.withAllGrammars

      nvim-lspconfig

      (pkgs.vimUtils.buildVimPlugin {
        name = "barbar.nvim";
        src = builtins.fetchGit {
          url = "https://github.com/romgrk/barbar.nvim";
          rev = "549ee11d97057eae207bafa2c23c315942cca097";
        };
        doCheck=false;
      })
      # barbar.nvimの(任意)依存プラグイン
      nvim-web-devicons

      (pkgs.vimUtils.buildVimPlugin {
        name = "hellshake-yano.vim";
        src = builtins.fetchGit {
          url = "https://github.com/nekowasabi/hellshake-yano.vim";
          rev = "294a171e2fd8259d71c6fcc2e448979747a85cca";
        };
      })
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "nanode.nvim";
      #   src = builtins.fetchGit {
      #     url = "https://github.com/KijitoraFinch/nanode.nvim";
      #     rev = "cd85bbb5195b23adfb89a695b54e16daab259800";
      #   };
      # })
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "tabset.vim";
      #   src = builtins.fetchGit {
      #     url = "https://github.com/FotiadisM/tabset.nvim";
      #     rev = "996f95e4105d053a163437e19a40bd2ea10abeb2";
      #   };
      # })
      (pkgs.vimUtils.buildVimPlugin {
        name = "trouble.vim";
        src = builtins.fetchGit {
          url = "https://github.com/folke/trouble.nvim";
          rev = "c098362fe603d3922095e7db595961e020bdf2d0";
        };
        doCheck=false;
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "accelerated-jk.nvim";
        src = builtins.fetchGit {
          url = "https://github.com/rainbowhxch/accelerated-jk.nvim";
          rev = "8fb5dad4ccc1811766cebf16b544038aeeb7806f";
        };
      })
    ];
    extraLuaConfig = (builtins.readFile ./init.lua);
    extraConfig = (builtins.readFile ./init.vim);
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
