{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };

  jdk = pkgs.jdk21;

  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "34" "35" ];
    buildToolsVersions = [ "34.0.0" "35.0.0" ];
    platformToolsVersion = "36.0.0";
    cmdLineToolsVersion = "13.0";
    toolsVersion = "26.1.1";

    includeEmulator = true;
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "x86_64" ];
    includeSources = false;
    includeNDK = false;
  };

  androidSdk = androidComposition.androidsdk;

  marathon = pkgs.callPackage ./marathon.nix { inherit jdk; };
in
{
  home.packages = [
    androidSdk
    jdk
    marathon
    unstable.android-studio
  ];

  home.sessionVariables = {
    JAVA_HOME = "${jdk.home}";
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
  };
}
