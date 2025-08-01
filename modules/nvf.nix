{ config, pkgs, inputs, ... }:
{
    programs.nvf = {
        enable = true;
        settings = {
            vim.theme.enable = true;
            vim.theme.name = "Dark Modern";
            vim.theme.style = "dark";

            vim.languages.nix.enable = true;
        };
    };
}