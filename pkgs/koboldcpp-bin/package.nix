{
  lib,
  fetchurl,
  runCommand,
  buildFHSEnv,
  libxcb,
}:
let
  version = "1.124.2";
  src = fetchurl {
    url = "https://github.com/LostRuins/koboldcpp/releases/download/v${version}/koboldcpp-linux-x64";
    hash = "sha256:c66ae0106673c7d9c41bafcc92c95bc5a6256709e9d853e5e2255bf536c1b069";
  };
  exe = runCommand "koboldcpp-${version}-exe" { } ''
    install -Dm755 ${src} $out/bin/koboldcpp
  '';
in
buildFHSEnv {
  pname = "koboldcpp";
  inherit version;
  targetPkgs = _: [ libxcb ];
  profile = ''
    export LD_LIBRARY_PATH=/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
  '';
  runScript = "${exe}/bin/koboldcpp";
  meta = {
    description = "KoboldCpp (upstream prebuilt CUDA binary)";
    homepage = "https://github.com/LostRuins/koboldcpp";
    license = lib.licenses.agpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "koboldcpp";
    platforms = [ "x86_64-linux" ];
  };
}
