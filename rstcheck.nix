{ lib, buildPythonPackage, fetchPypi, docutils }:

buildPythonPackage rec {
  pname = "rstcheck";
  version = "3.3.1";
  
  src = fetchPypi {
    inherit pname version;
    sha256 = "07vl2p16fw0jayfcn424ixfc3cyhj8pnm89b83h70hm5as9ggi4j";
  };

  nativeBuildInputs = [ docutils ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/myint/rstcheck";
    description = "Checks syntax of reStructuredText and code blocks nested within it.";
    maintainers = with maintainers; [ cemg ];
  };
}