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
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.1/crt-query-v0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "94484ed224f2ed7c79d5d2cf717a580659d4bb6e944a2be53ad158d5093afcba"
    end
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.1/crt-query-v0.6.1-x86_64-apple-darwin.tar.gz"
      sha256 "9492275f6556dcc46b7cf85125b16f0b2544433568a545ea4ce88d88b48f4e44"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.1/crt-query-v0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "95c6e8322355f0372651c83d70ac5fa0c387c60b030ecd801acee530544d1e96"
    end
    on_arm do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.1/crt-query-v0.6.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3d7c5736d0a103569ae5d1857b7bf6e0024c64f10753823b3142990e894b8bd2"
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
