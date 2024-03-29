#  Zsh conf
#  I have some plugins problem when managin nix, so I manage zsh plugins from zinit.
#  When you put zinit in nixpkgs, you need to create a symbolic link manually because the path to completions is different.
#  You can watch this solution at (machines/home.nix home.activation.myActivationAction)
{ pkgs, ... }:
{
  imports = [
    ../../../modules/zinit.nix
  ];
  home.packages = with pkgs; [ nix-zsh-completions ];
  programs = {
    zsh = {
      enable = true;

      autosuggestion.enable = false;
      enableCompletion = false;
      autocd = true;

      history = {
        ignoreDups = true;
        ignorePatterns = [
          "rm *"
          "ls *"
          "pkill *"
          "kill *"
          "history *"
        ];
        extended = true;
        save = 10000;
        size = 10000;
        share = true;
      };

      prezto = {
        enable = true;
        extraFunctions = [
          "zargs"
          "zmv"
          "zcp"
          "zln"
        ];
        extraModules = [
          "attr"
        ];
      };
      zinit = {
        enable = true;
        promptTheme = {
          enable = false;
          theme = "romkatv/powerlevel10k";
          modifier = ''
            depth=1 atload'P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
            [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
            source "''${HOME}/.p10k.zsh"' light-mode \
          '';
        };
        plugins = {
          "lucid blockf light-mode " = [
            "atload'zvm_init'"
            "depth=1 jeffreytse/zsh-vi-mode"
            "zsh-users/zsh-autosuggestions"
            "marlonrichert/zsh-autocomplete"
          ];
          "wait'0b' lucid nocd depth=1 light-mode" = [
            "atload'abbr_init' olets/zsh-abbr"
          ];
          "wait'!1a' lucid blockf light-mode" = [
            "zdharma-continuum/fast-syntax-highlighting"
          ];
          "wait'1b' lucid light-mode" = [
            "hlissner/zsh-autopair"
          ];
          "wait'2a' lucid light-mode" = [
            "endaaman/lxd-completion-zsh"
          ];
        };
        prezto = {
          enable = true;
          pmodules = [
            "environment"
            "terminal"
            #"tmux"
          ];
          pmodulesWithModifier = {
            "wait'0a' lucid" = [
              # "history"
              "directory"
              "spectrum"
            ];
          };
        };
        initConfig = ''
          # The plugin will auto execute this zvm_after_init function
          function zvm_after_init() {
            # Binding keys for zsh-abbr
            if [[ $options[zle] = on ]]; then
              . ${pkgs.fzf}/share/fzf/completion.zsh
              . ${pkgs.fzf}/share/fzf/key-bindings.zsh
            fi
          }
          # historyに元のコマンドが残るalias
          function abbr_init() {
            abbr_cmds=(
              # virtual env
              crflake="nix flake new -t github:nix-community/nix-direnv"
              dirall="direnv allow"
              dirrev="direnv revoke"
              venv='source venv/bin/activate'
              # podman and buildah
              p='podman'
              ppl='podman pull'
              ppld='podman pull docker.io/'
              pps='podman ps'
              pimgs='podman images'
              prun='podman run'
              bud='buildah bud'
              # git
              lg='lazygit'
              g='git'
              ga='git add'
              gc='git commit'
              gac='git add -A && git commit'
              gsh='git stash'
              gst='git status'
              gbr='git branch'
              gco='git checkout'
              gdf='git diff'
              gmr='git merge'
              grb='git rebase'
              gl='git log'
              glo='git log --oneline'
              ggr='git grep'
              gsw='git switch'
              gpl='git pull'
              gpu='git push'
              gget='ghq get'
              # nixos-rebuild
              nixosts='sudo nixos-rebuild test --flake'
              nixossw='sudo nixos-rebuild switch --flake'
            )
            [ ! -d "''${XDG_CONFIG_HOME}/zsh-abbr" ] && mkdir -p "''${XDG_CONFIG_HOME}/zsh-abbr"
            if [[ ''${#abbr_cmds[@]} == $(cat ''${XDG_CONFIG_HOME}/zsh-abbr/user-abbreviations | wc -l) ]]; then
              abbr load
            else
              for cmd in "''${abbr_cmds[@]}"
              do
                abbr $cmd
              done
            fi
          }
        '';
      };
      shellAliases = {
        nix = "noglob nix";
      };
      localVariables = {
        ZVM_VI_INSERT_ESCAPE_BINDKEY = "jj";
        ZVM_VI_VISUAL_ESCAPE_BINDKEY = "jj";
        ZVM_VI_OPPEND_ESCAPE_BINDKEY = "jj";
        ZVM_LINE_INIT_MODE = "$ZVM_MODE_INSERT";
        ZVM_LAZY_KEYBINDINGS = false;
        ABBR_QUIET = 1;
      };
      # 既にsessionが起動しているかつattach済なら新しくsessionを作成する
      # そうでなればsessionにattachする
      initExtraFirst = ''
        # Calc startup time
        # zmodload zsh/zprof
        # zprof
      '';
      initExtraBeforeCompInit = ''
        setopt EXTENDED_GLOB         # 拡張GRUBの有効化(^: 否定、~: 除外)
        setopt BARE_GLOB_QUAL        # 条件付け検索の有効化
        setopt MAGIC_EQUAL_SUBST     # cmd a=/to/pathの時に補完を効かせる
        setopt HIST_IGNORE_SPACE     # 先頭にスペースがあるコマンドは履歴に残さない
      '';

      initExtra = ''
        # Enable bash completion
        autoload -U bashcompinit && bashcompinit

        set vi-cmd-mode-string "\1\e[?8c\2"
        set vi-ins-mode-string "\1\e[?0c\2"
        # qtileやkittyなどwrap環境内で作業することが必要な時に依存関係のPATHを外す処理
        # (依存関係のPATHが追記された状態を解消してクリーンな状態に戻す)
        # direnvでは問題なかったがnix-shellやnix shellでパスが追記されない
        # (PATH追記後にSHELLが起動するため)問題があったため、シェルの深さで実行の有無を決める
        if [ -n "$DESKTOP_SESSION" ] && [ "$SHLVL" -eq 2 ] || [ "$SHLVL" -eq 1 ]; then
        	PATH=$(echo "$PATH" | sed 's/\/nix\/store\/[a-zA-Z._0-9-]\+\/bin:\?//g' | sed 's/:$//')
        	export PATH="$PATH"
        fi
        # For marlonrichert / zsh-autocomplete
        zstyle -e ':autocomplete:history-search-backward:*' list-lines 'reply=$(( LINES / 2 ))'
        zstyle ':autocomplete:*' min-delay 0.05
        bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
        bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
      '';
    };
  };
}
