class FussyGit < Formula
  desc "Keeps cloned git repositories organised under a configurable root, by remote URL"
  homepage "https://github.com/jmsnll/fussy-git"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.0/fussy-git-aarch64-apple-darwin.tar.xz"
      sha256 "ec22de48d4e85e8a323840463b4fb2fc8feb7decd722616218540b44b38dd683"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.0/fussy-git-x86_64-apple-darwin.tar.xz"
      sha256 "9acd43aaf6c5295eb72abd5b4c6b4bb51e2905d2d128bf41a08f9d78a1fe9a41"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.0/fussy-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8525737e048753bb001627b26427552efcb96051b7e093b95416dd52efb5601d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.0/fussy-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "003738b85d29dd5dd4e4545992279c64cfb1ab071446c525eee411edd00dec8b"
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
