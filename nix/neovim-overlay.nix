{ inputs }:
final: prev:
with final.pkgs.lib;
let
  pkgs = final;

  # Use this to create a plugin from an input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  mkNeovim = pkgs.callPackage ./mkNeovim.nix { };

  all-plugins = with pkgs.vimPlugins; [
    # UI
    tokyonight-nvim # theme
    lualine-nvim # statusline
    # required by oil.nvim
    nvim-web-devicons # icons
    dressing-nvim # cool ui
    noice-nvim # cool cmdline and notifications
    nvim-colorizer-lua # preview colors in hex

    # syntax highlighting, LSP, CMP, DAP
    nvim-treesitter.withAllGrammars # Treesitter
    nvim-lspconfig # LSP
    (mkNvimPlugin inputs.inlay-hints-nvim
      "inlay-hints.nvim") # manage latex snippets
    markdown-preview-nvim # preview markdown files
    none-ls-nvim # Linter and Formatter
    nvim-cmp # CMP
    luasnip # snippets
    cmp_luasnip
    friendly-snippets # snippets
    (mkNvimPlugin inputs.luasnip-latex-snippets-nvim
      "luasnip-latex-snippets.nvim") # manage latex snippets
    lspkind-nvim # icons
    cmp-nvim-lsp
    # cmp-nvim-lsp-signature-help
    cmp-buffer
    cmp-path
    cmp-rg
    cmp-nvim-lua # neovim lua API completion
    cmp-cmdline
    cmp-cmdline-history
    nvim-dap
    nvim-dap-ui

    # UTILS
    hardtime-nvim
    smart-splits-nvim # manage splits easily
    (mkNvimPlugin inputs.buffer_manager-nvim
      "buffer_manager.nvim") # manage buffers
    which-key-nvim # see defined mappings
    eyeliner-nvim # highlight 'f'-key search
    nvim-spectre # a powerful search replace
    undotree # build a tree out of history
    telescope-nvim
    telescope-fzf-native-nvim # fuzzy finder
    presence-nvim # discord rich presence
    better-escape-nvim # jk escape
    vim-be-good # game to train nvim
    guess-indent-nvim # set indent options automatically
    indent-blankline-nvim # nice lines at indent spaces
    comment-nvim # comment with simple keys
    nvim-autopairs # auto close brackets when open
    nvim-ts-autotag # auto close html tags
    todo-comments-nvim # highlight todo comments
    oil-nvim # file manager using buffers
    gitsigns-nvim # git signs at left column

    # LIBS
    # required by: buffer_manager, telescope
    plenary-nvim
    # required by: noice
    nui-nvim
  ];

  extraPackages = with pkgs; [
    # language servers:
    nil # nix
    lua-language-server # lua
    clang-tools # c/c++
    rust-analyzer # rust
    pyright # python
    nodePackages.npm

    # formatters:
    mdformat
    stylua # lua
    black # python
    nixfmt # nix

    # extra:
    fzf
    ripgrep
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nixnvc = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # You can add as many derivations as you like.
}
