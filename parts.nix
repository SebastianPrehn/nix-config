{ ... }: {
    systems = [
      "x86_64-linux"
    ];

    imports = [
      ./hosts/odin/default.nix
    ];
}
