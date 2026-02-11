{
  config,
  nixConfigPath,
  ...
}: {
  # ~/.config/nvim を ~/dotnix/nvim への直リンクに: どちらのファイルを編集しても即座に反映さる
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigPath}/nvim";
}
