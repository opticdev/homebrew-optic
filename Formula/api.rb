require "language/node"

class Api < Formula
  desc "Optic CLI"
  homepage "https://github.com/opticdev/optic"
  url "https://registry.npmjs.org/@useoptic/cli/-/cli-9.0.19.tgz"
  sha256 "eab12bb82c36aff0d33217c4392679714b29536bafb60f86221dcac0d37b1f2e"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)

    # Set shebang to Homebrew cellar
    bin_location = "#{libexec}/bin/api"
    lines = IO.readlines(bin_location)
    lines[0] = "#!#{HOMEBREW_PREFIX}/opt/node/bin/node"

    File.open(bin_location, "w") do |file|
      file.puts lines
    end

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "@useoptic/cli", shell_output("#{bin}/api --version | awk '{print $1}'")
  end
end
