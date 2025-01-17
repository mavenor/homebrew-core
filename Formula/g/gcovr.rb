class Gcovr < Formula
  include Language::Python::Virtualenv

  desc "Reports from gcov test coverage program"
  homepage "https://gcovr.com/"
  url "https://files.pythonhosted.org/packages/1f/8d/7d8d83965b80e3854f863493faca12cc0d3776a41e01ce38e25c26155ac0/gcovr-7.1.tar.gz"
  sha256 "c5137340a51333d2fffe61f3d957d81b8a6727991f9d59b5a5b35bdd3493845c"
  license "BSD-3-Clause"
  head "https://github.com/gcovr/gcovr.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d35532fca91eb79d00b2b03828ad03a6b96c0b78493163a66bfcb86ca0df3caf"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "69b1d168bd764d4187481e5a409d023084c5d385271bbe063aec145048255f92"
    sha256 cellar: :any,                 arm64_monterey: "922d47202e8665413b3a317db3dc28f8fcfbbabe5f883439f23da0b8f89a7592"
    sha256 cellar: :any_skip_relocation, sonoma:         "1593ec3eb7e7b5ec38afb5e74745778bb7ed9f831102662f1e09689033bc4127"
    sha256 cellar: :any_skip_relocation, ventura:        "e1ab7eeafd466cf860c6f546c9ec5378a7f7f3f86c6d840f5e1463ae9408fc4a"
    sha256 cellar: :any,                 monterey:       "19d92f52aa501bb20e12c080f818a5467ceb98cc0d8ecec5622349af69db39ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "81931fb1efe7029d4dc3b95d93816805c74d4f6b15946e7ffd46c4a40c6f6586"
  end

  depends_on "python@3.12"

  uses_from_macos "libxml2", since: :ventura
  uses_from_macos "libxslt"

  resource "colorlog" do
    url "https://files.pythonhosted.org/packages/db/38/2992ff192eaa7dd5a793f8b6570d6bbe887c4fbbf7e72702eb0a693a01c8/colorlog-6.8.2.tar.gz"
    sha256 "3e3e079a41feb5a1b64f978b5ea4f46040a94f11f0e8bbb8261e3dbbeca64d44"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/b2/5e/3a21abf3cd467d7876045335e681d276ac32492febe6d98ad89562d1a7e1/Jinja2-3.1.3.tar.gz"
    sha256 "ac8bd6544d4bb2c9792bf3a159e80bba8fda7f07e81bc3aed565432d5925ba90"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/2b/b4/bbccb250adbee490553b6a52712c46c20ea1ba533a643f1424b27ffc6845/lxml-5.1.0.tar.gz"
    sha256 "3eea6ed6e6c918e468e693c41ef07f3c3acc310b70ddd9cc72d9ef84bc9564ca"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/87/5b/aae44c6655f3801e81aa3eef09dbbf012431987ba564d7231722f68df02d/MarkupSafe-2.1.5.tar.gz"
    sha256 "d283d37a890ba4c1ae73ffadf8046435c76e7bc2247bbb63c00bd1a709c6544b"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/55/59/8bccf4157baf25e4aa5a0bb7fa3ba8600907de105ebc22b0c78cfbf6f565/pygments-2.17.2.tar.gz"
    sha256 "da46cec9fd2de5be3a8a784f434e4c4ab670b4ff54d605c4c2717e9d49c4c367"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"example.c").write "int main() { return 0; }"
    system ENV.cc, "-fprofile-arcs", "-ftest-coverage", "-fPIC", "-O0", "-o",
                   "example", "example.c"
    assert_match "Code Coverage Report", shell_output("#{bin}/gcovr -r .")
  end
end
