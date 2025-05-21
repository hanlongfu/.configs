return {
  -- "idr4n/github-monochrome.nvim",
  "cocopon/iceberg.vim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme iceberg")
    -----------------
    --- change base colors
    -----------------
    -- local colors = {
    --   -- Base Colors
    --   bg = "#2E2826",
    --   fg = "#DEE7ED",
    --   fg_dark = "#867A74",
    --   black = "#403833",
    --   blue = "#6099C0",
    --   cyan = "#48a5af", -- Modified cyan color (more vibrant)
    --   green = "#819B69",
    --   magenta = "#B278A7",
    --   orange = "#DE825E",
    --   purple = "#AB76E5",
    --   red = "#DE6E7C",
    --   teal = "#026C8D",
    --   yellow = "#B87E64",
    --   terminal_black = "#403833",
    -- }
    --
    -- -- Apply color overrides
    -- for group, color in pairs({
    --   Normal = { fg = colors.fg, bg = colors.bg },
    --   Comment = { fg = "#6E6764" },
    --   Constant = { fg = colors.cyan }, -- Use new cyan for constants
    --   -- Add more highlight group overrides as needed
    -- }) do
    --   vim.api.nvim_set_hl(0, group, color)
    -- end

    -----------------
    --- disable italics
    -----------------

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

    -----------------
    --- set lualine color
    -----------------
    _G.setup_lualine_theme = function()
      -- This will be called before lualine loads
      -- Create a theme for lualine that matches your colorscheme
      local colors = {
        bg = "#1C1917", -- same as base00
        fg = "#B4BDC3", -- same as base05
        yellow = "#B77E64", -- same as base0A
        cyan = "#66A5AD", -- same as base0C
        green = "#819B69", -- same as base0B
        orange = "#9C6003", -- same as base09
        magenta = "#B279A7", -- same as base0E
        blue = "#6099C0", -- same as base0D
        red = "#DE6E7C", -- same as base08
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
  end,
}
