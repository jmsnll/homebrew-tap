class FussyGit < Formula
  desc "Keeps cloned git repositories organised under a configurable root, by remote URL"
  homepage "https://github.com/jmsnll/fussy-git"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.3.0/fussy-git-aarch64-apple-darwin.tar.xz"
      sha256 "d5d298dda678a8c4917bb293a5fe5419830dce7e0302503915fe42c6caceee15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.3.0/fussy-git-x86_64-apple-darwin.tar.xz"
      sha256 "531d5281d6a84183e6353499b4b8194e619486f26b1d5057c1fd3cf6a93913b9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.3.0/fussy-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "54978920db9ffe564f700bb27daf5ee7e2d25903510fa2624ef0acca54de7d11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmsnll/fussy-git/releases/download/v0.3.0/fussy-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66ebc7c7eee7e554cbb0e8364c10a2ff75fe3bb988a6eeed667dce120f985ff1"
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
