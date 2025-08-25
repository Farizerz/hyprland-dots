return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" }, -- enable for all filetypes
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Blue", "red", etc
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba()
        hsl_fn = true, -- CSS hsl() and hsla()
        css = true, -- Enable all CSS features
        css_fn = true, -- Enable all CSS functions
      },
    },
  },
}
