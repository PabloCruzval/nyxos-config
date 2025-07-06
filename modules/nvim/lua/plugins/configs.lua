--- Mason & Lsp
local mason = function()
	require("mason").setup()
end

local mason_lspconfig = function()
	-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls" },
		automatic_enable = true,
	})
end

local nvim_cmp = function()
	local cmp = require("cmp")
	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
		}),
	})
end

--- Neo Tree
local neotree = function()
	require("neo-tree").setup({
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
			},
		},
	})
end

--- Debugger

local nvim_dap = function()
	require("mason-nvim-dap").setup({
		ensure_installed = { "python" },
		automatic_installation = true,
		handlers = {},
	})
	require("dapui").setup()
end
--- Linter & Formatter

local none_ls = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
			require("none-ls.diagnostics.eslint"),
		},
	})
end

local conform = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			svelte = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			-- markdown = { "prettier" },
			graphql = { "prettier" },
			liquid = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black", "autopep8" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		})
	end, { desc = "Format file or range (in visual mode)" })
end

--- Treesitter
local treesitter = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"json",
			"python",
			"javascript",
			"typescript",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
		},

		highlight = {
			enable = true,
			use_languagetree = true,
			disbled = { "latex" },
		},

		indent = { enable = true },

		auto_install = true,
	})
end

--- Alpha
local alpha = function()
	local alpha_dashboards_headers = require("dashboards")
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	local function alpha_format_text(text)
		return {
			type = "text",
			val = text,
			opts = { hl = "NvimDashColor", shrink_margin = false, position = "center" },
		}
	end

	local function format_text(text)
		local formated_text = {}
		for _, line in ipairs(text) do
			table.insert(formated_text, alpha_format_text(line))
		end
		return formated_text
	end

	dashboard.section.header.type = "group"
	dashboard.section.header.val = format_text(alpha_dashboards_headers)

	dashboard.section.buttons.val = {
		dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
		dashboard.button("f", "  Find File", "<cmd> Telescope find_files <CR>"),
		dashboard.button("r", "  Recently Opened Files", ":Telescope oldfiles<CR>"),
		dashboard.button("q", "󰩈  Exit", ":qa<CR>"),
	}

	alpha.setup(dashboard.opts)
end

--- Telescope
local telescope_ui_select = function()
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})
	require("telescope").load_extension("ui-select")
end

local lualine = function()
	require("lualine").setup()
end

local obsidian = function()
	return {
		workspaces = {
			{
				name = "Home",
				path = "/home/nyx/Obsidian/Home/",
			},
		},
		completation = {
			nvim_cmp = true,
			min_chars = 2,
		},
		notes_subdir = "zLimbo",
		new_notes_location = "zLimbo",
		attachments = {
			img_folder = "zFiles",
		},
		daily_notes = {
			template = "note",
		},
		mappings = {
			["<leader>oo"] = {
				action = function()
					vim.cmd("ObsidianOpen")
				end,
				opts = { buffer = true, desc = "Obsidian: Open Obsidian" },
			},
			-- "Obsidian follow"
			["<leader>of"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true, desc = "Obsidian Follow" },
			},
			-- Toggle check-boxes "obsidian done"
			["<leader>od"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true, desc = "Toggle checkbox" },
			},
			-- Create a new note
			["<leader>onn"] = {
				action = function()
					vim.cmd("ObsidianNew")
				end,
				opts = { desc = "Create a new note" },
			},
			["<leader>ont"] = {
				action = function()
					return require("obsidian").util.insert_template("Newsletter-Issue")
				end,
				opts = { buffer = true },
			},
		},
		-- Function to generate frontmatter for notes
		note_frontmatter_func = function(note)
			-- This is equivalent to the default frontmatter function.
			local out = { id = note.id, aliases = note.aliases, tags = note.tags }
			-- `note.metadata` contains any manually added fields in the frontmatter.
			-- So here we just make sure those fields are kept in the frontmatter.
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,
		-- Function to generate note IDs
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
		-- Settings for templates
		templates = {
			subdir = "zTemplates", -- Subdirectory for templates
			date_format = "%Y-%m-%d-%a", -- Date format for templates
			gtime_format = "%H:%M", -- Time format for templates
			tags = "", -- Default tags for templates
		},
	}
end

local ibl = function()
	require("ibl").setup({
		indent = {
			char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
		},
		scope = {
			show_start = false,
			show_end = false,
		},
	})
	-- disable indentation on the first level
	-- local hooks = require("ibl.hooks")
	-- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
	-- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
end

local gits = function()
	require("gitsigns").setup({
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Git: Siguiente cambio (hunk)" })

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Git: Cambio anterior (hunk)" })

			-- Actions
			map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Git: Agregar hunk" })
			map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Git: Revertir hunk" })

			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git: Agregar hunk seleccionado" })

			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git: Revertir hunk seleccionado" })

			map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Git: Agregar todo el buffer" })
			map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Git: Revertir todo el buffer" })

			map("n", "<leader>gh", gitsigns.preview_hunk, { desc = "Git: Previsualizar hunk" })
			map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "Git: Previsualizar hunk en línea" })

			map("n", "<leader>gb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "Git: Blame en línea" })

			map("n", "<leader>gd", gitsigns.diffthis, { desc = "Git: Diff con HEAD" })

			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end, { desc = "Git: Diff con último commit" })

			map("n", "<leader>gQ", function()
				gitsigns.setqflist("all")
			end, { desc = "Git: Enviar todos los hunks al quickfix" })

			map("n", "<leader>gq", gitsigns.setqflist, { desc = "Git: Enviar hunks actuales al quickfix" })

			-- Toggles
			map("n", "<leader>gbb", gitsigns.toggle_current_line_blame, { desc = "Git: Alternar blame línea actual" })
			map("n", "<leader>gww", gitsigns.toggle_word_diff, { desc = "Git: Alternar diff por palabra" })

			-- Text object
			map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Git: Seleccionar hunk" })
		end,
	})
end

return {
	mason = mason,
	mason_lspconfig = mason_lspconfig,
	nvim_cmp = nvim_cmp,
	nvim_dap = nvim_dap,
	none_ls = none_ls,
	treesitter = treesitter,
	telescope_ui_select = telescope_ui_select,
	lualine = lualine,
	obsidian = obsidian,
	alpha = alpha,
	neotree = neotree,
	conform = conform,
	ibl = ibl,
	gits = gits,
}
