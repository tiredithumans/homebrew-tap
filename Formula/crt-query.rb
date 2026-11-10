# Homebrew formula for crt-query. GENERATED — do not edit by hand.
#
# Written by the `tap` job in release.yml over in
# tiredithumans/crt-query, which regenerates this from the published
# SHA256SUMS on `release: published` and pushes it here. Reproduce it by hand
# with `just homebrew-formula` in that repo. The tap has to be a PUBLIC repo
# named homebrew-tap for `brew install tiredithumans/tap/crt-query` to
# resolve.
#
# A binary formula, not a source build: it installs the very archives the
# release publishes, checked against the same SHA256SUMS a manual install
# would verify. Homebrew also strips the macOS quarantine attribute from what
# it downloads, so there is no `xattr` step for this install path.
class CrtQuery < Formula
  desc "Query crt.sh certificate-transparency data from its public PostgreSQL database"
  homepage "https://github.com/tiredithumans/crt-query"
  # No `version` stanza: Homebrew scans it out of the URLs below, and
  # declaring it as well is a `brew audit --strict` failure.
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.7.0/crt-query-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "acd8a9c9de908a651cc7c7435aa95cc5f7b54f526d862ab071926b3589839161"
    end
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.7.0/crt-query-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "65bdb5f5d93049b94c27106bfe9d8b638ed1219d93b880d95757b65eaa626d8d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.7.0/crt-query-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3edd3d54a501f264ac2eca23708af3bfba807cb9fd305b77824cd7a76aa95438"
    end
    on_arm do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.7.0/crt-query-v0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6350638f725b3be90cc99af89767c27b19db0ae1305a6981d268d84094a86519"
    end
  end

  def install
    bin.install "crt-query"
    # `crt-query completions <shell>` takes the shell as a bare argument, which
    # is this helper's default parameter form.
    generate_completions_from_executable(bin/"crt-query", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/crt-query --version")
    # Offline by design: crt.sh is a shared public service on donated
    # infrastructure, and a formula test must not depend on it being up.
    assert_match "certificate-transparency", shell_output("#{bin}/crt-query --help")
  end
end
