{pkgs, ...}: {
  imports = [
    # ./example.nix - add your modules here
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  # ===========================
  # Shell
  # ===========================
  # Enable zsh system-wide (adds to /etc/shells, enables completion)
  programs.zsh.enable = true;

  # ===========================
  # Bluetooth
  # ===========================
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; # Bluetooth manager GUI

  # ===========================
  # Power Management (TLP for laptops)
  # ===========================
  services.tlp = {
    enable = true;
    settings = {
      # Battery thresholds for ThinkPad to extend battery life
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # CPU scaling
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  # ===========================
  # SSH
  # ===========================
  programs.ssh.startAgent = true;

  # ===========================
  # Japanese Input Method
  # ===========================
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  # ===========================
  # Virtualization (Docker & Podman)
  # ===========================
  virtualisation.docker.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = false; # Docker is already enabled
  };

  # Add user to docker group
  users.users.santamn.extraGroups = ["docker"];

  # ===========================
  # Fonts
  # ===========================
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack # Additional font for user preference
  ];
}
