return {
  -- "wincent/base16-nvim",
  "zenbones-theme/zenbones.nvim",
  lazy = false,
  priority = 1001,
  dependencies = "rktjmp/lush.nvim",
  init = function()
    vim.opt.background = "dark"
  end,
  config = function()
    vim.cmd([[colorscheme neobones]])

    -- dim the line number
    -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#cad8d2", bold = true })
    -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#777f7b" })

    -- dim the colorcolumn color
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3c3836" })

    -- Create helper function to set lualine theme compatibility
    _G.setup_lualine_theme = function()
      -- This will be called before lualine loads
      -- Create a theme for lualine that matches your colorscheme
      local colors = {
        bg = "#0F191F", -- same as base00
        fg = "#B279A7", -- same as base05
        yellow = "#A0FF85", -- same as base0A
        cyan = "#92A0E2", -- same as base0C
        green = "#D68C67", -- same as base0B
        orange = "#E8838F", -- same as base09
        magenta = "#65B8C1", -- same as base0E
        blue = "#CF86C1", -- same as base0D
        red = "#263945", -- same as base08
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
  end,
}
