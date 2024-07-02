{ lib
, stdenv
, autoreconfHook
, fetchFromGitHub
, lksctp-tools
, pkg-config
, libosmocore
, libosmo-netif
}:

stdenv.mkDerivation rec {
  pname = "libosmo-sccp";
  version = "1.8.2";

  src = fetchFromGitHub {
    owner = "osmocom";
    repo = "libosmo-sccp";
    rev = version;
    hash = "sha256-MT3NM4sXCLUNKQ5wEbUmvf2KYJNdcSFqGYeQbg+eop8=";
  };

  configureFlags = [ "--with-systemdsystemunitdir=$out" ];

  postPatch = ''
    echo "${version}" > .tarball-version
  '';

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];

  buildInputs = [
    lksctp-tools
    libosmocore
    libosmo-netif
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "SCCP + SIGTRAN (SUA/M3UA) libraries as well as OsmoSTP";
    mainProgram = "osmo-stp";
    homepage = "https://osmocom.org/projects/libosmo-sccp";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [
      markuskowa
    ];
  };
}
