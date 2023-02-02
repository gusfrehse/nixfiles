{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gus";
  home.homeDirectory = "/home/gus";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.kakoune = {
   enable = true;
   config = {
    colorScheme = "zenburn";
    ui = {
     enableMouse = true;
    };
   };
   plugins = [
    pkgs.kakounePlugins.kak-lsp 
    pkgs.kakounePlugins.kak-fzf
   ];
   extraConfig =
    ''
        eval %sh{kak-lsp --kakoune -s $kak_session}
        lsp-enable

        map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
        map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
        map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
        map global object e '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
        map global object k '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
        map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
        map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'

        map global normal <c-p> ': fzf-mode<ret>'
    '';
  };

  programs.tmux = {
   enable = true;
   baseIndex = 1;
   prefix = "C-a";
   keyMode = "vi";
   customPaneNavigationAndResize = true;
   escapeTime = 0;
   terminal = "xterm-256color";
   extraConfig =
   ''
       set -ga terminal-overrides ',*color*:Tc'
   '';
  };
}
