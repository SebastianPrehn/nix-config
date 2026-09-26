set quiet

update:
	nix flake update

fmt:
	nix fmt

check:
	nix flake check

switch:
    {{ if os() == "macos" { "nh darwin switch ." } else { "nh os switch ." } }}
