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
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.0/crt-query-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "8bffc7ace0fa0ce295f8bc41b81af5ad3b04f266d4ee5c4e24321d5062d0d02d"
    end
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.0/crt-query-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "c3c1d0f489a809568634ef0a7812655b08553fac69cd5edd09442f095cc7124e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.0/crt-query-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fbfadd10d7c8a6d091e8fec7efa18f4f072f60150cee524b7ff1722da4c4f046"
    end
    on_arm do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.6.0/crt-query-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "17df672f6b4f304af62b7671ac2609ed249232aaacbaaddce662e5e1471b575a"
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
