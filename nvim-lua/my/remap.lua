-- Toggle :set paste
vim.keymap.set("n", "<leader>o", ":set paste!<CR>")
-- allows you to type input to switch buffers while showing list of buffers
vim.keymap.set("n", "<leader>l", ":ls<CR>:b<space>")

-- Courtesies of ThePrimeagen, didnt know there's a way to remap keys in
-- insert mode.
-- In visual mode vertical edit (C-v visual mode), we normally need to
-- press the <Esc> key to effect the changes across multiple lines.
-- This allows us to use <C-c> to achieve the same effect
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Open tabs using leader key and digits
-- From: https://vim.fandom.com/wiki/Alternative_tab_navigation
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")

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

-- When using 'n' and 'N' for next / previous search term, use zz to
-- centralize the next result, then zv to open enough folds to make the
-- line with the search text visible
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- In visual mode, use J to move currently highlighted text down by 1 line.
-- Works on multiple lines
-- :m '>+1<CR> does the move and goes back to normal mode
-- gv goes to visual mode and selects the previously highlighted block
-- = indents the block and goes back to normal mode
-- gv selects the block again to allow reuse of the keymap
-- The downside of this comes when you want to undo the move. It requires
-- one 'u' for each line moved
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Use zz to centralize the current line after scrolling half page
-- downwards or upwards
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Use: highlight over some text to replace it with text in the " register.
-- The deleted text goes into the "_ register (the void register), so the
-- contents of the " register is not changed.
-- Without this, the contents of the " register would be changed to that
-- of the deleted text
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Use <leader>y followed by some motion to yank text into system clipboard.
-- We may be able to remove the xclip stuff with this...
-- TODO: Try these on Mac
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
-- The Y is similar to the above but yanks 1 entire line (including the end of
-- line character)
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete text but send them to the "_ void register so they do not override
-- contents of the " register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Make current file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>")

if (vim.fn.has("Linux"))
then
  -- Some shortcuts to work with the system clipboard.
  vim.keymap.set("n", "<leader>c", ":call system('xclip -sel clip', @\")<CR>")
  vim.keymap.set("n", "<leader>x", ":.w ! xclip -sel clip<CR><CR>dd")
  -- The <leader>yy wont work due to shadowing above
  --vim.keymap.set("n", "<leader>yy", ":.w ! xclip -sel clip<CR><CR>")
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
