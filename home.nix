{ config, pkgs, ... }:

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
  home.packages = [
    # hellshake-yano用
    pkgs.deno

    pkgs.lazygit
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      lualine-nvim
      denops-vim
      markdown-preview-nvim
      hlchunk-nvim
      # hlchunkの依存プラグイン(本来なくても動きそうだけど...?)
      # とりあえず対応してる全言語のパーサを入れておく
      nvim-treesitter.withAllGrammars
      
      (pkgs.vimUtils.buildVimPlugin {

        name = "hellshake-yano.vim";
        src = builtins.fetchGit {
          url = "https://github.com/nekowasabi/hellshake-yano.vim";
          rev = "294a171e2fd8259d71c6fcc2e448979747a85cca";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "nanode.nvim";
        src = builtins.fetchGit {
          url = "https://github.com/KijitoraFinch/nanode.nvim";
          rev = "cd85bbb5195b23adfb89a695b54e16daab259800";
        };
      })
    ];
    extraLuaConfig = ''
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      require('lualine').setup()
      require('nvim-autopairs').setup {}
      require('nvim-treesitter.configs').setup {
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
      require('hlchunk').setup({
        chunk = {
          enable = true
        },
        indent = {
          enable = true
        },
        line_num = {
          enable = true
        },
      })
      vim.g.hellshake_yano = {
        useJapanese = true,
        useHintGroups = true,
        highlightSelected = true,
        useNumericMultiCharHints = true,
        enableTinySegmenter = true,
        singleCharKeys = "ASDFGNM@;,.",
        multiCharKeys = "BCEIOPQRTUVWXYZ",
        highlightHintMarker = {bg = "black", fg = "#57FD14"},
        highlightHintMarkerCurrent = {bg = "Red", fg = "White"},
        perKeyMinLength = {
          w = 3,
          b = 3,
          e = 3,
        },
        defaultMinWordLength = 3,
        perKeyMotionCount = {
          w = 1,
          b = 1,
          e = 1,
          h = 2,
          j = 2,
          k = 2,
          l = 2,
        },
        motionCount = 3,
        japaneseMinWordLength = 3,
        segmenterThreshold = 4,
        japaneseMergeThreshold = 4,
      }
    '';
    extraConfig = ''
      colorscheme nanode
    '';
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
