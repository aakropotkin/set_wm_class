{ stdenv, libX11, pkg-config, lib }:
stdenv.mkDerivation {
  name = "set_wm_class";
  src = ./.;
  version = "1.0.0";
  nativeBuildInputs = [pkg-config];
  buildInputs = [libX11];
  postInstall = ''
    mkdir -p $out/bin;
    cp set_wm_class $out/bin/;
  '';
  meta.license = lib.licenses.gpl3;
}
