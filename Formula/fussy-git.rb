class FussyGit < Formula
  desc "Keeps cloned git repositories organised under a configurable root, by remote URL"
  homepage "https://github.com/jmsnll/fussy-git"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.1/fussy-git-aarch64-apple-darwin.tar.xz"
      sha256 "ea38de2883ca42a5ee04426c335d29e1217180b7c8ac4591635f803a3b52c4ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.1/fussy-git-x86_64-apple-darwin.tar.xz"
      sha256 "7bf90b1ec9897ca7585e6779de483c4aca5937495219c36b3926da420fa3407c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.1/fussy-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65bdc50b5aab8f1f516097aaef802c73d839eefac93eada131e6f596ee6974c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.1.1/fussy-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8665dc4af0c5730d1793d2dbf8c332acb0c87f05050ca312e87f65ef4c98fb7d"
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
