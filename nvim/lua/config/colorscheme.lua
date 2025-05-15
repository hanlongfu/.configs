return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1001, -- Slightly higher priority than Tokyo Night
  config = function()
    -- Define Darcula colors based on JetBrains Darcula theme
    require("base16-colorscheme").setup({
      base00 = "#262626",
      base01 = "#3a3a3a",
      base02 = "#4e4e4e",
      base03 = "#8a8a8a",
      base04 = "#949494",
      base05 = "#dab997",
      base06 = "#d5c4a1",
      base07 = "#ebdbb2",
      base08 = "#d75f5f",
      base09 = "#ff8700",
      base0A = "#ffaf00",
      base0B = "#afaf00",
      base0C = "#85ad85",
      base0D = "#83adad",
      base0E = "#d485ad",
      base0F = "#d65d0e",
    })

    -- Set the theme - ensure it's loaded before lualine
    vim.o.background = "dark"

    -- Create helper function to set lualine theme compatibility
    _G.setup_lualine_theme = function()
      -- This will be called before lualine loads
      -- Create a theme for lualine that matches your colorscheme
      local colors = {
        bg = "#262626", -- same as base00
        fg = "#dab997", -- same as base05
        yellow = "#ffaf00", -- same as base0A
        cyan = "#85ad85", -- same as base0C
        green = "#afaf00", -- same as base0B
        orange = "#ff8700", -- same as base09
        magenta = "#d485ad", -- same as base0E
        blue = "#83adad", -- same as base0D
        red = "#d75f5f", -- same as base08
      }

      -- Set the global lualine theme that can be used in lualine config
      _G.custom_lualine_theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
          b = { fg = colors.fg, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
        },
        insert = { a = { fg = colors.bg, bg = colors.green, gui = "bold" } },
        visual = { a = { fg = colors.bg, bg = colors.magenta, gui = "bold" } },
        replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },
        inactive = {
          a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
          b = { fg = colors.fg, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
        },
      }
    end

    -- Setup lualine theme before colorscheme is loaded
    _G.setup_lualine_theme()

    -- Now apply the colorscheme (after lualine theme is prepared)
    vim.cmd("colorscheme base16-gruvbox-dark-pale")

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

      -- Apply transparency to all the groups
      for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE" })
      end
    end

    -- disable italics
    local function disable_italics()
      -- Get all highlight groups
      local highlight_groups = vim.fn.getcompletion("", "highlight")
      for _, group in ipairs(highlight_groups) do
        if group == "" then
          goto continue
        end
        -- Safely get current highlight
        local ok, current = pcall(vim.api.nvim_get_hl, 0, { name = group })
        if not ok or type(current) ~= "table" then
          goto continue
        end
        -- If italic is set (could be true or 1)
        if current.italic then
          -- Create new highlight specification
          local new_hl = {}
          -- Copy all attributes except italic
          for k, v in pairs(current) do
            if k ~= "italic" then
              new_hl[k] = v
            end
          end
          -- Set the new highlight without italic
          pcall(vim.api.nvim_set_hl, 0, group, new_hl)
        end
        ::continue::
      end
    end

    -- Apply immediately
    disable_italics()
    -- Store the setting
    vim.g.italics_disabled = true
    -- Add to ColorScheme autocmd to ensure italics stay disabled
    local group = vim.api.nvim_create_augroup("NoItalics", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      pattern = "*",
      callback = function()
        vim.defer_fn(disable_italics, 10) -- Slight delay to ensure it runs after colorscheme
      end,
    })

    -- Set transparency as enabled by default
    vim.g.transparency_enabled = true

    -- Initial application of transparency if enabled
    if vim.g.transparency_enabled then
      _G.enable_transparency()
    end

    -- Keep your ColorScheme autocmd for safety but modify it
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*", -- Changed to catch ALL colorscheme changes
      callback = function()
        -- If transparency is enabled, reapply it after highlights
        if vim.g.transparency_enabled then
          _G.enable_transparency()
        end
      end,
    })
  end,
}
