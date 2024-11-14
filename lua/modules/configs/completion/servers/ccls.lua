local function get_binary_path_list(binaries)
	local path_list = {}
	for _, binary in ipairs(binaries) do
		local path = vim.fn.exepath(binary)
		if path ~= "" then
			table.insert(path_list, path)
		end
	end
	return table.concat(path_list, ",")
end

return function(options)
	require("lspconfig").ccls.setup({
		on_attach = options.on_attach,
		capabilities = vim.tbl_deep_extend("keep", { offsetEncoding = { "utf-16", "utf-8" } }, options.capabilities),
		init_options = {
			compilationDatabaseDirectory = "build"; -- 例: プロジェクトのビルドディレクトリ
			index = {
				threads = 12;
			};
			cache = {
				directory = "/tmp/ccls_cache"; -- キャッシュディレクトリの設定
			};
		},
		cmd = {
			"ccls",
			"--log-file=/tmp/ccls.log"; -- ログファイルの設定 (オプション)
		},
	})
end
