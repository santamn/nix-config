{...}: {
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ../nvim/init.lua;
  };
}
