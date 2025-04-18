local groups = require("user.maps.groups")

----------------------------------------------------------- No Leader
local n_map = lvim.keys.normal_mode

n_map["<S-l>"] = ":BufferLineCycleNext<CR>"
n_map["<S-h>"] = ":BufferLineCyclePrev<CR>"
n_map["<F3>"] = ":NvimTreeToggle<CR>"
n_map["<leader>tf"] = ":NvimTreeFindFile<CR>"

----------------------------------------------------------- With Leader
lvim.leader = "space"

local wk = lvim.builtin.which_key

wk.mappings["t"] = groups.terminal

-- Tabs
wk.mappings["1"] = { "1gt", WhichKeyIgnoreLabel }
wk.mappings["2"] = { "2gt", WhichKeyIgnoreLabel }
wk.mappings["3"] = { "3gt", WhichKeyIgnoreLabel }
wk.mappings["4"] = { "4gt", WhichKeyIgnoreLabel }
wk.mappings["5"] = { "5gt", WhichKeyIgnoreLabel }
wk.mappings["6"] = { "6gt", WhichKeyIgnoreLabel }
wk.mappings["7"] = { "7gt", WhichKeyIgnoreLabel }
wk.mappings["8"] = { "8gt", WhichKeyIgnoreLabel }
wk.mappings["9"] = { "9gt", WhichKeyIgnoreLabel }
