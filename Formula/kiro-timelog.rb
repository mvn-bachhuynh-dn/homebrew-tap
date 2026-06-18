class KiroTimelog < Formula
  desc "Automatic time tracking for AI coding assistants (Kiro CLI + Claude Code)"
  homepage "https://github.com/mvn-bachhuynh-dn/ailog"
  url "https://github.com/mvn-bachhuynh-dn/ailog/archive/refs/heads/main.tar.gz"
  sha256 "897dcce48dae2b2ddf97a6a70e657bf70efe85ee74314be3cbc67acb2345f561"
  license "MIT"
  version "1.0.0"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    (bin/"ailog").write_env_script libexec/"bin/kirolog", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  def caveats
    <<~EOS
      Enable auto-scanning (launchd on macOS, cron on Linux):
        ailog install-scheduler

      Optional config: ~/.ailog/config.json
        {"projectPattern": "#{Dir.home}/projects/([^/]+)", "breakThreshold": 1800}

      Usage:
        ailog              # this week
        ailog --month      # this month
        ailog --timesheet  # project × ticket summary
    EOS
  end

  test do
    system "#{bin}/ailog", "--week"
  end
end
