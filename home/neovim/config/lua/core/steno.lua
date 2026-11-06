vim.filetype.add({ extension = { steno = "steno" } })

--
-- Paths (Adjust these to your actual file locations)
local word_list_path = vim.fn.expand("~/steno-dictionary/learning/16k-full.txt")
local state_file_path = vim.fn.expand("~/.cache/steno_last_index.txt")

-- Helper to read/write the current index
local function get_index()
    local f = io.open(state_file_path, "r")
    if not f then return 1 end
    local content = f:read("*all")
    f:close()
    return tonumber(content) or 1
end

local function save_index(index)
    local f = io.open(state_file_path, "w")
    if f then
        f:write(tostring(index))
        f:close()
    end
end

-- Helper to get word from list at specific index
local function get_word_at_index(index)
    local i = 1
    for line in io.lines(word_list_path) do
        -- Matches the word before the large frequency number
        local word = line:match("^(%S+)")
        if i == index then return word end
        i = i + 1
    end
    return nil
end

local function copy_to_clipboard(text)
    if text and text ~= "" then
        vim.fn.setreg('+', text)
    end
end

-- Builds a vim search pattern that treats `word` literally
local function make_vim_pattern(word)
    return "^" .. vim.fn.escape(word, "\\/.*$^~[]") .. ":"
end

-- Checks (without opening) whether a file contains a line starting with "word:"
local function file_contains_word(filepath, word)
    local f = io.open(filepath, "r")
    if not f then return false end
    local lua_pattern = "^" .. word:gsub("([^%w])", "%%%1") .. ":"
    for line in f:lines() do
        if line:match(lua_pattern) then
            f:close()
            return true
        end
    end
    f:close()
    return false
end

-- Scans all .steno files in the current file's directory (excluding the
-- current file itself) for one containing the word. Returns the filepath
-- of the first match, or nil if none found.
local function find_word_in_directory(word)
    local dir = vim.fn.expand("%:p:h")
    local current_file = vim.fn.expand("%:p")
    local files = vim.fn.globpath(dir, "*.steno", false, true)

    for _, file in ipairs(files) do
        if file ~= current_file and file_contains_word(file, word) then
            return file
        end
    end
    return nil
end

local function navigate_steno_word(direction)
    local index = get_index()
    index = math.max(1, index + direction)

    local word = get_word_at_index(index)
    if not word then
        print("End of word list reached.")
        return
    end

    local pattern = make_vim_pattern(word)

    -- 1. Try the current buffer first
    local target_pos = vim.fn.search(pattern, "w")
    if target_pos > 0 then
        copy_to_clipboard(word)
        save_index(index)
        vim.cmd("normal! zz")
        print("Word [" .. index .. "]: " .. word)
        return
    end

    -- 2. Not found here: look through other .steno files in this directory
    local found_file = find_word_in_directory(word)
    if found_file then
        vim.cmd("edit " .. vim.fn.fnameescape(found_file))
        vim.fn.search(pattern, "w")
        copy_to_clipboard(word)
        save_index(index)
        vim.cmd("normal! zz")
        print("Word [" .. index .. "]: " .. word .. "  (found in " .. vim.fn.fnamemodify(found_file, ":t") .. ")")
        return
    end

    -- 3. Not found anywhere: do NOT advance, just warn
    vim.notify(
        "Word '" .. word .. "' not found in this file or any .steno file in this directory.",
        vim.log.levels.WARN
    )
end

local function lookup_word_definition()
  -- Get word under cursor
  local raw_word = vim.fn.expand('<cword>')
  if not raw_word or raw_word == '' then
    vim.notify("No word found under cursor", vim.log.levels.WARN)
    return
  end

  -- Strip non-alphanumeric characters at the start/end
  local word = raw_word:match("^%W*(.-)%W*$")
  if not word or word == '' then
    vim.notify("Invalid word", vim.log.levels.WARN)
    return
  end

  local url = "https://api.dictionaryapi.dev/api/v2/entries/en/" .. word

  -- Asynchronous HTTP request using curl
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local response_data = ""

  local handle
  handle = vim.loop.spawn("curl", {
    args = { "-s", url },
    stdio = { nil, stdout, stderr }
  }, function(code, signal)
    stdout:read_stop()
    stderr:read_stop()
    stdout:close()
    stderr:close()
    handle:close()

    vim.schedule(function()
      if code ~= 0 then
        vim.notify("Failed to fetch dictionary data", vim.log.levels.ERROR)
        return
      end

      -- Parse JSON
      local ok, decoded = pcall(vim.json.decode, response_data)
      if not ok or not decoded or type(decoded) ~= "table" then
        vim.notify("Error parsing API response", vim.log.levels.ERROR)
        return
      end

      -- Check if word was not found (API returns a table with a title field on error)
      if decoded.title then
        vim.notify("No definitions found for '" .. word .. "'", vim.log.levels.WARN)
        return
      end

      -- Process output lines
      local lines = {}
      local all_antonyms = {}

      table.insert(lines, " Word: " .. word)
      table.insert(lines, string.rep("─", 40))

      for _, entry in ipairs(decoded) do
        if entry.meanings then
          for _, meaning in ipairs(entry.meanings) do
            -- Part of speech header
            local pos = meaning.partOfSpeech and meaning.partOfSpeech:upper() or "GENERAL"
            table.insert(lines, "[" .. pos .. "]")

            -- Collect definitions
            if meaning.definitions then
              for idx, def in ipairs(meaning.definitions) do
                table.insert(lines, string.format(" %d. %s", idx, def.definition))

                -- Collect antonyms at the definition level
                if def.antonyms then
                  for _, ant in ipairs(def.antonyms) do
                    table.insert(all_antonyms, ant)
                  end
                end
              end
            end

            -- Collect antonyms at the meaning level
            if meaning.antonyms then
              for _, ant in ipairs(meaning.antonyms) do
                table.insert(all_antonyms, ant)
              end
            end

            table.insert(lines, "")
          end
        end
      end

      -- Deduplicate antonyms
      local unique_antonyms = {}
      local hash = {}
      for _, ant in ipairs(all_antonyms) do
        if not hash[ant] then
          table.insert(unique_antonyms, ant)
          hash[ant] = true
        end
      end

      -- Display antonyms if found
      if #unique_antonyms > 0 then
        table.insert(lines, string.rep("─", 40))
        table.insert(lines, " ANTONYMS:")
        table.insert(lines, " " .. table.concat(unique_antonyms, ", "))
      end

      -- Create floating window
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Calculate window dimensions
      local width = math.min(80, math.max(40, vim.o.columns - 10))
      local height = math.min(#lines, math.floor(vim.o.lines * 0.6))
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded",
        title = " Dictionary ",
        title_pos = "center",
      }

      local win = vim.api.nvim_open_win(buf, true, opts)

      -- Close floating window with <Esc> or 'q'
      vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, silent = true })
      vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = buf, silent = true })
    end)
  end)

  vim.loop.read_start(stdout, function(err, data)
    if data then response_data = response_data .. data end
  end)
end

-- Keymap shortcut (e.g., <leader>K in Normal mode)
vim.keymap.set('n', '<leader>K', lookup_word_definition, { desc = "Look up word definition & antonyms" })

-- Create an Autocmd to only map these in .steno files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "steno",
    callback = function()
        local opts = { buffer = true, silent = true }

        vim.keymap.set("n", "t", function() navigate_steno_word(1) end, opts)
        vim.keymap.set("n", "T", function() navigate_steno_word(-1) end, opts)
        vim.keymap.set("n", "H", function() lookup_word_definition() end, opts)
    end,
})

-- vim.filetype.add({ extension = { steno = "steno" } })
-- --
-- -- Paths (Adjust these to your actual file locations)
-- local word_list_path = vim.fn.expand("~/steno-dictionary/data-source/words-16k.txt")
-- local state_file_path = vim.fn.expand("~/.cache/steno_last_index.txt")
--
-- -- Helper to read/write the current index
-- local function get_index()
--     local f = io.open(state_file_path, "r")
--     if not f then return 1 end
--     local content = f:read("*all")
--     f:close()
--     return tonumber(content) or 1
-- end
--
-- local function save_index(index)
--     local f = io.open(state_file_path, "w")
--     if f then
--         f:write(tostring(index))
--         f:close()
--     end
-- end
--
-- -- Helper to get word from list at specific index
-- local function get_word_at_index(index)
--     local i = 1
--     for line in io.lines(word_list_path) do
--         -- Matches the word before the large frequency number
--         local word = line:match("^(%S+)")
--         if i == index then return word end
--         i = i + 1
--     end
--     return nil
-- end
--
-- local function copy_to_clipboard(text)
--     if text and text ~= "" then
--         vim.fn.setreg('+', text)
--     end
-- end
--
-- local function navigate_steno_word(direction)
--     local index = get_index()
--     index = math.max(1, index + direction)
--     
--     local word = get_word_at_index(index)
--     if not word then
--         print("End of word list reached.")
--         return
--     end
--
--     copy_to_clipboard(word)
--
--     -- Search pattern: start of line, the word, followed by a colon
--     local pattern = "^" .. word .. ":"
--     
--     -- Attempt to find the word in the current buffer
--     local target_pos = vim.fn.search(pattern, "w")
--
--     if target_pos > 0 then
--         save_index(index)
--         vim.cmd("normal! zz")
--         print("Word [" .. index .. "]: " .. word)
--     else
--         print("Word '" .. word .. "' not found in this file. Skipping...")
--         -- Optionally auto-skip to next if not found:
--         save_index(index)
--         navigate_steno_word(direction)
--     end
-- end
--
-- -- Create an Autocmd to only map these in .steno files
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "steno",
--     callback = function()
--         local opts = { buffer = true, silent = true }
--         
--         vim.keymap.set("n", "t", function() navigate_steno_word(1) end, opts)
--         vim.keymap.set("n", "T", function() navigate_steno_word(-1) end, opts)
--         -- vim.keymap.set("n", "H", function() copy_paragraph_to_file() end, opts)
--
--     end,
-- })

-- local function copy_paragraph_to_file()
--   local file_path = vim.fn.expand("/home/dev/steno-dictionary/data-source/processed-words.txt")
--   vim.cmd('normal! "yyap')
--   
--   local yanked_lines = vim.fn.getreg('y', 1, true)
--
--   -- Filter: only lines containing ':', and take only the portion before ':'
--   local new_lines = {}
--   for _, line in ipairs(yanked_lines) do
--     local before_colon = line:match("^([^:]+):")
--     if before_colon then
--       table.insert(new_lines, before_colon)
--     end
--   end
--
--   -- Read the target file lines
--   local file_lines = {}
--   if vim.fn.filereadable(file_path) == 1 then
--     file_lines = vim.fn.readfile(file_path)
--   end
--
--   -- Append existing file lines onto our new lines array
--   for _, line in ipairs(file_lines) do
--     table.insert(new_lines, line)
--   end
--
--   vim.fn.writefile(new_lines, file_path)
-- end
--
-- -- Keymap definition (Change '<leader>cp' and the file path to whatever you like)
-- vim.keymap.set('n', '<leader>cp', function()
--   copy_paragraph_to_file("~/notes.md")
-- end, { desc = "Copy paragraph under cursor to top of notes file" })
