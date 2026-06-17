class KiroTimelog < Formula
  desc "Automatic time tracking for Kiro CLI sessions"
  homepage "https://github.com/mvn-bachhuynh-dn/kiro-timelog"
  url "https://github.com/mvn-bachhuynh-dn/kiro-timelog/archive/refs/heads/main.tar.gz"
  sha256 "bb08fe451f0d0b53f065ed7913a1b50c48f1db409864e35fa4f2d79bde2f4888"
  license "MIT"
  version "1.0.0"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    (bin/"kirolog").write_env_script libexec/"bin/kirolog", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  def post_install
    ohai "Run 'kirolog install-scheduler' to enable auto-scanning every 5 minutes"
  end

  def caveats
    <<~EOS
      To enable automatic scanning (launchd on macOS, cron on Linux):
        kirolog install-scheduler

      Optional config at ~/.kiro/timelog/config.json:
        {"projectPattern": "#{Dir.home}/projects/([^/]+)", "breakThreshold": 1800}

      Usage:
        kirolog              # this week's report
        kirolog --month      # this month
        kirolog --timesheet  # project × ticket summary
    EOS
  end

  test do
    system "#{bin}/kirolog", "--week"
  end
end
