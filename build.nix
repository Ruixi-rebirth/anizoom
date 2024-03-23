{ rustPlatform
, pkg-config
, stdenv
, openssl
, gtk4
}:

rustPlatform.buildRustPackage rec {
  pname = "anizoom";
  version = "0.1.0";

  src = ./.;
  cargoLock = {
    lockFile = ./Cargo.lock;
  };
  nativeBuildInputs = [
    pkg-config
    openssl
  ];

  buildInputs = [
    gtk4
  ];
}
