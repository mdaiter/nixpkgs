with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "arweave-${version}";
  version = "stable";

  src = fetchFromGitHub {
    owner = "ArweaveTeam";
    repo = "arweave";
    rev = "stable";
    sha256 = "08wbh7kik5na7lxj2x4sdynf31x2fwglnldspac13k4lmka70qrx";
    fetchSubmodules = true;
  };

  preConfigure = ''
    sed 72,73d -i Makefile
    sed -e s/gitmodules//g -i Makefile

    sed -e s/-flto//g -i lib/RandomX/makefile

    sed -i s/global/globl/g -i lib/RandomX/src/jit_compiler_x86_static.S
  '';

  buildInputs = [
    git
    gnumake
    binutils
    gcc8
  ];

  meta = with stdenv.lib; {
    homepage = https://arweave.org/;
    description = "Permanently host your web apps and pages, simply and quickly";

    longDescription = ''
      Introducing the permaweb.

      Welcome to Arweave: The web you can own and run.
      Arweave enables you to permanently host your web apps and pages, simply and quickly.
    '';

    platforms = ["x86_64-linux" "x86_64-darwin"];
    license = licenses.gpl2;
    maintainers = with maintainers; [ mdaiter ];
  };
}
