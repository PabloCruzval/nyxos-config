{ config, pkgs, lib, ... }:

{
	# import = [
		# ./modules/git.nix
	# ];

	# Git config
	# git.enable = true;
	# git.userName = "PabloCruzval";
	# git.userEmail = "p.cruzat.valenzuela@gmail.com";
	home.username = "nyx";

	home.homeDirectory = "/home/nyx";

	home.stateVersion = "25.05"; # Please read the comment before changing.

	home.packages = [
	];

	home.file = {
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.home-manager.enable = true;
}
