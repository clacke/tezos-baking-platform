{ pkgs ? import ../nix/nixpkgs.nix {}
, pkgsCross ? pkgs.pkgsCross
, fetchurl ? pkgs.fetchurl
, runCommand ? pkgs.runCommand
}:

let
  clang = pkgsCross.raspberryPi.buildPackages.clang_4;
  gcc = pkgsCross.raspberryPi.buildPackages.gcc5;
in runCommand "bolos-env" {} ''
  mkdir $out
  ln -s ${clang} $out/clang-arm-fropi
  ln -s ${gcc} $out/gcc-arm-none-eabi-5_3-2016q1
''
