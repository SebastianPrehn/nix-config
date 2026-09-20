set quiet

update:
	nix flake update

fmt:
	nix fmt

check:
	nix flake check

switch:
	nh os switch .
        systemctl --user restart emacs.service
