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
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.5.2/crt-query-v0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "e7686d7a6c299188346a236cba0b1bfee10895cacefa69b9766511fa14c5cbef"
    end
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.5.2/crt-query-v0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "b8d21ba375127c0748b680f16f7a6003cfbb875db32b02e6b61d1841fca13281"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.5.2/crt-query-v0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "14a2ae9bc0c0e983dda27ccc2bdfcb7bbb0aa8c624ecd1b9bf03516635d6d4d5"
    end
    on_arm do
      url "https://github.com/tiredithumans/crt-query/releases/download/v0.5.2/crt-query-v0.5.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "adb5b2874a13d11e652e730a08ecd1c6aa20810f2cf8a284a0ed2e58bfbe018c"
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
