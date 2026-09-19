{ ... }: {
  systems = [
    "x86_64-linux"
  ];

  imports = [
    ./host/odin/default.nix
  ];
}
