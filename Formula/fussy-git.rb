class FussyGit < Formula
  desc "Keeps cloned git repositories organised under a configurable root, by remote URL"
  homepage "https://github.com/jmsnll/fussy-git"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.4.0/fussy-git-aarch64-apple-darwin.tar.xz"
      sha256 "f6320445d870b40cc461c8988eb9a4ac1787e51c6f1b1e825b2b132878112ed0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.4.0/fussy-git-x86_64-apple-darwin.tar.xz"
      sha256 "12afe44f1d5f9b4266003acfcce2df91640606ed7f571ed73acb48bf2b9edf7e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.4.0/fussy-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "13fd4a07511163d9a4d493c620685505ec335cb8b7b706b5275f1b75cec6834b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.4.0/fussy-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1430b94628c720ba6e3335d3c6f728c22729e885fbcf4b9638395934217f98b2"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "fussy-git"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fussy-git"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fussy-git"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fussy-git"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
