class Joedocs < Formula
  desc "MCP server for multi-project documentation with git history and search"
  homepage "https://github.com/joelee/joedocs-mcp"
  url "https://static.crates.io/crates/joedocs/joedocs-0.1.0.crate"
  sha256 "404eed19e3da56ba6d32a72986c26bb1cd45800eab6989e3c78f3fe114810860"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      joedocs keeps documents in a vault folder and needs git at run time.

      Set the vault folder in ~/.config/joedocs/config.toml:
        [storage]
        home = "#{Dir.home}/Documents/JoeDocs"

      Then create the store, a project and an API key:
        joedocs init
        joedocs project add notes --key NT --title Notes
        joedocs key create laptop --grant notes:write

      Run the server (http://127.0.0.1:8750/mcp) in the background at login:
        brew services start joedocs

      Restart it after changing the configuration:
        brew services restart joedocs
    EOS
  end

  service do
    run [opt_bin/"joedocs", "serve"]
    keep_alive true
    log_path var/"log/joedocs.log"
    error_log_path var/"log/joedocs.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/joedocs --version")

    ENV["JOEDOCS__STORAGE__HOME"] = (testpath/"vault").to_s
    ENV["JOEDOCS__STORAGE__STATE_DIR"] = (testpath/"state").to_s
    assert_match "Initialised JoeDocs", shell_output("#{bin}/joedocs init")
    system bin/"joedocs", "project", "add", "demo", "--key", "DM", "--title", "Demo"
    token = shell_output("#{bin}/joedocs key create brew --grant demo:read").lines.last.strip
    assert_match(/\Ajd_/, token)
    assert_match "No problems found", shell_output("#{bin}/joedocs check")

    port = free_port
    ENV["JOEDOCS__SERVER__BIND"] = "127.0.0.1:#{port}"
    pid = spawn bin/"joedocs", "serve"
    begin
      sleep 3
      assert_equal "ok", shell_output("curl -s http://127.0.0.1:#{port}/health").strip
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
