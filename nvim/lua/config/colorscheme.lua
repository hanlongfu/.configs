return {
  -- "idr4n/github-monochrome.nvim",
  "cocopon/iceberg.vim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme iceberg")
    vim.api.nvim_set_hl(0, "visual", { bg = "#4c5279" })
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticSignwarn", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "NONE" })

    -----------------
    ---  add transparency
    -----------------
    local function set_transparency()
      -- Main background transparency
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

      -- Sidebar transparency
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })

      -- sign column transparency
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#6f6d6d", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })

      -- Status line transparency (optional)
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

      -- Popup/floating window transparency
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#4c5279" }) -- Keep selection visible
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

      -- Terminal transparency
      vim.api.nvim_set_hl(0, "TermCursor", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TermCursorNC", { bg = "NONE" })

      -- Telescope transparency (if you use it)
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE" })

      -- Which-key transparency (if you use it)
      vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "NONE" })

      -- Undotree transparency (for your undotree plugin)
      vim.api.nvim_set_hl(0, "UndotreeNode", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "UndotreeNodeCurrent", { bg = "NONE" })
      -- Add these lines to your set_transparency() function
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineTab", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineTabSelected", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBuffer", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = "NONE" })

      -- Also try TabLine groups (bufferline sometimes uses these)
      vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TabLineSel", { bg = "NONE" })

      vim.api.nvim_set_hl(0, "WarningMsg", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "ErrorMsg", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { bg = "NONE" })

      -- vertical split line
      vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE", fg = "#5f5e5e" })

      vim.api.nvim_set_hl(0, "GitGutterAdd", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitGutterChange", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitGutterChangeDelete", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "GitGutterDelete", { bg = "NONE" })
    end

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

    -- apply transparency
    set_transparency()

    -- Apply immediately
    disable_italics()

    -- Store the setting
    vim.g.italics_disabled = true

    -- Add to ColorScheme autocmd to ensure italics stay disabled
    local group = vim.api.nvim_create_augroup("CustomColorschemeSettings", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      pattern = "*",
      callback = function()
        vim.defer_fn(function()
          set_transparency()
          disable_italics()
        end, 10) -- Slight delay to ensure it runs after colorscheme
      end,
    })
    -----------------
    --- set lualine color
    -----------------
    _G.setup_lualine_theme = function()
      -- This will be called before lualine loads
      -- Create a theme for lualine that matches your colorscheme
      local colors = {
        bg = "#161821", -- same as base00
        fg = "#c6c8d1", -- same as base05
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
