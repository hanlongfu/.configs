return {
  "custom-colorscheme", -- This can be any string since we're not loading from a repo
  lazy = false,
  priority = 1000,
  dir = vim.fn.stdpath("config"), -- Points to your config directory
  config = function()
    vim.g.disable_italics = 1
    -- Define color palette
    local colors = {
      bg = "#272c33",
      fg = "#dee2e8",
      red = "#bf6b69",
      green = "#b7bd73",
      yellow = "#e9c880",
      blue = "#88a1bb",
      magenta = "#ad95b8",
      cyan = "#95bdb7",
      white = "#eaeaea",
      black = "#1d1f21",
      comment = "#828181",
      selection = "#3a3f47",
      cursor = "#bcc95f",
      -- Bright variants
      bright_red = "#c55757",
      bright_green = "#bcc95f",
      bright_yellow = "#e1c65e",
      bright_blue = "#83a5d6",
      bright_magenta = "#bc99d4",
      bright_cyan = "#83beb1",
    }

    -- Clear existing highlights
    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") then
      vim.cmd("syntax reset")
    end

    -- Set colorscheme name
    vim.g.colors_name = "custom-dark"

    -- Helper function to set highlights
    local function hl(group, opts)
      vim.api.nvim_set_hl(0, group, opts)
    end

    -- Editor highlights
    hl("Normal", { fg = colors.fg, bg = colors.bg })
    hl("NormalFloat", { fg = colors.fg, bg = colors.bg })
    hl("FloatBorder", { fg = colors.comment, bg = colors.bg })
    hl("Cursor", { fg = colors.bg, bg = colors.cursor })
    hl("CursorLine", { bg = colors.selection })
    hl("CursorColumn", { bg = colors.selection })
    hl("LineNr", { fg = colors.comment })
    hl("CursorLineNr", { fg = colors.yellow, bold = true })
    hl("Visual", { bg = colors.selection })
    hl("VisualNOS", { bg = colors.selection })
    hl("Search", { fg = colors.bg, bg = colors.yellow })
    hl("IncSearch", { fg = colors.bg, bg = colors.yellow })
    hl("StatusLine", { fg = colors.fg, bg = colors.selection })
    hl("StatusLineNC", { fg = colors.comment, bg = colors.selection })
    hl("VertSplit", { fg = colors.comment })
    hl("WinSeparator", { fg = colors.comment })
    hl("Pmenu", { fg = colors.fg, bg = colors.selection })
    hl("PmenuSel", { fg = colors.bg, bg = colors.blue })
    hl("PmenuSbar", { bg = colors.comment })
    hl("PmenuThumb", { bg = colors.fg })
    hl("TabLine", { fg = colors.comment, bg = colors.selection })
    hl("TabLineFill", { bg = colors.selection })
    hl("TabLineSel", { fg = colors.fg, bg = colors.bg })
    hl("SignColumn", { fg = colors.comment, bg = colors.bg })
    hl("FoldColumn", { fg = colors.comment, bg = colors.bg })
    hl("Folded", { fg = colors.comment, bg = colors.selection })
    hl("MatchParen", { fg = colors.cyan, bold = true })
    hl("NonText", { fg = colors.comment })
    hl("EndOfBuffer", { fg = colors.comment })
    hl("Whitespace", { fg = colors.comment })

    -- Syntax highlighting
    hl("Comment", { fg = colors.comment, italic = false })
    hl("Constant", { fg = colors.red })
    hl("String", { fg = colors.green })
    hl("Character", { fg = colors.green })
    hl("Number", { fg = colors.red })
    hl("Boolean", { fg = colors.red })
    hl("Float", { fg = colors.red })
    hl("Identifier", { fg = colors.cyan })
    hl("Function", { fg = colors.blue })
    hl("Statement", { fg = colors.magenta })
    hl("Conditional", { fg = colors.magenta })
    hl("Repeat", { fg = colors.magenta })
    hl("Label", { fg = colors.magenta })
    hl("Operator", { fg = colors.cyan })
    hl("Keyword", { fg = colors.magenta })
    hl("Exception", { fg = colors.magenta })
    hl("PreProc", { fg = colors.yellow })
    hl("Include", { fg = colors.blue })
    hl("Define", { fg = colors.magenta })
    hl("Macro", { fg = colors.yellow })
    hl("PreCondit", { fg = colors.yellow })
    hl("Type", { fg = colors.yellow })
    hl("StorageClass", { fg = colors.yellow })
    hl("Structure", { fg = colors.yellow })
    hl("Typedef", { fg = colors.yellow })
    hl("Special", { fg = colors.cyan })
    hl("SpecialChar", { fg = colors.cyan })
    hl("Tag", { fg = colors.red })
    hl("Delimiter", { fg = colors.fg })
    hl("SpecialComment", { fg = colors.comment })
    hl("Debug", { fg = colors.red })
    hl("Underlined", { fg = colors.blue, underline = true })
    hl("Ignore", { fg = colors.comment })
    hl("Error", { fg = colors.red, bg = colors.bg })
    hl("ErrorMsg", { fg = colors.bright_red, bg = colors.bg, bold = true })
    hl("Todo", { fg = colors.yellow, bg = colors.bg, bold = true })

    -- Treesitter highlights
    hl("@variable", { fg = colors.fg })
    hl("@variable.builtin", { fg = colors.red })
    hl("@variable.parameter", { fg = colors.fg })
    hl("@variable.member", { fg = colors.cyan })
    hl("@constant", { fg = colors.red })
    hl("@constant.builtin", { fg = colors.red })
    hl("@constant.macro", { fg = colors.yellow })
    hl("@string", { fg = colors.green })
    hl("@string.escape", { fg = colors.cyan })
    hl("@string.special", { fg = colors.cyan })
    hl("@character", { fg = colors.green })
    hl("@number", { fg = colors.red })
    hl("@boolean", { fg = colors.red })
    hl("@float", { fg = colors.red })
    hl("@function", { fg = colors.blue })
    hl("@function.builtin", { fg = colors.blue })
    hl("@function.macro", { fg = colors.yellow })
    hl("@function.method", { fg = colors.blue })
    hl("@constructor", { fg = colors.yellow })
    hl("@operator", { fg = colors.cyan })
    hl("@keyword", { fg = colors.magenta })
    hl("@keyword.function", { fg = colors.magenta })
    hl("@keyword.operator", { fg = colors.magenta })
    hl("@keyword.return", { fg = colors.magenta })
    hl("@conditional", { fg = colors.magenta })
    hl("@repeat", { fg = colors.magenta })
    hl("@exception", { fg = colors.magenta })
    hl("@include", { fg = colors.blue })
    hl("@type", { fg = colors.yellow })
    hl("@type.builtin", { fg = colors.yellow })
    hl("@type.definition", { fg = colors.yellow })
    hl("@attribute", { fg = colors.yellow })
    hl("@property", { fg = colors.cyan })
    hl("@label", { fg = colors.magenta })
    hl("@namespace", { fg = colors.yellow })
    hl("@tag", { fg = colors.red })
    hl("@tag.attribute", { fg = colors.cyan })
    hl("@tag.delimiter", { fg = colors.fg })
    hl("@comment", { fg = colors.comment, italic = false })
    hl("@punctuation.delimiter", { fg = colors.fg })
    hl("@punctuation.bracket", { fg = colors.fg })
    hl("@punctuation.special", { fg = colors.cyan })

    -- LSP highlights
    hl("DiagnosticError", { fg = colors.red })
    hl("DiagnosticWarn", { fg = colors.yellow })
    hl("DiagnosticInfo", { fg = colors.blue })
    hl("DiagnosticHint", { fg = colors.cyan })
    hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
    hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow })
    hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue })
    hl("DiagnosticUnderlineHint", { undercurl = true, sp = colors.cyan })

    -- Git highlights
    hl("DiffAdd", { fg = colors.green, bg = colors.bg })
    hl("DiffChange", { fg = colors.yellow, bg = colors.bg })
    hl("DiffDelete", { fg = colors.red, bg = colors.bg })
    hl("DiffText", { fg = colors.blue, bg = colors.bg })
    hl("GitSignsAdd", { fg = colors.green })
    hl("GitSignsChange", { fg = colors.yellow })
    hl("GitSignsDelete", { fg = colors.red })

    -- Telescope highlights
    hl("TelescopeNormal", { fg = colors.fg, bg = colors.bg })
    hl("TelescopeBorder", { fg = colors.comment, bg = colors.bg })
    hl("TelescopePromptNormal", { fg = colors.fg, bg = colors.selection })
    hl("TelescopePromptBorder", { fg = colors.comment, bg = colors.selection })
    hl("TelescopeResultsNormal", { fg = colors.fg, bg = colors.bg })
    hl("TelescopePreviewNormal", { fg = colors.fg, bg = colors.bg })
    hl("TelescopeSelection", { fg = colors.fg, bg = colors.selection })
    hl("TelescopeSelectionCaret", { fg = colors.cyan, bg = colors.selection })
    hl("TelescopeMatching", { fg = colors.yellow, bold = true })

    -- Which-key highlights
    hl("WhichKey", { fg = colors.blue })
    hl("WhichKeyGroup", { fg = colors.cyan })
    hl("WhichKeyDesc", { fg = colors.fg })
    hl("WhichKeySeperator", { fg = colors.comment })
    hl("WhichKeyFloat", { bg = colors.bg })
    hl("WhichKeyBorder", { fg = colors.comment })
  end,
}
