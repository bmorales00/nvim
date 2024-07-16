return {
  "ramojus/mellifluous.nvim",
  version = "v0.*",
  priority = 1000,
  lazy = false,
  config = function()
    require("mellifluous").setup({
      transparent_background = {
        enabled = true,
      },
      plugins = {
        nvim_tree = {
          enabled = true,
          show_root = true,
        },
      },
      mellifluous = {
        neutral = true,
        bg_contrast = "soft",
      },
    })
    vim.cmd("colorscheme mellifluous")
  end,
}

