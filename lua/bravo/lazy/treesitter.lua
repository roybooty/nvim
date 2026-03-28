-- ~/.config/nvim/lua/bravo/lazy/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",          -- auto-runs :TSUpdate after install/update
  lazy = false,                 -- load immediately so highlighting works from first file

  -- This passes your settings to .setup()
  opts = {
    ensure_installed = {
      "c", "cpp",
      "go", "gomod", "gowork",
      "javascript", "typescript", "tsx",
      "zig",
      "lua", "vim", "vimdoc", "query",
      "markdown", "markdown_inline",
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },
  },

  -- This is the key: require inside the function → safe timing
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
  end,
}
