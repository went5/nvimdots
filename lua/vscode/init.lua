vim.notify('hello-vscode')

--require("core.pack")
require("core.options")
-- key
vim.g.mapleader = " "
--vim.keymap.set('n', '<Leader>H','<cmd>noh<cr>')

-- no leader
vim.keymap.set('x', 'gc', '<Plug>VSCodeCommentary', {})
vim.keymap.set('n', 'gc', '<Plug>VSCodeCommentary', {})
vim.keymap.set('o', 'gc', '<Plug>VSCodeCommentary', {})
vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})

-- move
vim.keymap.set("n", "<leader>1",'<Cmd>call VSCodeNotify("workbench.action.focusFirstEditorGroup")<cr>')
vim.keymap.set("n", "<leader>2",'<Cmd>call VSCodeNotify("workbench.action.focusSecondEditorGroup")<cr>')

-- lsp
vim.keymap.set("n", "<leader>ld",'<Cmd>call VSCodeNotify("editor.action.revealDefinition")<cr>')
vim.keymap.set("n", "<leader>lg",'<Cmd>call VSCodeNotify("editor.action.revealDeclaration")<cr>')
vim.keymap.set("n", "<leader>lr",'<Cmd>call VSCodeNotify("editor.action.rename")<cr>')

--vim.keymap.set("n", "<leader>ld",'<cmd>lua vim.lsp.buf.definition()<cr>')
vim.keymap.set("n", "<leader>lr",'<Cmd>call VSCodeNotify("editor.action.goToReferences")<cr>')
vim.keymap.set("n", "<leader>la",'<Cmd>call VSCodeNotify("C_Cpp.SwitchHeaderSource)<cr>')

-- +Window
vim.keymap.set("n", "<leader>w/",'<Cmd>call VSCodeNotify("workbench.action.splitEditor")<cr>')
vim.keymap.set("n", "<leader>wd",'<Cmd>call VSCodeNotify("workbench.action.closeEditorsInGroup")<cr>')

-- +in file
vim.keymap.set("n", "<leader>ls",'<Cmd>call VSCodeNotify("workbench.action.gotoSymbol)<cr>') --symbol :をつけると関数絞り


-- +other file find
vim.keymap.set("n", "<leader>Fg",'<Cmd>call VSCodeNotify("workbench.action.findInFiles")<cr>') --grep
vim.keymap.set("n", "<leader>Ff",'<Cmd>call VSCodeNotify("workbench.action.quickOpen")<cr>') -- find file in project
vim.keymap.set("n", "<leader>FI",'<Cmd>call VSCodeNotify("workbench.action.showAllSymbols")<cr>')

-- buffer
--vim.keymap.set("n", "<leader>bl",'<Cmd>call VSCodeNotify("workbench.action.quickOpen")<cr>')
vim.keymap.set("n", "<leader>bl",'<Cmd>call VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")<cr>')
vim.keymap.set("n", "<leader>bL",'<Cmd>call VSCodeNotify("workbench.action.showEditorsInActiveGroup")<cr>')
vim.keymap.set("n", "<leader>bd",'<Cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<cr>')
vim.keymap.set("n", "<leader>bu",'<Cmd>call VSCodeNotify("workbench.action.reopenClosedEditor")<cr>')
vim.keymap.set("n", "<leader>bn",'<Cmd>call VSCodeNotify("workbench.action.nextEditor")<cr>')
vim.keymap.set("n", "<leader>bp",'<Cmd>call VSCodeNotify("workbench.action.previousEditor")<cr>')
vim.keymap.set("n", "<leader>bs",'<Cmd>call VSCodeNotify("workbench.action.files.newUntitledFile")<cr>')


-- open
vim.keymap.set("n", "<leader>oe",'<Cmd>!explorer .<cr>')
--vim.keymap.set("n", "<leader>on","<Cmd>!nvim --server \\\\.\\pipe\\nvim-pipe --remote-send ':e %:p'<cr>")

-- copy
vim.keymap.set("n", "<leader>Cc",'<Cmd>call VSCodeNotify("vspacecode.copyPath")<cr>')

-- quit
vim.keymap.set("n", "<leader>qr",'<Cmd>call VSCodeNotify("workbench.action.reloadWindow")<cr>')

