vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("snacks.explorer").open()
    vim.cmd("LushwalCompile")
  end,
})
