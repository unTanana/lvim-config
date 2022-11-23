--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

-- low level vim modifications

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight-night"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true

-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = true
lvim.lsp.automatic_servers_installation = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-CR>"] = "o<ESC>"
lvim.keys.insert_mode["<S-CR>"] = "<ESC>o"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- yank cursor reset
lvim.keys.visual_mode["y"] = "ygv<ESC>" -- visual_mode yank -> moves cursor to end of yanked text and into normal mode

-- delete before paste
lvim.keys.visual_mode["<leader>p"] = "\"_dP"
-- delete to _ registry
lvim.keys.visual_mode["<leader>d"] = "\"_d"
lvim.keys.normal_mode["<leader>d"] = "\"_d"

-- Hover Doc
lvim.keys.normal_mode["K"] = ":Lspsaga hover_doc<CR>"
lvim.keys.normal_mode["gs"] = ":Lspsaga signature_help<CR>"
-- go to buffers
lvim.keys.normal_mode["<leader>1"] = ":BufferLineGoToBuffer 1<cr>"
lvim.keys.normal_mode["<leader>2"] = ":BufferLineGoToBuffer 2<cr>"
lvim.keys.normal_mode["<leader>3"] = ":BufferLineGoToBuffer 3<cr>"
lvim.keys.normal_mode["<leader>4"] = ":BufferLineGoToBuffer 4<cr>"
lvim.keys.normal_mode["<leader>5"] = ":BufferLineGoToBuffer 5<cr>"
lvim.keys.normal_mode["<leader>6"] = ":BufferLineGoToBuffer 6<cr>"
lvim.keys.normal_mode["<leader>7"] = ":BufferLineGoToBuffer 7<cr>"
lvim.keys.normal_mode["<leader>8"] = ":BufferLineGoToBuffer 8<cr>"
lvim.keys.normal_mode["<leader>9"] = ":BufferLineGoToBuffer 9<cr>"
-- c* && c#
lvim.keys.normal_mode["c*"] = "*Ncgn"
lvim.keys.normal_mode["c#"] = "#NcgN"

lvim.keys.normal_mode["N"] = "Nzz"
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.insert_mode["jk"] = "<ESC>"


-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }


-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<CR>", "Find files" }
lvim.builtin.which_key.mappings["c"] = {
    name = "+Code",
    p = { "\"0p", "paste 0" },
    P = { "\"0P", "Paste 0" },
    l = { "@l", "console.log" },
    e = { "@k", "console.error" },
    o =
    { organize_imports, "Organize Imports" },
    r = { "<cmd>Lspsaga rename<CR>", "Rename" },
    d = { "<cmd>Lspsaga preview_definition<CR>", "Preview Definition" },
    f = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
}

lvim.builtin.which_key.mappings["a"] = {
    name = "+yAnk Extensions",
    f = { "?public\\|protected\\|private\\|function\\|func\\|fn\\|=><CR>$V%ygv<ESC><cmd>nohlsearch<CR>", "function" },
}

lvim.builtin.which_key.mappings["x"] = { "<cmd>BufferKill<cr>", "Close Window" }
lvim.builtin.which_key.mappings["w"] = {
    name = "+Window",
    d = { "<cmd>BufferLineMoveNext<cr>", "Move Right" },
    a = { "<cmd>BufferLineMovePrev<cr>", "Move Left" },
    s = { "<cmd>BufferLineTogglePin<cr>", "Toggle Pin" },
    w = { ":w<CR>", "Save" },
    q = { "<cmd>BufferKill<CR>", "Close Window" },
}

lvim.builtin.which_key.mappings["s"]["f"] = {
    require("lvim.core.telescope.custom-finders").find_project_files, "Find File"
}

lvim.builtin.which_key.mappings["F"] = {
    require("lvim.core.telescope.custom-finders").find_project_files, "Find File"
}

lvim.builtin.which_key.mappings["f"] = {
    "<cmd>Telescope live_grep<cr>", "Text"
}

lvim.builtin.which_key.mappings["g"] = { "<cmd>LazyGit<cr>", "LazyGit" }

lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Toggle Zen" }

lvim.builtin.telescope.defaults.file_ignore_patterns = { "node_modules", ".git" }

-- lvim.builtin.which_key.mappings["S"] = {
--     name = "Session",
--     c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
--     l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
--     Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.width = 44
lvim.builtin.terminal.open_mapping = "<C-t>"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
    "go",
    "astro",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    -- { command = "black", filetypes = { "python" } },
    -- { command = "isort", filetypes = { "python" } },
    {
        -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = { "--print-with", "100" },
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "typescript", "typescriptreact", "javascript" },
    },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    -- { command = "flake8", filetypes = { "python" } },
    -- {
    --     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    --     command = "shellcheck",
    --     ---@usage arguments to pass to the formatter
    --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    --     extra_args = { "--severity", "warning" },
    -- },
    -- {
    --     command = "cspell",
    --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    --     filetypes = { "javascript", "python", "typescript", "typescriptreact" },
    -- },
}

-- Additional Plugins
lvim.plugins = {
    {
        "briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim"
    },
    { 'morhetz/gruvbox' },
    { 'f-person/git-blame.nvim' },
    {
        "justinmk/vim-sneak"
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        "wuelnerdotexe/vim-astro"
    },
    {
        "folke/zen-mode.nvim",
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                enable = true,
                filetypes = {
                    'html', 'javascript', 'typescript', 'javascriptreact',
                    'typescriptreact', 'svelte', 'vue', 'tsx',
                    'jsx', 'rescript',
                    'xml',
                    'php',
                    'markdown',
                    'glimmer', 'handlebars', 'hbs', 'astro',
                },
                skip_tags = { 'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
                    'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem' }
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "sumneko_lua", "tailwindcss" },
            })
        end,
    }, {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require("lspsaga")

            saga.init_lsp_saga({
                -- your configuration
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim"
    },
    { "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
    },
    { "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "nvim-cmp" },
        config = function()
            require("copilot_cmp").setup()
        end
    },
}

local nvim_lsp = require "lspconfig"
nvim_lsp.tailwindcss.setup {}
-- require("copilot").setup()

-- astro config attempt
local configs = require 'lspconfig.configs'
if not configs['astro'] then
    configs['astro'] = {
        default_config = {
            cmd = { 'astro-ls', '--stdio' },
            filetypes = { 'astro' },
            root_dir = nvim_lsp.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
            docs = {
                description = 'https://github.com/withastro/language-tools',
                root_dir = [[root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")]],
            },
            init_options = {
                configuration = {
                    astro = {},
                },
            },
            settings = {},
        },
    }
end



lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "zsh",
--     callback = function()
--         -- let treesitter use bash highlight for zsh files as well
--         require("nvim-treesitter.highlight").attach(0, "bash")
--     end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.js", "*.ts", "*.tsx", "*.jsx", "*.astro" },
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoconsole.log("jkpei, jkpea;jk')
        vim.fn.setreg('k', 'yiwoconsole.error("jkpei, jkpea;jk')
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.go",
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwofmt.Printf("jkpa %+vjkla, jkp')
        vim.fn.setreg('k', "ojkccif err != nil {\njkccreturn nil, err\n}jk")
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.rs",
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoprintln!("{:?jkei, jkpA;jk')
        -- vim.fn.setreg('k', "") -- not used
    end,
})
