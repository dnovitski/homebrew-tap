class Surfshield < Formula
  desc "Safe, policy-controlled web access for AI agents (MCP server and CLI)"
  homepage "https://github.com/dnovitski/surfshield"
  url "https://github.com/dnovitski/surfshield/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "efeeb59c614dad6638e6637274566ee2fcf65de67ae29e50cdb200fa1a92adbb"
  head "https://github.com/dnovitski/surfshield.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
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
