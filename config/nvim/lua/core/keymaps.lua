-- Leader Key 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Disable default behaviour of ' ' ( leader key )
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true})


-- For consistent behaviour and also cause I hate seeing the command in the bar
local opts = { noremap = true, silent = true }


-- Session
vim.keymap.set('n', '<leader>sl', '<cmd>SessionManager load_last_session<CR>', { desc = 'Open last session' })


-- Session
vim.keymap.set('n', '<leader>i', '<cmd>InspectTree<CR>', { desc = 'Toggle Inspect Tree' })


-- Reusing opts with desc
local function optsDesc(desc)
    return vim.tbl_extend('force', opts, { desc = desc })
end


-- Toggle Line Wrap
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', optsDesc("Toggle Line Wrap"))


-- Changing behaviour of 'x'
vim.keymap.set('n', 'x', '"_x', opts)


-- Resizing buffers with Arrow Keys cuz ain't no way I'll remember all binds
vim.keymap.set('n', '<Up>', ':resize -2<CR>', optsDesc("Resize: +2 step vertically"))
vim.keymap.set('n', '<Down>', ':resize +2<CR>', optsDesc("Resize: -2 step vertically"))
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', optsDesc("Resize: -2 step horizontally"))
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', optsDesc("Resize: +2 step vertically"))


-- Navigating and manipulating buffers
vim.keymap.set('n', '<S-l>', ':bnext<CR>', optsDesc("Goto Next Buffer"))
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', optsDesc("Goto Previous Buffer"))
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', optsDesc("Delete current Buffer"))
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', optsDesc("Initialize new Buffer"))

vim.keymap.set('n', '<C-h>', '<C-w>h', optsDesc("Goto Left"))
vim.keymap.set('n', '<C-l>', '<C-w>l', optsDesc("Goto Right"))
vim.keymap.set('n', '<C-j>', '<C-w>j', optsDesc("Go Down"))
vim.keymap.set('n', '<C-k>', '<C-w>k', optsDesc("Go Up"))

vim.keymap.set('n', '<C-i>', '<C-w>w', optsDesc("Go Inside Window"))

-- Window Management
vim.keymap.set('n', '<leader>sh', '<C-w>s', optsDesc("Horizontal Split"))
vim.keymap.set('n', '<leader>sv', '<C-w>v', optsDesc("Vertical Split"))
vim.keymap.set('n', '<leader>se', '<C-w>=', optsDesc("Equalize Splits"))
vim.keymap.set('n', '<leader>sx', ':close<CR>', optsDesc("Close Split"))


-- Tabs
vim.keymap.set('n', '<leader>tt', ':tabnew<CR>', optsDesc("Create new tab"))
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', optsDesc("Close Tab"))
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', optsDesc("Next Tab"))
vim.keymap.set('n', '<leader>tb', ':tabp<CR>', optsDesc("Previous Tab"))


-- Recurring Indentations
vim.keymap.set('v', '<', '<gv', optsDesc("Indent to Left"))
vim.keymap.set('v', '>', '>gv', optsDesc("Indent to right"))


-- Recurring Cut-Pasting
vim.keymap.set('x', 'p', '"_dP', optsDesc("Paste over without copying"))


-- Diagonistic
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, optsDesc("Goto Previous Diagnostic"))
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, optsDesc("Goto Next Diagnostic"))
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, optsDesc("Open Diagnostic Reason"))
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, optsDesc("List the diagnostics"))


-- From the Primogen , idk how to spell it, but yk him, if you dont, you don't belong here
-- Vertical Scroll and center
vim.keymap.set( 'n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set( 'n', '<C-u>', '<C-u>zz', opts)

-- Moving through references
vim.keymap.set({'n', 'i'}, ']q', '<cmd>cnext<CR>')
vim.keymap.set({'n', 'i'}, '[q]', '<cmd>cprev<CR>')


-- Find and Center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
