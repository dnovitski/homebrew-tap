class Surfshield < Formula
  desc "Safe, policy-controlled web access for AI agents (MCP server and CLI)"
  homepage "https://github.com/dnovitski/surfshield"
  # Prebuilt binary from the GitHub release, so installing needs no Rust toolchain or crates.io.
  url "https://github.com/dnovitski/surfshield/releases/download/v0.1.0/surfshield-0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "surfshield"
    pkgshare.install "surfshield.example.toml"
  end

  def caveats
    <<~EOS
      Add surfshield to Claude Code as an MCP server:
        claude mcp add surfshield -- surfshield serve

      An example config is in:
        #{opt_pkgshare}/surfshield.example.toml
      Copy it to ~/.config/surfshield/config.toml to change the policy.
    EOS
  end

  test do
    assert_match "surfshield #{version}", shell_output("#{bin}/surfshield --version")
  end
end
