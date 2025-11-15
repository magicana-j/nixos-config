{ config, pkgs, ... }:

{
  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # グローバルにFlathubを追加
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
      priority = 0;
    }
  ];

  # 各ユーザーにもFlathubを自動追加（ログイン時に存在しなければ登録）
  system.activationScripts.addFlathubForUsers.text = ''
    for dir in /home/*; do
      user=$(basename "$dir")
      if [ -d "$dir/.local/share/flatpak" ]; then
        sudo -u "$user" flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true
      fi
    done
  '';
}

}
