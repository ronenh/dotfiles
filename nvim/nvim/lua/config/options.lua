local opt = vim.opt

opt.showmatch = true     -- show matching brackets.
opt.mouse = "a"          -- mouse scrolling and enterin visual mode
opt.autoindent = true    -- indent a new line the same amount as the line just typed
opt.termguicolors = true -- set term gui colors
opt.autoread = true      -- auto reload files on changes
opt.scrolloff = 3        -- keep 3 context lines around the viewport
opt.laststatus = 2       -- always show status bar
opt.textwidth = 0        -- don't wrap lines
opt.cmdheight = 0        -- hide command line when not used


-- Search settings
opt.ignorecase = true -- ignore case
opt.smartcase = true  -- override ignorecase if the search pattern contains uppercase characters

-- Tab settings
opt.expandtab = true -- expand tabs to the proper size
opt.tabstop = 4      -- tabs witdth in spaces
opt.softtabstop = 4  -- soft tab width
opt.shiftwidth = 4   -- amount of spaces when shifting (0 to use tabstop)


opt.listchars = "tab:¬ ,trail:~,extends:»,precedes:»" -- show hard tabs, trailing whitespace, etc
opt.list = true

-- Tab completion settings
opt.wildmode = "list:longest"              -- Wildcard matches show a list, matching the longest first
opt.wildignore = { '.git', '.hg', '.svn' } -- Ignore version control repos
opt.wildignore:append('*.6')               -- Ignore Go compiled files
opt.wildignore:append('*.pyc')             -- Ignore Python compiled files
opt.wildignore:append('*.rbc')             -- Ignore Rubinius compiled files
opt.wildignore:append('*.swp')             -- Ignore vim backups

-- Relative line numbers
opt.number = true
opt.relativenumber = true


-- yank to clipboard by default
opt.clipboard = "unnamed"


-- more natural split opening
opt.splitbelow = true
opt.splitright = true
