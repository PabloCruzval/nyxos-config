{lib, config, pkgs, ...}:

{
	options = {
		zsh.enable = lib.mkEnableOption "enable zsh module";
	};

	config = lib.mkIf config.zsh.enable {
		programs.zsh = {
			enable = true;
			enableCompletion = true;
			# Note: autosuggestion and syntaxHighlighting are now handled as plugins
			
			# History configuration
			history = {
				size = 5000;
				save = 5000;
				path = "${config.home.homeDirectory}/.zsh_history";
				ignoreDups = true;
				share = true;
				ignoreSpace = true;
			};

			# Plugins using Home Manager's zsh plugin system
			plugins = [
				{
					name = "zsh-autosuggestions";
					src = pkgs.zsh-autosuggestions;
					file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
				}
				{
					name = "zsh-syntax-highlighting";
					src = pkgs.zsh-syntax-highlighting;
					file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
				}
				{
					name = "fzf-tab";
					src = pkgs.fetchFromGitHub {
						owner = "Aloxaf";
						repo = "fzf-tab";
						rev = "v1.1.2";
						sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
					};
				}
			];

			# Shell aliases
			shellAliases = {
				apagar = "shutdown 0";
				nv = "nvim";
				py = "python";
				# Git aliases
				gs = "git status";
				ga = "git add";
				gc = "git commit -m";
				gp = "git push";
				gl = "git pull";
				gd = "git diff";
				# Utilities
				ls = "ls -l --color";
				la = "ls -la --color";
				c = "clear";
				# Nixos perfiles
				nyx-asus = "sudo nixos-rebuild switch --flake /home/nyx/nixos-config/#nyx-asus";
				nyx-pc= "sudo nixos-rebuild switch --flake /home/nyx/nixos-config/#nyx-pcmasterrace";
				nyx-base = "sudo nixos-rebuild switch --flake /home/nyx/nixos-config/#nixos";
				nyx-update = "cd /home/nyx/nixos-config && nix flake update";
				npm-dev="nix-shell -p glib --run 'npm run dev'";
			};

			# Initialize zoxide and configure powerlevel10k
			initContent = ''
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
	source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
fi

# Source powerlevel10k theme
source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

# Initialize zoxide
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
'';
		};

		# Install necessary packages
		home.packages = with pkgs; [
			fzf
			zoxide
			xclip
			zsh-powerlevel10k
		];

	};
}
