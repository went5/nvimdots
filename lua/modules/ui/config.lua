local config = {}

function config.edge()
    vim.cmd [[set background=dark]]
    vim.g.edge_style = "aura"
    vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_show_eob = 1
    vim.g.edge_better_performance = 1
end

function config.lualine()
    local function lsp()
        local icon = [[  LSP: ]]
        local msg = 'No Active LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return icon .. msg end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return icon .. client.name
            end
        end
        return icon .. msg
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            disabled_filetypes = {}
        },

        sections = {
            lualine_a = {'mode'},
            lualine_b = {
                {'branch'}, {
                    'diff',
                    -- Is it me or the symbol for modified us really weird
                    symbols = {
                        added = ' ',
                        modified = '柳 ',
                        removed = ' '
                    }
                }
            },
            lualine_c = {
                {'filename'}, {
                    'diagnostics',
                    sources = {'nvim_lsp'},
                    color_error = "#BF616A",
                    color_warn = "#EBCB8B",
                    color_info = "#81A1AC",
                    color_hint = "#88C0D0",
                    symbols = {error = ' ', warn = ' ', info = ' '}
                }
            },
            lualine_x = {{lsp}, {'encoding'}, {'fileformat'}},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
    }
end

function config.nvim_bufferline()
    require('bufferline').setup {
        options = {
            number = "both",
            number_style = "superscript",
            modified_icon = '✥',
            buffer_close_icon = "",
            mappings = true,
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 20,
            show_buffer_close_icons = true,
            show_buffer_icons = true,
            show_tab_indicators = true,
            separator_style = "thin",
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    padding = 1
                }
            }
        }
    }
end

function config.dashboard()
    local home = os.getenv('HOME')
    vim.g.dashboard_footer_icon = '🐬 '
    vim.g.dashboard_default_executive = 'telescope'

    vim.g.dashboard_custom_header = {
        [[              ...  .......          ]],
        [[         ....................       ]],
        [[    ..'........................     ]],
        [[ ...,'.......'.., .........'....    ]],
        [[  .'......,. ;'., '..'.......'.'.   ]],
        [[ .'.,'.''.;..,'.. .  ...'....','..  ]],
        [[..''.'.''''.....        .,'....;'.. ]],
        [[..',.......'. .        ..';'..','...]],
        [[ ....''..  ..        .....;,..','...]],
        [[  . .....           ......,..';,....]],
        [[      .'.         ....  ... ,,'.....]],
        [[      .,..             .....,'..... ]],
        [[     .'''.             ...'......   ]],
        [[     ..'..'.          ... ......    ]],
        [[       . '.'..             ..       ]],
        [[         ......           .         ]],
        [[            ....                    ]]
    }

    vim.g.dashboard_custom_section = {
        change_colorscheme = {
            description = {' Scheme change              comma s c '},
            command = 'DashboardChangeColorscheme'
        },
        find_frecency = {
            description = {' File frecency              comma f r '},
            command = 'Telescope frecency'
        },
        find_history = {
            description = {' File history               comma f e '},
            command = 'DashboardFindHistory'
        },
        find_project = {
            description = {' Project find               comma f p '},
            command = 'Telescope project'
        },
        find_file = {
            description = {' File find                  comma f f '},
            command = 'DashboardFindFile'
        },
        file_new = {
            description = {' File new                   comma f n '},
            command = 'DashboardNewFile'
        },
        find_word = {
            description = {' Word find                  comma f w '},
            command = 'DashboardFindWord'
        }
    }
end

function config.nvim_tree()
    if not packer_plugins['nvim-tree.lua'].loaded then
        vim.cmd [[packadd nvim-tree.lua]]
    end
    vim.g.nvim_tree_width = 35
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_auto_open = 1
    vim.g.nvim_tree_auto_close = 1
    vim.g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
    vim.g.nvim_tree_quit_on_open = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_hide_dotfiles = 0
    vim.g.nvim_tree_git_hl = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_tab_open = 1
    vim.g.nvim_tree_lsp_diagnostics = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
            unstaged = "✚",
            staged = "✚",
            unmerged = "≠",
            renamed = "≫",
            untracked = "★"
        }
    }
end

function config.gitsigns()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
    end
    require('gitsigns').setup {
        signs = {
            add = {hl = 'GitGutterAdd', text = '▋'},
            change = {hl = 'GitGutterChange', text = '▋'},
            delete = {hl = 'GitGutterDelete', text = '▋'},
            topdelete = {hl = 'GitGutterDeleteChange', text = '▔'},
            changedelete = {hl = 'GitGutterChange', text = '▎'}
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,

            ['n ]g'] = {
                expr = true,
                "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
            },
            ['n [g'] = {
                expr = true,
                "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
            },

            ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
            ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

            -- Text objects
            ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
        watch_index = {interval = 1000, follow_files = true},
        current_line_blame = true,
        current_line_blame_delay = 1000,
        current_line_blame_position = 'eol',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        use_internal_diff = true -- If luajit is present
    }
end

function config.indent_blankline()
    -- vim.cmd [[highlight IndentTwo guifg=#D08770 guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentThree guifg=#EBCB8B guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentFour guifg=#A3BE8C guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentFive guifg=#5E81AC guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentSix guifg=#88C0D0 guibg=NONE gui=nocombine]]
    -- vim.cmd [[highlight IndentSeven guifg=#B48EAD guibg=NONE gui=nocombine]]
    -- vim.g.indent_blankline_char_highlight_list = {
    --     "IndentTwo", "IndentThree", "IndentFour", "IndentFive", "IndentSix",
    --     "IndentSeven"
    -- }
    require("indent_blankline").setup {
        char = "│",
        show_first_indent_level = true,
        filetype_exclude = {
            "startify", "dashboard", "dotooagenda", "log", "fugitive",
            "gitcommit", "packer", "vimwiki", "markdown", "json", "txt",
            "vista", "help", "todoist", "NvimTree", "peekaboo", "git",
            "TelescopePrompt", "undotree", "flutterToolsOutline", "" -- for all buffers without a file type
        },
        buftype_exclude = {"terminal", "nofile"},
        show_trailing_blankline_indent = false,
        show_current_context = true,
        context_patterns = {
            "class", "function", "method", "block", "list_literal", "selector",
            "^if", "^table", "if_statement", "while", "for", "type", "var",
            "import"
        }
    }
    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
end

function config.zen_mode() require('zen-mode').setup {} end

function config.twilight() require('twilight').setup {} end

return config