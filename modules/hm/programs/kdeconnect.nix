{pkgs, ...}: {
  services.kdeconnect = {
    enable = true;
    indicator = true; # システムトレイアイコンを有効化
  };
}
