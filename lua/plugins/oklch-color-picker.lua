return {
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      {
        "#",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = " Color Picker",
      },
    },
    opts = {
      -- Keep highlighting disabled initially. The picker remains available
      -- without adding buffer extmarks during formatting.
      highlight = {
        enabled = false,
      },
    },
  },
}
