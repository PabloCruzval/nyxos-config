local map = vim.keymap.set

--- Telescope

map({ "n", "v" }, "<leader>tf", "<cmd> Telescope find_files <CR>", { desc = "Telescope: Open Files" })
map({ "n", "v" }, "<leader>tc", "<cmd> Telescope commands <CR>", { desc = "Telescope: Open Commands" })
map({ "n", "v" }, "<leader>tr", "<cmd> Telescope oldfiles <CR>", { desc = "Telescope: Open Oldfiles" })
map({ "n", "v" }, "<leader>tb", "<cmd> Telescope buffers <CR>", { desc = "Telescope: Open Buffers" })
map({ "n", "v" }, "<leader>tt", "<cmd> Telescope live_grep <CR>", { desc = "Telescope: Find Text" })

--- LSP
map("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP: Hover" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "LSP: Diagnostic" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename" })

--- Debugger
map("n", "<leader>do", '<cmd>lua require("dapui").open()<CR>', {})
map("n", "<leader>dx", '<cmd>lua require("dapui").close()<CR>')
map("n", "<leader>dt", '<cmd>lua require("dap").toggle_breakpoint()<CR>', { desc = "Dap: Toogle Breakpoint" })
map("n", "<leader>dc", '<cmd>lua require("dap").continue()<CR>', { desc = "Dap: Continue" })

--- MarkDown

--- Formatting
map("n", "<leader>lf", function()
	vim.cmd("lua vim.lsp.buf.format()")
	vim.cmd("w")
end, { desc = "LSP: Format" })

--- Comment
map("n", "<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current() <CR>', { desc = "Toggle Comment" })
map(
	"v",
	"<leader>/",
	'<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
	{ desc = "Toggle Comment" }
)

--- nvim-surround
map("n", "<leader>s(", "ysiw(", { noremap = false, desc = "Surround: Inner Word" })
