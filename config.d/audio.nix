{ config, pkgs, lib, ... }:

{
  # PulseAudioは無効化 (PipeWireと競合するため)
  services.pulseaudio.enable = false;

  # RealtimeKit: リアルタイムスケジューリングの権限管理
  # 音声処理の優先度を上げてレイテンシを低減
  security.rtkit.enable = true;

  # PipeWire: 次世代のオーディオサーバー
  services.pipewire = {
    enable = true;
    
    # ALSA (Advanced Linux Sound Architecture) サポート
    alsa.enable = true;
    # 32bitアプリケーション向けのALSAサポート
    alsa.support32Bit = true;
    
    # PulseAudio互換レイヤー (既存のPulseAudioアプリを動かすため)
    pulse.enable = true;
    
    # JACKサポート (プロ向けオーディオアプリケーション用)
    # 必要な場合はコメントを外す
    # jack.enable = true;
  };
}
