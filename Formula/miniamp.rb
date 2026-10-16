class Miniamp < Formula
  desc "Local PHP, MariaDB and phpMyAdmin for macOS without admin rights"
  homepage "https://github.com/dnovitski/miniamp"
  url "https://github.com/dnovitski/miniamp/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "91eb735e1a51c08f41d9b25adffb9b93f67bdc641cf2f592d0ccdd10c5010c37"
  head "https://github.com/dnovitski/miniamp.git", branch: "main"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    # Built here instead of downloaded, so macOS doesn't quarantine the app.
    ENV["VERSION"] = version.to_s
    system "./build.sh"
    prefix.install "build/Miniamp.app"
    bin.install_symlink prefix/"Miniamp.app/Contents/MacOS/Miniamp" => "miniamp"
  end

  def caveats
    <<~EOS
      Set up PHP, MariaDB and phpMyAdmin, and add Miniamp to ~/Applications:
        miniamp install
      or open the control panel and click Install on the Setup tab:
        miniamp open

      After `brew upgrade miniamp`, run `miniamp install` (or click Repair) to refresh ~/Applications/Miniamp.app.
    EOS
  end

  test do
    assert_match "miniamp #{version}", shell_output("#{bin}/miniamp version")
  end
end
