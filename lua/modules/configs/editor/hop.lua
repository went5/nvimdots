return function()
	require("modules.utils").load_plugin("hop", { keys = "etovxqpdygfblzhckisuran" })

	local keymap = vim.keymap.set
	keymap('n', 'F', '<cmd>HopWord<cr>')
	keymap('v', 'F', '<cmd>HopWord<cr>')
	keymap('n', 'f', '<cmd>HopChar1CurrentLine<cr>')
	keymap('v', 'f', '<cmd>HopChar1CurrentLine<cr>')
end
