return {
  {
    "oncomouse/lushwal.nvim",
    cmd = { "LushwalCompile" },
    dependencies = {
      { "rktjmp/lush.nvim" },
      { "rktjmp/shipwright.nvim" },
    },
    lazy = false,
    config = function()
      vim.g.lushwal_configuration = {
        transparent_background = true,
        compime_to_vimscript = true,
        color_overrides = function(colors)
          local overrides = {
            background = colors.color0,
            foreground = "#FFFFFF",
            cursor = colors.color15,
            red = colors.color15,
            green = colors.color5,
            yellow = colors.color6.saturate(50),
            blue = colors.color7,
            magenta = "#c3e88d",
            cyan = colors.color5.saturate(100), -- active indent
            white = colors.color13.darken(20), -- sidebar border / comment /
            br_black = colors.color0.li(5), -- highlight
            br_cyan = colors.color1.mix(colors.color6, 10).saturate(96),
            grey = colors.color15.darken(60),
            br_grey = colors.color5.darken(50), -- indent guide / line number
            orange = colors.color15,
            purple = colors.color1.mix(colors.color4, 10).saturate(36),
          }
          return vim.tbl_extend("force", colors, overrides)
        end,
      }
    end,
  },
}
