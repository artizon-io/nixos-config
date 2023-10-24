# https://nixos.wiki/wiki/Qt

{ stdenv, fetchFromGitHub }:

{
  # https://github.com/shinas101/Anime-sddm-theme/tree/main
  shinas101 = stdenv.mkDerivation {
    pname = "sddm-theme-shinas101";
    version = "1.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out
      cp -R $src/Anime/. $out
      cp $src/Asset/forest.jpg $out/forest.jpg
    '';
    src = fetchFromGitHub {
      owner = "shinas101";
      repo = "Anime-sddm-theme";
      rev = "164523";
      sha256 = "sha256-nWQU/CFzh5ASjUp70MWOl/GTsHrGDPuHY0RM/B3v6Rk";
    };
  };
}
