{
  description = "";

  inputs = { };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            cargo
            rust-analyzer
            rustc
            rustfmt
            clippy
            nixpkgs-fmt # TODO replace it with nixfmt-rfc-style
          ];
        };
      };
    };
}
