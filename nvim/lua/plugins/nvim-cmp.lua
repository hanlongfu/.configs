return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			-- this plugin provides snippets of many langs
			dependencies = { "rafamadriz/friendly-snippets" },
			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",

		-- Adds other completion capabilities.
		--  nvim-cmp does not ship with all sources by default. They are split
		--  into multiple repos for maintenance purposes.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",

		-- If you want to add a bunch of pre-configured snippets,
		"rafamadriz/friendly-snippets",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- configure cmp
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },

			-- For an understanding of why these mappings were
			-- chosen, you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			mapping = cmp.mapping.preset.insert({
				-- Select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-Space>"] = cmp.mapping.complete({}),

				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})

		-- configure luasnip
		luasnip.config.setup({
			enable_autosnippets = true,
		})

		-- load vscode-style snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		local s = luasnip.snippet
		local t = luasnip.text_node
		local i = luasnip.insert_node
		local f = luasnip.function_node
		local c = luasnip.choice_node
		local d = luasnip.dynamic_node
		local r = luasnip.restore_node
		local fmta = require("luasnip.extras.fmt").fmta
		local fmt = require("luasnip.extras.fmt").fmt
		local rep = require("luasnip.extras").rep

		-- Enable LaTeX snippets in markdown files
		luasnip.filetype_extend("markdown", { "tex" })

		--- latex snippets
		luasnip.add_snippets("tex", {
			-- math environments
			s(
				"align",
				fmt(
					[[
					\begin{{align}}
							{} &= {} \\
							&= {}
					\end{{align}}]],
					{
						i(1),
						i(2),
						i(3),
					}
				)
			),

			s(
				"matrix",
				fmt(
					[[
					\begin{{{}}}
							{} & {} \\
							{} & {}
					\end{{{}}}]],
					{
						i(1, "matrix"),
						i(2),
						i(3),
						i(4),
						i(5),
						rep(1),
					}
				)
			),

			s(
				"cases",
				fmt(
					[[
					\begin{{cases}}
							{}, & \text{{{}}} \\
							{}, & \text{{{}}}
					\end{{cases}}]],
					{
						i(1),
						i(2, "if"),
						i(3),
						i(4, "otherwise"),
					}
				)
			),
			-- math operators and symbols
			s(
				"lim",
				fmt("\\lim_{{{} \\to {}}}", {
					i(1, "n"),
					i(2, "\\infty"),
				})
			),
			s(
				"sum",
				fmt("\\sum_{{{}}}^{{{}}}", {
					i(1, "n=1"),
					i(2, "\\infty"),
				})
			),

			s(
				"prod",
				fmt("\\prod_{{{}}}^{{{}}}", {
					i(1, "n=1"),
					i(2, "\\infty"),
				})
			),

			s(
				"int",
				fmt("\\int_{{{}}}^{{{}}}", {
					i(1, "a"),
					i(2, "b"),
				})
			),

			-- Common mathematical structures
			s(
				"set",
				fmt("\\{{{}\\}}", {
					i(1),
				})
			),

			s(
				"ceil",
				fmt("\\left\\lceil {} \\right\\rceil", {
					i(1),
				})
			),

			s(
				"floor",
				fmt("\\left\\lfloor {} \\right\\rfloor", {
					i(1),
				})
			),

			-- Theorems and proofs
			s(
				"thm",
				fmt(
					[[
					\begin{{theorem}}
						{}
				\end{{theorem}}]],
					{
						i(1),
					}
				)
			),

			s(
				"proof",
				fmt(
					[[
					\begin{{proof}}
							{}
					\end{{proof}}]],
					{
						i(1),
					}
				)
			),

			s(
				"lem",
				fmt(
					[[
				\begin{{lemma}}
						{}
				\end{{lemma}}]],
					{
						i(1),
					}
				)
			),

			-- Document sections
			s(
				"sec",
				fmt(
					[[
				\section{{{}}}
				{}]],
					{
						i(1),
						i(2),
					}
				)
			),

			s(
				"subsec",
				fmt(
					[[
				\subsection{{{}}}
				{}]],
					{
						i(1),
						i(2),
					}
				)
			),

			s(
				"subsubsec",
				fmt(
					[[
				\subsubsection{{{}}}
				{}]],
					{
						i(1),
						i(2),
					}
				)
			),

			-- Figures and tables
			s(
				"fig",
				fmt(
					[[
				\begin{{figure}}[htbp]
						\centering
						\includegraphics[width={}]{{{}}}{{\}}
						\caption{{{}}}
						\label{{fig:{}}}
				\end{{figure}}]],
					{
						i(1, "0.8\\textwidth"),
						i(2, "filename"),
						i(3, "caption"),
						i(4, "label"),
					}
				)
			),

			s(
				"table",
				fmt(
					[[
				\begin{{table}}[htbp]
						\centering
						\begin{{tabular}}{{{}}}{{\}}
								{} \\
								\hline
								{}
						\end{{tabular}}
						\caption{{{}}}
						\label{{tab:{}}}
				\end{{table}}]],
					{
						i(1, "c c c"),
						i(2, "Column 1 & Column 2 & Column 3"),
						i(3, "data1 & data2 & data3"),
						i(4, "caption"),
						i(5, "label"),
					}
				)
			),

			-- autosinnpets
			-- Math mode
			s({ trig = "mk", snippetType = "autosnippet" }, {
				t("$"),
				i(1),
				t("$"),
			}),

			-- Fractions
			s({ trig = "//", snippetType = "autosnippet" }, {
				t("\\frac{"),
				i(1),
				t("}{"),
				i(2),
				t("}"),
			}),

			-- Subscripts and superscripts
			s({ trig = "__", snippetType = "autosnippet" }, {
				t("_{"),
				i(1),
				t("}"),
			}),

			s({ trig = "^^", snippetType = "autosnippet" }, {
				t("^{"),
				i(1),
				t("}"),
			}),

			-- unit with numbers
			s({
				trig = "(%d+)deg",
				regTrig = true,
				snippetType = "autosnippet",
			}, {
				f(function(_, snip)
					return snip.captures[1] .. "^{\\circ}"
				end),
			}),

			--- common symbols
			s({ trig = "->", snippetType = "autosnippet" }, t("\\to")),
			s({ trig = "!>", snippetType = "autosnippet" }, t("\\mapsto")),
			s({ trig = "=>", snippetType = "autosnippet" }, t("\\implies")),
			s({ trig = "=<", snippetType = "autosnippet" }, t("\\impliedby")),
			s({ trig = "<=>", snippetType = "autosnippet" }, t("\\iff")),
			s({ trig = "...", snippetType = "autosnippet" }, t("\\dots")),
			s({ trig = ">=", snippetType = "autosnippet" }, t("\\geq")),
			s({ trig = "<=", snippetType = "autosnippet" }, t("\\leq")),
			s({ trig = "!=", snippetType = "autosnippet" }, t("\\neq")),
			s({ trig = "~=", snippetType = "autosnippet" }, t("\\approx")),
			s({ trig = "~~", snippetType = "autosnippet" }, t("\\sim")),
			s({ trig = "\\\\\\", snippetType = "autosnippet" }, t("\\\\ \n")),

			-- Common sets
			s({ trig = "RR", snippetType = "autosnippet" }, t("\\mathbb{R}")),
			s({ trig = "NN", snippetType = "autosnippet" }, t("\\mathbb{N}")),
			s({ trig = "ZZ", snippetType = "autosnippet" }, t("\\mathbb{Z}")),
			s({ trig = "QQ", snippetType = "autosnippet" }, t("\\mathbb{Q}")),
			s({ trig = "CC", snippetType = "autosnippet" }, t("\\mathbb{C}")),
		})

		-- add other snippets
		luasnip.add_snippets("py", {})
		luasnip.add_snippets("js", {})
		luasnip.add_snippets("java", {})
		luasnip.add_snippets("html", {})
	end,
}
