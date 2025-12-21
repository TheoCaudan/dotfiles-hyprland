return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>-",
        function()
          require("yazi").yazi()
        end,
        desc = "Open Yazi in the directory of the file",
      },
      {
        "<leader>cw",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open Yazi in current working directory",
      },
    },
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = "~",
      },
    },
  },
}
