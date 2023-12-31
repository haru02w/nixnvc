{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from an input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with pkgs.vimPlugins; [
    tokyonight-nvim
    lualine-nvim
    nvim-web-devicons
    dressing-nvim
    (mkNvimPlugin inputs.buffer_manager-nvim "buffer_manager.nvim")
    nvim-treesitter.withAllGrammars

    # libs
    # required by: buffer_manager
    plenary-nvim 
  ];

  extraPackages = with pkgs; [
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # You can add as many derivations as you like.
}
