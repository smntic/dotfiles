{ ... }:

{
  home.file = {
    ".config/fcitx5/profile".text = ''
      [GroupOrder]
      0=Default

      [Groups/0]
      Default Layout=us
      DefaultIM=keyboard-us
      Name=Default

      [Groups/0/Items/0]
      Name=keyboard-us

      [Groups/0/Items/1]
      Name=mozc

      [Groups/0/Items/2]
      Name=pinyin

      [Groups/0/Items/3]
      Name=hangul
    '';

    ".config/fcitx5/config".text = ''
      [Hotkey]
      TriggerKeys=
      EnumerateForwardKeys=
      EnumerateBackwardKeys=

      [Hotkey/PrevPage]
      PrevPage=Control+k

      [Hotkey/NextPage]
      NextPage=Control+j
    '';

    ".config/fcitx5/conf/classicui.conf".text = ''
      Theme=Nord-Dark
    '';
  };
}
