require('noice').setup {
  views = {
    cmdline = {
      position = {
        row = -1,
        col = 0,
      },
    },
  },
  cmdline = {
    view = "cmdline",
    format = {
      filter = false,
      lua = false,
      help = false,
    },
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    long_message_to_split = true,
  },
}
