local function set_keymaps(maps, prefix)
    for key, map in pairs(maps) do
        local keys = prefix .. key
        if type(map[1]) == "string" then
            -- map[1]がコマンド文字列である場合、キーマッピングを設定
            vim.keymap.set("n", keys, map[1], { desc = map[2] })
        elseif type(map) == "table" and map.name then
            -- サブグループがある場合は再帰呼び出し
            set_keymaps(map, keys)
        end
    end
end

-- キーマッピングのテーブル
local keys = {
    ['k'] = { "<cmd>Telescope keymaps<cr>", "keymap list" },
    [' '] = { ":", "Command" },
    ['.'] = { '<cmd>cd %:h<cr>', 'Move Current Directory' },
    ['['] = {
        name = '+Profile',
        s = { ':profile start ~/ghq/github.com/went5/went5-setting-files/.neovim/profile.log<cr>:profile func *<cr>:profile file *<cr>',
            'profile start' },
        S = { ':profile pause<cr>', 'profile end' },
    },
    ["1"] = { ":winc W<cr>", "Move Left" },
    ["2"] = { ":winc w<cr>", "Move Right" },
    ['b'] = {
        name = '+Buffer',
        ['p'] = { ':bp<cr>', 'Prev Buffer' },
        ['n'] = { ':bn<cr>', 'Next Buffer' },
        ['l'] = { '<cmd>Telescope buffers<cr>', 'List Buffer' },
        ['d'] = { '<cmd>windo bd<cr>', 'Delete Other Buffer' },
    },
    ['B'] = {
        name = '+Build',
        c = { '<cmd>!g++ -g3 %:p<cr>', 'build a.exe' },
    },
    ['C'] = {
        name = '+Copy',
        ['f'] = { ':let @* = expand("%:t")<cr>', 'Filename' },
        ['p'] = { ':let @* = expand("%:p")<cr>', 'FullPath' },
        ['d'] = { ':let @* = expand("%:p:h")<cr>', 'Directory' },
        ['r'] = { ':let @* = expand("%:r")<cr>', 'FileName without extension' },
        ['e'] = { ':let @* = expand("%:e")<cr>', 'extension' },
    },
    -- m,c,sは予約済み
    ['d'] = {
        name = '+Debug',
        ['b'] = { '<cmd>DapToggleBreakpoint<cr>', 'Toggle Breakpoint' },
        ['B'] = { ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>',
            'Condition Breakpoint' },
        ['L'] = { '<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
            'Log Point Breakpoint' },
        ['r'] = { '<cmd>lua require("dap").repl.toggle()<CR>', 'Repl Toggle' },
        ['l'] = { '<cmd>lua require("dap").run_last()<CR>', 'Run Last' },
    },
    ["E"] = {
        name = "+Extension",
        ["a"] = {
            name = "+Aerial",
            ['o'] = { '<cmd>AerialOpen<cr>', 'Open' },
            ['O'] = { '<cmd>AerialOpen!<cr>', 'Open not Switch' },
            ['t'] = { '<cmd>AerialToggle<cr>', 'Toggle' },
        },
        -- ['l'] = {
        -- 	name = "+LineNote",
        -- 	['a'] = { '<cmd>LineNotesAdd<cr>', 'LineNotes Add' },
        -- 	['e'] = { '<cmd>LineNotesEdit<cr>', 'LineNotes Edit' },
        -- 	['p'] = { '<cmd>LineNotesPreview<cr>', 'LineNotes Preview' },
        -- 	['d'] = { '<cmd>LineNotesDelete<cr>', 'LineNotes Delete' },
        -- 	['n'] = { '<cmd>Telescope line_notes<cr>', 'LineNotes List' },
        -- 	['c'] = { '<cmd>Telescope line_notes_project<cr>', 'LineNotes Project' },
        -- },
        ['T'] = {
            name = '+TreeSitter',
            ['t'] = { '<cmd>TSToggle highlight<cr>' }
        },
    },
    ["f"] = {
        name = "+File",
        d = { '<cmd>DiffviewOpen', "DiffViewOpen" },
        D = { '<cmd>DiffviewClose', "DiffViewClose" },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format" },
        F = { '<cmd>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<cr>', "Find current buffer" },
       -- m = { '<cmd>Telescope aerial<cr>', "Find functions" },
        t = { '<cmd>Telescope treesitter<cr>', "Find Variables and Functions" },
        r = {
            name = 'replace',
            ['t'] = {':set expandtab<cr>:retab<cr>','Replace Tab to Space'}
        },
        s = { '<cmd>Telescope lsp_document_symbols<cr>', "Find Symbols" },
        ['w'] = { '<cmd>HopWord<cr>', 'HopWord' },
        ['/'] = { '<cmd>HopPattern<cr>', 'HopPattern' },
        ['l'] = { '<cmd>HopLine<cr>', 'HopLine' },
        ['L'] = { '<cmd>HopLineStart<cr>', 'HopLineStart' },
    },
    ["F"] = {
        name = "+Find File",
        ['0'] = { "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", "Find File CMD" },
        ['1'] = { "<cmd>Telescope find_files hidden=true search_dirs=../<cr>", "Find File Up 1" },
        ['2'] = { "<cmd>Telescope find_files hidden=true search_dirs=../../<cr>", "Find File Up 2" },
        b = { '<cmd>lua require("telescope").extensions.file_browser.file_browser({hidden=true})<cr>', "File Browser" },
        f = { '<cmd>Telescope frecency<cr>', 'Frecency' }, --よく使うファイルをみつける
        F = { '<cmd>lua require("telescope").extensions.frecency.frecency({ workspace = "CWD" })<cr>', 'Frecency CMD' }, --よく使うファイルをみつける
        o = { '<cmd>lua require("telescope.builtin").oldfiles()<cr>', 'OldFiles' }, -- ファイル内の文字列から探す
        s = { '<cmd>Telescope git_status', 'git status' }, -- ファイル内の文字列から探す
        ['p'] = { '<cmd>Telescope projects<cr>', 'Find Project' },
        n = { '<cmd>vim.api.nvim_command("enew")<cr>', 'New File' },
        g = {
            name = 'grep',
            ['1'] = { '<cmd>Telescope live_grep hidden=true search_dirs=../<cr>', 'Parent Dir grep' }, -- ファイル内の文字列から探す
            ['2'] = { '<cmd>Telescope live_grep hidden=true search_dirs=../../<cr>', 'Grandparent Dir grep' }, -- ファイル内の文字列から探す
            s = { '<cmd>Telescope grep_string<cr>', 'fzf grep' }, -- ファイル内の文字列から探す
            G = { '<cmd>Telescope live_grep_args hidden=true<cr>', 'grep args' }, -- 初期引数なしのgrep
            g = { '<cmd>Telescope live_grep hidden=true<cr>', 'live grep' }, -- ファイル内の文字列から探す
        },
    },
    ["G"] = {
        name = "+Git",
        c = { '<cmd>Telescope git_commits<cr>', 'Commits' }, -- ファイル内の文字列から探す
        s = { '<cmd>Telescope git_status<cr>', 'Status' }, -- ファイル内の文字列から探す
        ['d'] = { '<cmd>Gitsigns diffthis<cr>', 'diffthis' },
        ['n'] = { '<cmd>Gitsigns next_hunk<cr>', 'next hunk' },
        ['p'] = { '<cmd>Gitsignsprev_hunk<cr>', 'prev hunk' },
        ['l'] = { "<cmd>execute 'Git log -p -L ' . line('.') . ',' . line('.') . ':' . expand('%:p')<cr>", 'current line log' },
    },
    ['H'] = { '<cmd>noh<cr>', 'No highlight' },
    -- tは予約済み
    ['l'] = {
        name = '+LSP',
        ['d'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Definition' },
        ['k'] = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover' },
        ['h'] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature Help' },
        ['m'] = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
        ['A'] = { '<cmd>CodeActionMenu<cr>', 'Code Action' },
        ['a'] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
        ['r'] = { '<cmd>Telescope lsp_references<cr>', 'References' },
        ['R'] = { '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr><cmd>edit<cr>', 'Reload' },
        ['D'] = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
        ['p'] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to Prev Error" },
        ['n'] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to Next Error" },
        -- interface から実装へ
        ['i'] = { '<cmd>lua vim.lsp.buf.implementaion()<cr>', 'implementaion' },
    },
    ['L'] = {
        '<cmd>Lazy home<cr>', 'Home'
    },
    ["m"] = {
        name = "+Major",
        c = {
            name = "Clang",
            ['3'] = { '<cmd>TSCppRuleOf3<cr>', 'TSCppRuleOf3' },
            ['5'] = { '<cmd>TSCppRuleOf5<cr>', 'TSCppRuleOf5' },
            t = { '<cmd>ClangdSwitchSourceHeader<cr>', 'ToggleSourceOrHeader' },
            d = { '<cmd>TSCppDefineClassFunc<cr>', 'TSCppDefineClassFunc' },
            m = { '<cmd>TSCppMakeConcreteClass<cr>', 'TSCppMakeConcreteClass' },
        },
        p = {
            name = "Python",
            d = {':!python %<cr>','execute'},
            D = {':!poetry run python %<cr>','poetry-execute'},
            w = {':w !python<cr>','line-execute'},
            W = {':w !poetry run python<cr>','poerty-line-execute'},


        },
        t = { '<cmd>call ToggleProgFile()<cr>', 'ToggleFile' },
    },
    ['M'] = {
        name = "+Bookmarks",
        ['b'] = { '<cmd>BookmarkToggle<cr>', 'Toggle' },
        ['a'] = { '<cmd>BookmarkAnnotate<cr>', 'Annotate' },
        ['c'] = { '<cmd>BookmarkClear<cr>', 'Bookmark Clear' },
        ['C'] = { '<cmd>BookmarkClearAll<cr>', 'Bookmark Clear All' },
        ['s'] = { '<cmd>Telescope vim_bookmarks all<cr>', 'Show All Bookmark' },
    },
    ['o'] = {
        name = "+Open",
        ['s'] = { '<cmd>call OpenVS2022WithCurrentFileAndLine()<cr>', 'Visual Studio' },
        ['c'] = { "<cmd>execute '!code --goto ' . expand('%:p') . ':' . line('.') . ':' . col('.')<cr>", 'VSCode' },
        -- ['c'] = { "<cmd>!code --goto %:p: line('.')<cr>", 'VSCode' },
        ['e'] = { '<cmd>!explorer %:p:h<cr><cr>', 'Explorer' }
    },
    ['q'] = {
        name = '+Quit',
        ['r'] = { '<cmd>update<cr><cmd>luafile $MYVIMRC<cr><cr>', 'Reload Lua' },
    },
    ['s'] = {
        name = "+Session",
        ['s'] = { '<cmd>SaveSession<cr>', 'SaveSession' },
        ['r'] = { '<cmd>RestoreSession<cr>', 'SaveSession' },
    },
    ["t"] = {
        name = "+Toggle",
    },
    ["T"] = {
        name = "+Telescope",
        ["a"] = { "<cmd>Telescope autocommands<cr>", "autocommands" },
        ["h"] = { "<cmd>Telescope command_history<cr>", "command_history" },
        ["H"] = { "<cmd>Telescope search_history<cr>", "search_history" },
        ["j"] = { "<cmd>Telescope jumplist<cr>", "jumplist" },
        ["m"] = { "<cmd>Telescope marks<cr>", "marks" },
        ["n"] = { "<cmd>Noice telescope", "noice" },
        ["q"] = { "<cmd>Telescope quickfix<cr>", "quickfix" },
        ["r"] = { "<cmd>Telescope registers<cr>", "registers" },
        ["s"] = { "<cmd>Telescope spell_suggest<cr>", "spell_suggest" },
        ["t"] = { "<cmd>Telescope resume<cr>", "resume" },
    },
    ["v"] = {
        name = "+Visual",
        ["t"]  = {"<cmd>lua toggle_case()<cr>", "ToggleCase"}
    },
    ["w"] = {
        name = "+Window",
        ["/"] = { ":vs <cr>", "Split Vertical" },
        ["<"] = { ":vertical resize -30<cr>", "Decrease Vertical" },
        ["="] = { "<c-w>=", "Equally width and height" },
        [">"] = { ":vertical resize +30<cr>", "Increase Vertical" },
        ['b'] = { '<cmd>TroubleToggle<cr>', 'Trouble' },
        ["d"] = { ":close <cr>", "Close" },
        ["s"] = { "<cmd>Lspsaga outline<cr>", "Func Variable" },
        ['f'] = { ':NvimTreeToggle<cr>', 'NvimTreeToggle' },
        ['t'] = { ':lua require("toggleterm").toggle(1,12,vim.fn.getcwd())<cr>', 'ToggleTerm' },
        ['p'] = { '<cmd>lua require("dapui").toggle()<CR>', 'ToggleDapUI' },
    },
    ['Y'] = {
        "<cmd>Telescope yank_history<cr>", "YankHistory"
    },
    ['z'] = {
        name = "+Fold",
        ["z"] = { "<cmd>set foldmethod=indent<cr>", "create indent fold" }
    },
}

set_keymaps(keys, " ")


return vim.tbl_extend(
	"force",
	require("user.keymap.core"),
	require("user.keymap.completion").plug_map,
	require("user.keymap.editor"),
	require("user.keymap.lang"),
	require("user.keymap.tool"),
	require("user.keymap.ui")
)


return vim.tbl_extend(
	"force",
	require("user.keymap.core"),
	require("user.keymap.completion").plug_map,
	require("user.keymap.editor"),
	require("user.keymap.lang"),
	require("user.keymap.tool"),
	require("user.keymap.ui")
)
