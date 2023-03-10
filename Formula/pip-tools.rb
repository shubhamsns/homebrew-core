class PipTools < Formula
  include Language::Python::Virtualenv

  desc "Locking and sync for Pip requirements files"
  homepage "https://pip-tools.readthedocs.io"
  url "https://files.pythonhosted.org/packages/35/72/91b0284111ca3d43e14caa879bd1aeceb9480f81a679d40ce2ab7481969d/pip-tools-6.12.0.tar.gz"
  sha256 "f441603c63b16f4af0dd5026f7522a49eddec2bc8a4a4979af44e1f6b0a1c13e"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a579ee92d160c845472c275c273291449e37285b9f9b1fd9119120dea5cab32d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "32351090149ba890933b9bd253072cebbc43423a4af75335b0a8751c316fcd94"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5643fabdf2197ec5dbcacc1b37b59b6df51eb07a948dd36e9a1aa2bb7afca6e6"
    sha256 cellar: :any_skip_relocation, ventura:        "416eb45c658e54a359974df1f8fa566bdf6be12a64f4a6b47c374a1e17a5e92e"
    sha256 cellar: :any_skip_relocation, monterey:       "c9eb5f78b3190a6f90f2f543b84e723626bf28200cf98b6ed0f85171551893d1"
    sha256 cellar: :any_skip_relocation, big_sur:        "7e03b439f3bf8e63274e5b3d77a6199a1db252a1e5285f928474adf45d6e940c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b41ae2c82351a8a429f013cfc8baa89483a441cd4be74383179f8e80eac63fb5"
  end

  depends_on "python@3.11"

  resource "build" do
    url "https://files.pythonhosted.org/packages/0f/61/aaf43fbb36cc4308be8ac8088f52db9622b0dbf1f0880c1016ae6aa03f46/build-0.9.0.tar.gz"
    sha256 "1a07724e891cbd898923145eb7752ee7653674c511378eb9c7691aab1612bc3c"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/6b/f7/c240d7654ddd2d2f3f328d8468d4f1f876865f6b9038b146bec0a6737c65/packaging-22.0.tar.gz"
    sha256 "2198ec20bd4c017b8f9717e00f0c8714076fc2fd93816750ab48e2c41de2cfd3"
  end

  resource "pep517" do
    url "https://files.pythonhosted.org/packages/4d/19/e11fcc88288f68ae48e3aa9cf5a6fd092a88e629cb723465666c44d487a0/pep517-0.13.0.tar.gz"
    sha256 "ae69927c5c172be1add9203726d4b84cf3ebad1edcd5f71fcdc746e66e829f59"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/a2/b8/6a06ff0f13a00fc3c3e7d222a995526cbca26c1ad107691b6b1badbbabf1/wheel-0.38.4.tar.gz"
    sha256 "965f5259b566725405b05e7cf774052044b1ed30119b5d586b2703aafe8719ac"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      pip-tools
      typing-extensions
    EOS

    compiled = shell_output("#{bin}/pip-compile requirements.in -q -o -")
    assert_match "This file is autogenerated by pip-compile", compiled
    assert_match "# via pip-tools", compiled
  end
end
