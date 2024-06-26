{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    # Add bleeding-edge plugins here.
    # They can be updated with `nix flake update` (make sure to commit the generated flake.lock)
    # wf-nvim = {
    #   url = "github:Cassin01/wf.nvim";
    #   flake = false;
    # };
    buffer_manager-nvim = {
      url = "github:j-morano/buffer_manager.nvim";
      flake = false;
    };
    luasnip-latex-snippets-nvim = {
      url = "github:iurimateus/luasnip-latex-snippets.nvim";
      flake = false;
    };
    inlay-hints-nvim = {
      url = "github:MysticalDevil/inlay-hints.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    let
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      # This is where the Neovim derivation is built.
      neovim-overlay = import ./nix/neovim-overlay.nix { inherit inputs; };
    in flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ inputs.neovim-nightly.overlays.default neovim-overlay ];
        };
        shell = pkgs.mkShell {
          name = "nvim-devShell";
          buildInputs = with pkgs; [
            lua-language-server
            nil
            stylua
            luajitPackages.luacheck
          ];
        };
      in {
        packages = rec {
          default = nvim;
          nvim = pkgs.nixnvc;
        };
        devShells = { default = shell; };
      }) // {
        # You can add this overlay to your NixOS configuration
        overlays.default = neovim-overlay;
      };
  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
