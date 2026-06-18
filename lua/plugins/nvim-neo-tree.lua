return {
  'nvim-neo-tree/neo-tree.nvim',
  event = "VeryLazy",
  keys = {
    { '<C-n>', '<cmd>Neotree toggle<cr>', desc = 'ファイルツリーを開閉' },
    { '<leader>e', '<cmd>Neotree reveal<cr>', desc = '現在のファイルをツリーで表示' },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts) require("neo-tree").setup(opts) end,
  opts = {
    window = {
      width = 25,
      auto_expand_width = false,
    }
  }
}
