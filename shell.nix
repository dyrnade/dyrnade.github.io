{ pkgs ? import <nixpkgs> {} }:
let
  rstcheck = pkgs.callPackage ./rstcheck.nix {
    buildPythonPackage = pkgs.python38Packages.buildPythonPackage;
    fetchPypi = pkgs.python38Packages.fetchPypi;
  };
  python3 = pkgs.python3.withPackages (ps: [ 
      rstcheck
      ps.sphinx
      ps.recommonmark
      ps.ipython
      ps.pip
      ps.pylint
    ]
  );
in pkgs.mkShell {
    nativeBuildInputs = [
        python3
    ];
    
    shellHook = ''
      export PIP_PREFIX=$(pwd)/_build/pip_packages
      export PYTHONPATH="$PIP_PREFIX/${python3.sitePackages}:$PYTHONPATH"
      export PATH="$PIP_PREFIX/bin:$PATH"
      unset SOURCE_DATE_EPOCH
    '';
}
