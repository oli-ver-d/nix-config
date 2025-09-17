{pkgs, ...}: {
  home.packages = with pkgs; [
    # Python LSPs
    ruff
    pyright
    # Markdown LSP
    marksman

    # lazygit to integrate
    lazygit
  ];
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
        {
          name = "python";
          file-types = ["py"];
          language-servers = ["ruff" "pyright"];
        }
      ];
      language-server = {
        pyright.config.python.analysis = {
          typeCheckingMode = "basic";
        };
        ruff = {
          command = "ruff";
          args = ["server"];
        };
        pylyzer = {
          command = "pylyzer";
          args = ["--server"];
        };
      };
    };

    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        mouse = false;
        shell = ["zsh" "-c"];
        bufferline = "multiple";
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "hint";
        };
        cursor-shape.insert = "underline";
        lsp.display-inlay-hints = true;
      };
      keys = {
        insert = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";
          C-s = ":write";
          A-j = "normal_mode";
        };
        normal = {
          C-s = ":write";
          C-g = [":write-all" ":new" ":insert-output lazygit" ":buffer-close!" ":redraw" ":reload-all"];
        };
      };
    };
  };
}
