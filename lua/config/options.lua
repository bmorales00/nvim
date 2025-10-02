-- This file is responsible for setting up the options for neovim
local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2 -- Sets display width of character
opt.shiftwidth = 2 -- Sets size of an indent level
opt.softtabstop = 2 -- Defines how many spaces a tab key press acts like
opt.expandtab = true -- Use spaces instead of tab characters
opt.smartindent = true -- Smart auto-indenting for statements like 'if' 'for'
opt.autoindent = true -- Copy indent from current line to the new line
opt.wrap = false -- Don't wrap lines meaning lines will continue off-screen

-- Searching
opt.incsearch = true -- Highlights first matches as you type
opt.ignorecase = true -- Case-insensitive search | Will not treat lower and upper the same
opt.smartcase = true -- Case-Sensitive if uppercase in search when explicit
opt.hlsearch = false -- Don't Highlight search results when searching

-- Appearance
opt.number = true -- Line Numbers in the left margin
opt.relativenumber = true --Relative Line Numbers based on cursor pos
opt.termguicolors = true -- Enable 24-bit colors for better color display
opt.colorcolumn = "100" -- Visually Highlights a specific column after # of chars ->
opt.signcolumn = "yes" -- Always show sign column like breakpoints,linter errors,etc
opt.cmdheight = 1 -- Command line height
opt.scrolloff = 10 -- When scrolling, the cursor will be at least 10 lines away from top and bott
opt.sidescrolloff = 10 -- Same as scrolloff just in terms of columns or left/right
opt.completeopt = "menuone,noinsert,noselect" -- Completion options i.e explicitly choose
opt.fillchars = { eob = " " } -- chars to fill the statuslines
opt.cursorline = true -- Highlight current line
opt.winblend = 0 -- Floating window transparency
opt.lazyredraw = false -- redraw while executing macros - false means it updates instantly
opt.redrawtime = 10000 -- Timeout for sytax highlighting redraw

-- File Handling
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't backup before overwriting
opt.autoread = true -- Auto-reload file if changed outside such as git changes
opt.autowrite = false -- Don't auto-save on some events such as :bNext
opt.diffopt:append("vertical") -- Vertical diff splits
opt.diffopt:append("algorithm:patience") -- Diff algo
opt.diffopt:append("linematch:60") -- Better diff highlighting (smart line matching)

-- Timing and Responsiveness
opt.timeoutlen = 500 -- Time in ms to wait for mapped sequence i.e pressing 'jk'
opt.updatetime = 300 -- Time in ms to trigger cursorhold | for linters to show error when no response
opt.ttimeoutlen = 0 -- No wait for key code sequences and instantly performs action

-- Behaviour
opt.hidden = true -- Allows for buffers that are unsaved to be hidden such as moving between buffers
opt.errorbells = false -- Diables the terminal bell/beep
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Tells nvim where to save undo (.un~) files
opt.backspace = "indent,eol,start" -- Specifies what backspace should do in insert mode
opt.splitright = true -- Allows for vertical split
opt.splitbelow = true -- Allows for horizontal split
opt.autochdir = false -- Controls the current dir and whether it changes automatically
opt.iskeyword:append("-") -- The arg specified in the function is treated as a char in a set of chars
opt.selection = "inclusive" -- Defines behaviour of visual mode
opt.mouse = "a" -- enables mousse support in all modes
opt.encoding = "UTF-8" -- Sets char encoding
opt.clipboard:append("unnamedplus") -- integrates nvim clipboard with system clipboard
opt.modifiable = true -- Controls whether the text in the buffer can be changed
opt.showmode = false -- Hides the mode indicator
opt.conceallevel = 1 -- Show if text that has been marked for concealing is shown or not

-- Cursor Settings
opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
-- Defines the shape and behavior of the cursor for different modes

-- Folding Settings
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
