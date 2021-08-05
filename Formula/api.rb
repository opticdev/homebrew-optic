require "language/node"

class Api < Formula
  desc "Optic CLI"
  homepage "https://github.com/opticdev/optic"
  url "https://registry.npmjs.org/@useoptic/cli/-/cli-10.2.3.tgz"
  sha256 "9b2e954d1d65da70452de382157b8e7391765c868f3fb06de53e06a33f4ae2a5"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node@14"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)

    rewrite_info = Utils::Shebang::RewriteInfo.new(
      %r{#!/usr/bin/env node},
      20,
      "#{HOMEBREW_PREFIX}/opt/node@14/bin/node\\1",
    )
    Utils::Shebang.rewrite_shebang rewrite_info, "#{libexec}/lib/node_modules/@useoptic/cli/bin/run"

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "@useoptic/cli", shell_output("#{bin}/api --version | awk '{print $1}'")
  end
end
