return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    workspaces = {
      {
        name = "MyVault",
        path = "~/Desktop/MyVault",
      },
      {
        name = "buf-parent",
        path = function ()
          return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        end,
      },
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    ---@param url string
    follow_url_func = function(url)
      vim.fn.jobstart({"xdg-open", url})
    end,

    statusline = {
    enabled = true,
    format = "{{properties}} properties {{backlinks}} backlinks {{words}} words {{chars}} chars",
    },
  },
}
