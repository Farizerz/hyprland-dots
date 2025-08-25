return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- enable virtual text blame
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" = end of line (default), "overlay", or "right_align"
        delay = 500, -- ms before blame text shows
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
  },
}
