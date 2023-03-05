-- Toggle :set paste
vim.keymap.set("n", "<leader>o", ":set paste!<CR>")
-- allows you to type input to switch buffers while showing list of buffers
vim.keymap.set("n", "<leader>l", ":ls<CR>:b<space>")

-- Open tabs using leader key and digits
-- From: https://vim.fandom.com/wiki/Alternative_tab_navigation
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")

-- Delete buffer without closing window
-- From: https://stackoverflow.com/a/8585343
vim.keymap.set("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<CR>")

--" Window switching shortcuts, including for terminal mode.
--" From Modern Vim by Drew Neil
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")

-- From Practical Vim (2nd edition), Tip 87: Search for the Current Visual Selection
function VSetSearch(direction)
  vim.cmd("let temp = @s")
  -- We could not figure out how to get the current visual mode selection
  -- using Lua alone. Hence we use the vim to run the normal mode gv"sy
  -- to yank the visual selection into register 's'
  vim.cmd("normal gv\"sy")
  local s = vim.fn.getreg("s")
  vim.cmd("let @s = temp")
  local searchString = string.gsub(
    string.gsub(
      string.gsub(
        string.gsub(s, "\\", "\\\\"),
        "/", "\\/"
      ),
      "?", "\\?"),
    "\n", "\\n"
  )
  -- The \\V is to do a literal search instead of a regex search
  vim.cmd(direction .. "\\V" .. searchString)
end

-- About: Select some text in visual mode, press * or # to search for it.
-- Explanation: when the colon character is pressed with a visual selection, it
-- will insert the '<,'> in the EX mode text buffer. The <C-u> is used to erase
-- that. Source: https://stackoverflow.com/a/13831705
--
-- We then use lua to execute the VSetSearch function.
-- The reason why we are not using a pure Lua function here is because
-- we cannot figure out how to "exit Visual mode" using Lua. Somehow
-- the visual selection before the current one is used for the search
vim.keymap.set("x", "*", ":<C-u>lua VSetSearch('/')<CR><CR>")
vim.keymap.set("x", "#", ":<C-u>lua VSetSearch('?')<CR><CR>")
-- END OF From Practical Vim (2nd edition), Tip 87: Search for the Current Visual Selection

if (vim.fn.has("Linux"))
then
  -- Some shortcuts to work with the system clipboard.
  vim.keymap.set("n", "<leader>c", ":call system('xclip -sel clip', @\")<CR>")
  vim.keymap.set("n", "<leader>x", ":.w ! xclip -sel clip<CR><CR>dd")
  vim.keymap.set("n", "<leader>yy", ":.w ! xclip -sel clip<CR><CR>")
  vim.keymap.set("n", "<leader>pp", ":r ! xclip -sel clip -o<CR>")
end

if (vim.fn.has('macunix'))
then
  -- Some shortcuts to work with the system clipboard.
  vim.keymap.set("n", "<leader>c", ":call system('pbcopy', @\")<CR>")
  vim.keymap.set("n", "<leader>x", ":.w ! pbcopy<CR><CR>dd")
  vim.keymap.set("n", "<leader>yy", ":.w ! pbcopy<CR><CR>")
  vim.keymap.set("n", "<leader>pp", ":r ! pbpaste<CR>")
end

----- Plugin configuration

-- Press Ctrl-p to start FZF for fuzzy file search, same as typing :FZF
vim.keymap.set("n", "<C-p>", ":<C-u>FZF<CR>")

-- Toggle NERDTree open/close
vim.keymap.set("n", "<leader>nt", ":NERDTreeToggle<CR>")
