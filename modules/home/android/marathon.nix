{ stdenv, fetchurl, unzip, makeWrapper, jdk }:

stdenv.mkDerivation (finalAttrs: {
  pname = "marathon";
  version = "0.10.4";

  src = fetchurl {
    url = "https://github.com/MarathonLabs/marathon/releases/download/${finalAttrs.version}/marathon-${finalAttrs.version}.zip";
    hash = "sha256-disrV4vJmIaVsLFIyxo8Dreh/8zJwCtatm72OzcmbwY=";
  };

  nativeBuildInputs = [ unzip makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/marathon
    cp -r bin lib $out/share/marathon/
    chmod +x $out/share/marathon/bin/marathon

    makeWrapper $out/share/marathon/bin/marathon $out/bin/marathon \
      --set JAVA_HOME ${jdk.home}

    runHook postInstall
  '';

  meta = {
    description = "Cross-platform mobile test runner from MarathonLabs";
    homepage = "https://marathonlabs.io/";
    mainProgram = "marathon";
  };
})
