class Passalong < Formula
  desc "Lightweight cross-platform clipboard and file sharing over SSH"
  homepage "https://github.com/joelee/passalong"
  url "https://static.crates.io/crates/passalong/passalong-0.1.5.crate"
  sha256 "53eb16a803db8a6ae0884fd5f1b8c5e317f3fd79a48ee303c30dc2dc4f89710f"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      passalong shares the clipboard and files through a folder on an SSH
      server you choose.

      Create the configuration and pin the server's host key:
        passalong init

      Check the configuration, the connection, and the store:
        passalong check

      Keep `passalong serve` running in the background at login:
        passalong service-install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/passalong --version")

    # A local store needs no server or network.
    (testpath/"store").mkpath
    (testpath/"config.toml").write <<~TOML
      [client]
      device_name = "brew-test"

      [server]
      kind = "local"

      [server.local]
      path = "#{testpath}/store"
    TOML
    passalong = "#{bin}/passalong --config #{testpath}/config.toml"
    id = pipe_output("#{passalong} clipboard --stdin", "hello from brew").strip
    assert_equal "hello from brew", shell_output("#{passalong} cat #{id}")
  end
end
