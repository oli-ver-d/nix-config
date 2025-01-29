{ pkgs, lib, ... }:

{
  vim = {
    vimAlias = true;
    viAlias = true;

    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    statusLine.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    lsp = {
      formatOnSave = true;	
    };

    languages = {
      enableLSP = true;
      enableTreesitter = true;
      enableFormat = true;
      enableExtraDiagnostics = true;

      nix.enable = true;
      rust.enable = true;
      rust.crates.enable = true;
      python.enable = true;
      markdown.enable = true;
    };

  };
}
