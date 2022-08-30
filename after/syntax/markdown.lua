-- also see:
-- https://github.com/neovim/neovim/blob/master/runtime/syntax/markdown.vim
-- https://github.com/neovim/neovim/blob/master/runtime/syntax/lsp_markdown.vim

vim.schedule(function()
	vim.cmd([[
		syn match markdownCheckboxComplete /\[x\]/ "conceal cchar=✓
		syn match markdownCheckboxTodo /\[ \]/ "conceal cchar=▢
		syn match markdownCheckboxIncomplete /\[\/\]/ "conceal cchar=▪
		syn match markdownCheckboxStar /\[\*\]/ "conceal cchar=★
		syn match markdownCheckboxCancelled /\[\-\]/ "conceal cchar=─
		syn match markdownCheckboxForward /\[\>\]/ "conceal cchar=›

		hi def link markdownCheckboxCancelled markdownCheckboxComplete
		hi def link markdownCheckboxForward markdownCheckboxComplete
		hi def link markdownCheckboxIncomplete markdownCheckboxComplete
		hi def link markdownCheckboxStar markdownCheckboxComplete
		hi def link markdownCheckboxTodo markdownCheckbox

		hi def link markdownCheckbox Question
		hi def link markdownCheckboxComplete LineNr
  ]])
end)
