-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
local keymap = lvim.builtin.which_key.mappings
local vkeymap = lvim.builtin.which_key.vmappings

lvim.plugins = {
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000
  },
  { 'wakatime/vim-wakatime' },
  { 'neoclide/coc.nvim',
    branch = "release"
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    -- Bracket pair rainbow colorize
    lazy = true,
    event = { "User FileOpened" },
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
    require('neoscroll').setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = {
        '<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb'
        },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,        -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,              -- Function to run after the scrolling animation ends
        })
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
   end,
  }, 
  {
    "zbirenbaum/neodim",
    lazy = true,
    event = "LspAttach",
    config = function()
      require("neodim").setup({
        alpha = 0.75,
        blend_color = "#000000",
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = false,
          underline = false,
        },
      })
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    lazy = true,
    event = "WinNew",
    config = function()
      require("colorful-winsep").setup()
    end,
  },
  {
    "folke/noice.nvim",
    enabled = ENABLE_NOICE,
    lazy = true,
    event = "user fileopened",
    dependencies = { "rcarriga/nvim-notify", "muniftanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        lsp = {
          progress = {
            enabled = false,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
        messages = {
          enabled = true,
          view = "notify",
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
          view_search = "virtualtext",
        },
        health = {
          checker = false,
        },
      })
    end,
  },
}

lvim.builtin.lualine.style = "default" -- or "none"
lvim.colorscheme = "nightfly"
lvim.builtin.treesitter.rainbow.enable = true

keymap["on"] = { name = "+Notify" }
keymap["onn"] = { "<cmd>Notifications<cr>", "Show Notifications" }
keymap["ont"] = { "<cmd>Noice telescope<cr>", "Show Notifications in Telescope" }
keymap["onm"] = { "<cmd>messages<cr>", "Show Messages" }
keymap["ond"] = { "<cmd>NoiceDisable<cr>", "Noice Disable" }
keymap["one"] = { "<cmd>NoiceEnable<cr>", "Noice Enable" }
