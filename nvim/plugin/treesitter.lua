require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {
      'nix', -- too slow
    },
    additional_vim_regex_highlighting = false,
  },
}
