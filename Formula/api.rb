require "language/node"

class Api < Formula
  desc "Optic CLI"
  homepage "https://github.com/opticdev/optic"
  url "https://registry.npmjs.org/@useoptic/cli/-/cli-10.0.1.tgz"
  sha256 "6403777d78d78fc10f5c6d2d3cadc0581cfd051ca14c7c0d9775659cc784d218"
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
  end

  test do
    assert_match "@useoptic/cli", shell_output("#{bin}/api --version | awk '{print $1}'")
  end
end
