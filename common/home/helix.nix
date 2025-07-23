{...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      editor = {
        bufferline = "multiple";
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "hint";
        };
        cursor-shape.insert = "underline";
        lsp.display-inlay-hints = true;
      };
    };
  };
}
