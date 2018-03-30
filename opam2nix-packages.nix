
{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
	# For development, set OPAM2NIX_DEVEL to your local
	# opam2nix repo path
	devRepo = builtins.getEnv "OPAM2NIX_DEVEL";
	src = fetchgit 	{
		"url" = "https://github.com/obsidiansystems/opam2nix-packages.git";
		"fetchSubmodules" = false;
		"sha256" = "08pcxhymlj3wnc47i684rsxg9bf7krjmzam8pn5a0g1f3fgwhb3x";
		"rev" = "560b777b9ae5cf4f503bcaf77bfb012b089bab69";
	};
	opam2nix = fetchgit 	{
		"url" = "https://github.com/timbertson/opam2nix.git";
		"fetchSubmodules" = false;
		"sha256" = "1vj2pjwfil7h8czbrknfq6py33p5cz12cyfxj8yq190lmwcimhcb";
		"rev" = "790acd3b949540aa4b1e1cf580a03e36f52ae75b";
	};
in
if devRepo != "" then
	let toPath = s: /. + s; in
	callPackage "${devRepo}/nix" {} {
                inherit src opam2nix;
		#src = toPath "${devRepo}/nix/local.tgz";
		#opam2nix = let devSrc = "${devRepo}/opam2nix/nix/local.tgz"; in
		#	if builtins.pathExists devSrc then toPath devSrc else opam2nix;
	}
else callPackage "${src}/nix" {} { inherit src opam2nix; }
