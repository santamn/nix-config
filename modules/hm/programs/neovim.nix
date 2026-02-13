{
  config,
  pkgs,
  nixConfigPath,
  ...
}: {
  # Linux環境でのクリップボード共有のためのツール
  home.packages = with pkgs; [
    wl-clipboard # Wayland用
  ];

  # ~/.config/nvim を ~/dotnix/nvim への直リンクに: どちらのファイルを編集しても即座に反映さる
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/nvim";
}
