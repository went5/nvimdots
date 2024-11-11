    -- call HelloWorld()
    vim.cmd [[ 
    function! HelloWorld()
        execute 'lua print("hello world")'
    endfunction
    ]]
    vim.cmd([[
    function! RunPythonFile(filename)
        let l:config_path = stdpath('config')
        let l:python_file_path = l:config_path . '/python' . '/' . a:filename
        execute '!python ' . l:python_file_path
    endfunction
    ]])
    
    vim.cmd([[
    function! OpenVS2022WithCurrentFileAndLine()
        let l:config_path = stdpath('config')
        let l:python_file_path = l:config_path . '/python/open_vs2022.py'
        let l:current_file_path = expand('%:p')  " 現在のファイルの絶対パスを取得
        let l:current_line_number = line('.')    " 現在のカーソルの行番号を取得
        let l:current_column_number = col('.')
        execute 'silent !python ' . l:python_file_path . ' ' . l:current_file_path . ' ' . l:current_line_number . ' ' . l:current_column_number
    endfunction
    ]])

     -- vsだったらpsを開く
    vim.cmd [[
    function! ToggleProgFile()
        " 現在のファイルのパスを取得
        let current_file = expand('%:p')
        " ファイルの拡張子に基づいて処理を分岐
        if current_file =~ '\.ps$'
            " .psファイルの場合、.vsファイルに切り替え
            let target_file = substitute(current_file, '\.ps$', '.vs', '')
        elseif current_file =~ '\.fs$'
            " .fsファイルの場合、.vsファイルに切り替え
            let target_file = substitute(current_file, '\.fs$', '.vs', '')
        elseif current_file =~ '\.vs$'
            " .vsファイルの場合、.psファイルを試みる
            let ps_file = substitute(current_file, '\.vs$', '.ps', '')
            " .psファイルが存在すればそれを開く、そうでなければ.fsファイルを試みる
            if filereadable(ps_file)
                let target_file = ps_file
            else
                let fs_file = substitute(current_file, '\.vs$', '.fs', '')
                if filereadable(fs_file)
                    let target_file = fs_file
                endif
            endif
        endif
    
        " ターゲットファイルが存在する場合にのみ開く
        if exists('target_file') && filereadable(target_file)
            execute 'edit ' . target_file
        else
            execute 'ClangdSwitchSourceHeader'
        endif
    endfunction    
    ]]

    function GetViewPath()
        local filepath = vim.fn.expand('%:p') -- 現在のファイルの絶対パスを取得
        local viewpath = filepath:gsub(":", "=-"):gsub("\\", "=+"):gsub("/", "=+") .. '='
        return "C:\\Users\\" .. vim.fn.expand("$USERNAME") .. "\\AppData\\Local\\nvim-data\\view\\" .. viewpath
    end
    
    -- ビューが存在するかどうかを確認する関数
    function ViewExists()
        local viewpath = GetViewPath()
        return vim.fn.filereadable(viewpath) == 1
    end

    function load_view_if_exists()
        if ViewExists() then
            vim.cmd('loadview')
        end
    end

    -- lower to camel
    function snake_to_camel(s)
        return s:gsub("_(%w)", function(x) return x:upper() end)
    end

    function camel_to_snake(s)
        return s:gsub("(%l)(%u)", function(a, b) return a .. "_" .. b:lower() end)
    end
   
    function toggle_case()
        -- 現在のカーソル位置を保存
        local cur_pos = vim.fn.getpos(".")
    
        -- Visual modeでの選択範囲を取得
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
    
        -- 選択範囲の文字列を取得
        local lines = vim.api.nvim_buf_get_lines(0, start_pos[2]-1, end_pos[2], false)
        if #lines == 1 then
            lines[1] = lines[1]:sub(start_pos[3], end_pos[3]-1)
        else
            lines[1] = lines[1]:sub(start_pos[3])
            lines[#lines] = lines[#lines]:sub(1, end_pos[3]-1)
        end
        local selection = table.concat(lines, "\n")
    
        -- 文字列を変換
        local converted
        if selection:find("_") then
            converted = snake_to_camel(selection)
        else
            converted = camel_to_snake(selection)
        end
    
        -- 変換後の文字列を選択範囲に適用
        vim.api.nvim_buf_set_text(0, start_pos[2]-1, start_pos[3]-1, end_pos[2]-1, end_pos[3]-1, {converted})
    
        -- カーソル位置を元に戻す
        vim.fn.setpos(".", cur_pos)
    end
    -------------------------

