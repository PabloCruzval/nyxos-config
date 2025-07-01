{lib, config, pkgs, ...}:

{
	options = {
		git.enable = lib.mkEnableOption "enable git module";
		git.userName = lib.mkOption {description = "username";};
		git.userEmail = lib.mkOption {description = "email";};
		git.defaultBranch = lib.mkOption {default = "main"; description="default branch";}
	};

	config = lib.mkIf config.git.enable {
		programs.git = {
			enable = true;
			config = {
				user.name = config.git.userName;
				user.email = config.git.userEmail;
				init.defaultBranch = config.git.defaultBranch;
			};
		};
	};
}
