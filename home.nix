{ config, pkgs, lib, ... }:

{
	imports = [
		./modules/git.nix
		./modules/zsh.nix
		./modules/kitty.nix
		./modules/hyprland.nix
	];

	# Git config
	git.enable = true;
	git.userName = "PabloCruzval";
	git.userEmail = "p.cruzat.valenzuela@gmail.com";

	# Zsh config
	zsh.enable = true;

	# Kitty terminal config
	kitty.enable = true;

	# Hyprland window manager config
	hyprland.enable = true;

	home.username = "nyx";

	home.homeDirectory = "/home/nyx";

	home.stateVersion = "25.05"; # Please read the comment before changing.
	nixpkgs.config.allowUnfree = true;
	home.packages = with pkgs; [
		brave
		obsidian
		gh
		neovim
		gnome-tweaks
		vscode-fhs
		discord
		bitwarden-desktop
	];

	home.file = {
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.home-manager.enable = true;
}
