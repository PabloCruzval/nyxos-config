{lib, config, pkgs, ...}:

{
	home.packages = with pkgs; [
		jetbrains-toolbox
	];
}
