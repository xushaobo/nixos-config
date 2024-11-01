# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the 
# NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:



{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary networking.proxy.default = "http://user:password@proxy:port/"; networking.proxy.noProxy = 
  # "127.0.0.1,localhost,internal.domain";
  # v2raya
  networking.proxy.default = "http://192.168.1.100:20171";
  # clash-verge
  # networking.proxy.default="http://192.168.1.21:7897";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY =
      "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # configure i3wm
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.layout = "us";
  services.xserver.windowManager.i3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.manbofish = {
    isNormalUser = true;
    description = "manbofish";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default. wget
    vim
    git
    wget
    curl
  ];
  environment.variables.EDITOR = "vim";



  # Some programs need SUID wrappers, can be configured further or are started in user sessions. programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon. services.openssh.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall 
  # altogether. networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system 
  # were taken. It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system. Before changing this 
  # value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # nix.settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];


  #  nmtui 打印报错信息
  #  networking.networkmanager.logLevel = "DEBUG";
  # 开启ssh远程登录
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  # 启用Flakes 特性以及配套的创新nix命令行工具
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
  };

}

# 其他
#################################################################################


