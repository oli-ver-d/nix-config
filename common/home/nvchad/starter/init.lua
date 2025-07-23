vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, { lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json" }, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

vim.opt.relativenumber = true
vim.opt.number = true

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

require("lspconfig").nixd.setup {
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake "~/dotfiles/flake.nix").nixosConfigurations.default.options',
        },
        -- home_manager = {
        --   expr = '(builtins.getFlake "~/dotfiles/flake.nix").homeConfigurations.default.options',
        -- },
      },
    },
  },
}
