{lib, config, pkgs, ...}:

{
	options = {
		git.enable = lib.mkEnableOption "enable git module";
		git.userName = lib.mkOption {
			type = lib.types.str;
			description = "username";
		};
		git.userEmail = lib.mkOption {
			type = lib.types.str;
			description = "email";
		};
		git.defaultBranch = lib.mkOption {
			type = lib.types.str;
			default = "main";
			description = "default branch";
		};
	};

	config = lib.mkIf config.git.enable {
		programs.git = {
			enable = true;
			userName = config.git.userName;
			userEmail = config.git.userEmail;
			extraConfig = {
				init.defaultBranch = config.git.defaultBranch;
				credential.helper = "!gh auth git-credential";
			};
			includes = [
				{ path = "~/.gitconfig.local"; }
			];
		};
	};
}
