{ config, pkgs, lib, ... }:

{
	imports = [
		./modules/git.nix
		./modules/zsh.nix
	];

	# Git config
	git.enable = true;
	git.userName = "PabloCruzval";
	git.userEmail = "p.cruzat.valenzuela@gmail.com";

	# Zsh config
	zsh.enable = true;

	home.username = "nyx";

	home.homeDirectory = "/home/nyx";

	home.stateVersion = "25.05"; # Please read the comment before changing.

	home.packages = with pkgs; [
		brave
		gh
		neovim
		gnome-tweaks
		# Agrega aquí más paquetes específicos del usuario
		# vscode
		# discord
		# etc.
	];

	home.file = {
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.home-manager.enable = true;
}
