{...}: {
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          file-types = ["nix"];
          language-servers = ["nixd"];
          formatter = {
            command = "alejandra";
          };
        }
      ];
    };

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
