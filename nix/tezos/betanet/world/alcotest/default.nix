/*opam-version: "2.0"
  name: "alcotest"
  version: "0.8.3"
  synopsis: "Alcotest is a lightweight and colourful test
  framework."
  description: """
  Alcotest exposes simple interface to perform unit tests. It exposes
  a simple TESTABLE module type, a check function to assert test
  predicates and a run function to perform a list of unit -> unit
  test callbacks.
  
  Alcotest provides a quiet and colorful output where only faulty runs
  are fully displayed at the end of the run (with the full logs ready
  to
  inspect), with a simple (yet expressive) query language to select the
  tests to run."""
  maintainer: "thomas@gazagnaire.org"
  authors: "Thomas Gazagnaire"
  license: "ISC"
  homepage: "https://github.com/mirage/alcotest/"
  doc: "https://mirage.github.io/alcotest/"
  bug-reports: "https://github.com/mirage/alcotest/issues/"
  depends: [
    "ocaml" {>= "4.02.3"}
    "jbuilder" {build & >= "1.0+beta10"}
    "fmt" {>= "0.8.0"}
    "astring"
    "result"
    "cmdliner"
  ]
  build: [
    ["jbuilder" "subst" "-p" name] {pinned}
    ["jbuilder" "build" "-p" name "-j" jobs]
    ["jbuilder" "runtest" "-p" name "-j" jobs] {with-test}
  ]
  dev-repo: "git+https://github.com/mirage/alcotest.git"
  url {
    src:
     
  "https://github.com/mirage/alcotest/releases/download/0.8.3/alcotest-0.8.3.tbz"
    checksum: [
      "md5=597e6bb271bd42062f95aa67afdb9185"
     
  "sha256=b69393d130d9af57e6c2dbb0f2bff1b35a21847409d0fb495842b42408035357"
     
  "sha512=ecf034b4698900e10a3420fbc3fbb44ca2a8fc938a038664a36017fe69495f8e25cafa450e1a1f93bf4ccce526ed704d8c7c68d83b989d1c18181cbdc50a71a6"
    ]
  }*/
{ doCheck ? false, stdenv, opam, fetchurl, ocaml, jbuilder, fmt, astring,
  ocaml-result, cmdliner, findlib }:
let vcompare = stdenv.lib.versioning.debian.version.compare; in
assert (vcompare ocaml "4.02.3") >= 0;
assert (vcompare jbuilder "1.0+beta10") >= 0;
assert (vcompare fmt "0.8.0") >= 0;

stdenv.mkDerivation rec {
  pname = "alcotest";
  version = "0.8.3";
  name = "${pname}-${version}";
  inherit doCheck;
  src = fetchurl
  {
    url = "https://github.com/mirage/alcotest/releases/download/0.8.3/alcotest-0.8.3.tbz";
    sha256 = "0msk0c429d22b14zpl09fj222nmky6zz5c6vqbk5gbyr638r74xn";
  };
  buildInputs = [
    ocaml jbuilder fmt astring ocaml-result cmdliner findlib ];
  propagatedBuildInputs = [
    ocaml jbuilder fmt astring ocaml-result cmdliner ];
  configurePhase = "true";
  buildPhase = stdenv.lib.concatMapStringsSep "\n" (stdenv.lib.concatStringsSep " ")
  [
    [ "'jbuilder'" "'build'" "'-p'" pname "'-j'" "1" ] (stdenv.lib.optionals
    doCheck [ "'jbuilder'" "'runtest'" "'-p'" pname "'-j'" "1" ]) ];
  preInstall = stdenv.lib.concatMapStringsSep "\n" (stdenv.lib.concatStringsSep " ")
  [
    ];
  installPhase = "runHook preInstall; mkdir -p $out; for i in *.install; do ${opam.installer}/bin/opam-installer -i --prefix=$out --libdir=$OCAMLFIND_DESTDIR \"$i\"; done";
  createFindlibDestdir = true;
}
