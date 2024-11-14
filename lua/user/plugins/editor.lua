local editor = {}

editor["Badhi/nvim-treesitter-cpp-tools"] = {
    lazy = true,
    cmd = {"TSCppDefineClassFunc","TSCppMakeConcreteClass","TSCppRuleOf3","TSCppRuleOf5"},
    config = require("editor.nt-cpp-tools"),
    dependencies = {
        {"nvim-treesitter/nvim-treesitter"}
    }
}
editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}


return editor
