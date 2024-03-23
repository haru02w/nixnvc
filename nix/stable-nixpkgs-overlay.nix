{ inputs }:
final: prev: {
  nixpkgs-stable = import inputs.nixpkgs-stable {
    system = final.system;
    config.allowUnfree = true;
  };
}
