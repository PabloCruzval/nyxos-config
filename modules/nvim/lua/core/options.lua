--- Define el estilo 'tree' como predeterminado para el explorador
vim.cmd("let g:netrw_liststyle = 3")

--- Map leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Left numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2 -- Ancho de la columna de numeros.
vim.o.conceallevel = 2 -- Oculta parcialmente ciertos caracteres en los archivos.
vim.opt.fillchars = { eob = " " } -- Remueve los ~ de la columna.

--- Tabs
vim.o.tabstop = 3
vim.o.softtabstop = 3
vim.o.shiftwidth = 3

--- Set theme
vim.cmd([[colorscheme kanagawa]])

--- Set spell
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.spelllang = "es_es"
		vim.opt_local.spell = true
	end,
})
