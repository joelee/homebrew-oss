class CliBot < Formula
  desc "Translate natural-language requests into shell commands with Ollama"
  homepage "https://github.com/joelee/cli-bot"
  url "https://static.crates.io/crates/cli-bot/cli-bot-0.4.1.crate"
  sha256 "86068b3df03db5f22c1a2eacffff335f4b4526d8350f4a67ad8cc9f479f39d81"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      cli-bot requires a running Ollama endpoint.

      Default config lookup order:
        - ~/.config/cli-bot/cli-bot.toml
        - /etc/cli-bot.toml

      Prerequisites - Ollama must be installed and running:
        brew install ollama
        brew services restart ollama

      Pull the default model before first use:
        ollama pull lfm2:latest

      Check and verify your environment is properly set up:
        cli-bot --check
    EOS
  end

  test do
    output = shell_output("#{bin}/cli-bot --color never --help")
    assert_match "Translate natural language into shell commands", output
  end
end
