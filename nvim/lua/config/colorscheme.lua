return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1001, -- Slightly higher priority than Tokyo Night
  config = function()
    -- Define Darcula colors based on JetBrains Darcula theme
    require("base16-colorscheme").setup({
      base00 = "#2B2B2B", -- Background
      base01 = "#323232", -- Lighter Background
      base02 = "#214283", -- Selection Background
      base03 = "#808080", -- Comments, Invisibles
      base04 = "#D0D0D0", -- Dark Foreground
      base05 = "#A9B7C6", -- Default Foreground
      base06 = "#FFC66D", -- Light Foreground
      base07 = "#FFFFFF", -- Light Background
      base08 = "#CC7832", -- Variables, XML Tags, Keywords
      base09 = "#6897BB", -- Integers, Boolean, Constants
      base0A = "#FFC66D", -- Classes, Markup Bold
      base0B = "#A5C261", -- Strings
      base0C = "#6A8759", -- Support, Regular Expressions
      base0D = "#9876AA", -- Functions, Methods
      base0E = "#CC7832", -- Keywords
      base0F = "#A5C261", -- Deprecated, Opening/Closing Embedded Tags
    })

    -- Set the theme
    vim.o.background = "dark"
    vim.cmd("colorscheme base16-darcula")

    -- Create transparency function with EXCLUSIONS for Visual and other highlights
    _G.enable_transparency = function()
      local transparent_groups = {
        "Normal",
        "NormalFloat",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
        "MsgArea",
        -- Plugins
        "TelescopeBorder",
        "TelescopeNormal",
        "TelescopePromptNormal",
      }

      -- Set transparent background for most groups
      for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
      end

      -- IMPORTANT: Apply custom highlights AFTER transparency
      -- This ensures they won't be overridden
      vim.api.nvim_set_hl(0, "Visual", { bg = "#45597a", ctermbg = 237 })
      vim.api.nvim_set_hl(0, "Search", { fg = "#000000", bg = "#FFC66D", ctermfg = 0, ctermbg = 221 })
      vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#CC7832", ctermfg = 0, ctermbg = 166 })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#353535", ctermbg = 236 })
    end

    -- Apply custom highlights first (before transparency)
    local function apply_custom_highlights()
      vim.api.nvim_set_hl(0, "Visual", { bg = "#45597a", ctermbg = 237 })
      vim.api.nvim_set_hl(0, "Search", { fg = "#000000", bg = "#FFC66D", ctermfg = 0, ctermbg = 221 })
      vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#CC7832", ctermfg = 0, ctermbg = 166 })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#353535", ctermbg = 236 })

      -- This is the function we need to use instead of base16.hi
      if vim.fn.exists("*Base16hi") == 1 then
        vim.fn.Base16hi("Function", vim.g.base16_gui06, "", "", vim.g.base16_cterm06, "", "")
        vim.fn.Base16hi("Include", vim.g.base16_gui05, "", "", vim.g.base16_cterm05, "", "")
        vim.fn.Base16hi("Type", vim.g.base16_gui0E, "", "", vim.g.base16_cterm0E, "", "")
      else
        -- Fallback if Base16hi isn't available
        vim.cmd([[
          highlight Function guifg=#FFC66D ctermfg=221
          highlight Include guifg=#A9B7C6 ctermfg=250
          highlight Type guifg=#CC7832 ctermfg=166
        ]])
      end
    end

    -- Apply highlights immediately
    apply_custom_highlights()

    -- Apply transparency immediately (AFTER highlights)
    _G.enable_transparency()

    -- Create a user command to toggle transparency
    vim.api.nvim_create_user_command("ToggleTransparency", function()
      if vim.g.transparency_enabled then
        vim.g.transparency_enabled = false
        vim.cmd("colorscheme base16-darcula") -- Re-apply the colorscheme
        apply_custom_highlights() -- Re-apply highlights
      else
        vim.g.transparency_enabled = true
        _G.enable_transparency() -- This now applies both transparency AND highlights
      end
    end, {})

    -- Set transparency as enabled by default
    vim.g.transparency_enabled = true

    -- Keep your ColorScheme autocmd for safety but modify it
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*", -- Changed to catch ALL colorscheme changes
      callback = function()
        apply_custom_highlights() -- Apply our highlights

        -- If transparency is enabled, reapply it after highlights
        if vim.g.transparency_enabled then
          _G.enable_transparency()
        end
      end,
    })
  end,
}
