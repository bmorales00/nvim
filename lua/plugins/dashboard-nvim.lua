-- Dashboard configuration for Neovim using alpha-nvim
return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function get_ordinal_date(day)
      local suffixes = {
        st = { 1, 21, 31 },
        nd = { 2, 22 },
        rd = { 3, 23 },
      }

      for suffix, days in pairs(suffixes) do
        if vim.tbl_contains(days, day) then
          return day .. suffix
        end
      end

      return day .. "th"
    end

    local function footer()
      local day = tonumber(os.date("%d"))
      local ordinal_day = get_ordinal_date(day)

      local datetime = os.date("%A, " .. ordinal_day .. " %B %Y -- %I:%M %p")
      local version = vim.version()
      local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch

      return "        " .. datetime .. " -- NVIM Ver:" .. nvim_version_info
    end


    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    --local dashboard = require("alpha.themes.theta")
    --local dashboard = require("alpha.themes.startify")
    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", " [n]ew file", "<cmd>ene<CR>"),
      dashboard.button("ff", " [f]ind [f]ile", "<cmd>Telescope find_files<CR>"),
      dashboard.button("fg", " [f]ind [g]rep", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("u", " [u]pdate plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("i", " [i]nstall language tools", "<cmd>Mason<CR>"),
      dashboard.button("q", "X [q]uit", "<cmd>qa<CR>"),
    }
    dashboard.section.footer.val = footer()
    alpha.setup(dashboard.config)
  end
}
