{ stdenv, libX11, pkgconfig, lib }:
stdenv.mkDerivation rec {
  name = "set_wm_class";
  src = ./.;
  nativeBuildInputs = [pkgconfig];
  buildInputs = [libX11];
  postInstall = ''
    mkdir -p $out/bin;
    cp set_wm_class $out/bin/;
  '';
  meta.license = lib.licenses.gpl3;
}
