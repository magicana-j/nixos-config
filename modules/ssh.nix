{ config, pkgs, ... }:

{

  programs.ssh = {
    startAgent = true;
    knownHosts = {
      "github.com".publicKey = "github.com ssh-ed25519 b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZWQyNTUxOQAAACDzanf9mnQS4LODiG4tEnq2/QjjFVB9sMjSFNM1WhzUDAAAAJhN8/OUTfPzlAAAAAtzc2gtZWQyNTUxOQAAACDzanf9mnQS4LODiG4tEnq2/QjjFVB9sMjSFNM1WhzUDAAAAEDg3vChxI9eLtpTTp53p04GgUgaYkQOhcd25Zj6wL5O/PNqd/2adBLgs4OIbi0Serb9COMVUH2wyNIU0zVaHNQMAAAAEGFtdWhhcmFpQG1lcm1haWQBAgMEBQ==";
    };
  };

  #services.openssh.enable = true;  # SSHサーバーを起動したい場合

}
