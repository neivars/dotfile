-- ====================
-- NEOVIM CONFIGURATION
-- ====================

---@STEP 001 Bootstrap lazy.nvim plugin manager
---=============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        lazyrepo, lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


-- Map leaders (so they can be used in plugin configs)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


---@STEP 002 Load plugins
---=============================================================================
require("lazy").setup({
    spec = {
        ---#PLUG 001                                         Colorschemes/Themes
        ------------------------------------------------------------------------
        {
            -- GRUVBOX
            -- Colorscheme for vim/nvim
            "ellisonleao/gruvbox.nvim",
            priority = 1000,
            config = true,
        },
        {
            -- NVIM-WEB-DEVICONS
            -- Nerd Font icons (glyphs) for use by Neovim plugins
            "nvim-tree/nvim-web-devicons",
            opts = {},
        },

        ---#PLUG 002                                                  Syntax/LSP 
        ------------------------------------------------------------------------
        {
            -- NVIM-TREESITTER
            -- Nvim interface for tree-sitter, a syntax highlighter and parser for
            -- file types/code
            "nvim-treesitter/nvim-treesitter",
            branch = "master",
            lazy = false,
            build = ":TSUpdate",
        },

        ---#PLUG 003                                                       Files
        ------------------------------------------------------------------------
        {
            -- TELESCOPE
            -- Fuzzy finder over lists. List picker for file explorer, buffers,
            -- etc.
            "nvim-lua/telescope.nvim",
            branch = "0.1.x", -- stable release branch
            dependencies = { "nvim-lua/plenary.nvim" },
        },

        ---#PLUG 004                                             Nvim Navigation 
        ------------------------------------------------------------------------
        {
            -- WHICH-KEY
            -- Shows assigned key mappings
            "folke/which-key.nvim",
            event = "VeryLazy",
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer local keymaps (which-key)",
                }
            }
        },

    },
    -- automatically check for plugin updates
    checker = { enabled = true },
})


---@STEP 003 Configure plugins
---=============================================================================
---#CONF 001 Telescope
local tsBi = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tsBi.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fb", tsBi.buffers, { desc = "Telescope buffers" })


---@STEP 004 Set colorscheme
---=============================================================================
vim.cmd("colorscheme gruvbox")


---@STEP 005 Set user-level editor options
---=============================================================================
vim.opt.number = true   -- Line numbers

-- Indentation
vim.opt.tabstop = 4         -- Size of a tab char
vim.opt.softtabstop = 0     -- Width of indentation, using tabs and spaces. 0 = tabstop
vim.opt.shiftwidth = 4	    -- Size of shift operations (<< >> ==)
vim.opt.shiftround = true   -- Shift to multiples of shiftwidth

vim.opt.expandtab = true    -- Use only spaces for indent

vim.opt.autoindent = true   -- Keep indentation of previous line

-- Windows
vim.opt.splitright = true   -- Split windows go on the right
vim.opt.splitbelow = true   -- Split vertical windows go below

