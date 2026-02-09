{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # インタラクティブセッションでnushellを起動
    initExtra = ''
      # インタラクティブシェルの場合のみnushellを起動
      if [[ $- == *i* ]] && [[ -z "$NUSHELL_ACTIVE" ]]; then
        export NUSHELL_ACTIVE=1
        exec nu
      fi
    '';
  };
}
