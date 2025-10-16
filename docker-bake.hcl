variable "RELEASE_VERSION" {
  # renovate: datasource=github-releases depName=bitwarden/clients
  default = "cli-v2025.10.0"
}

function "get_version" {
  params = [release_version]
  result = trimprefix(release_version, "cli-v")
}

group "default" {
  targets = ["app", "minimal"]
}

target "app" {
  target = "app"
  tags = [
    "quay.io/seiferma/bitwarden-cli:${get_version(RELEASE_VERSION)}",
    "quay.io/seiferma/bitwarden-cli:latest"]
  args = {
    CLI_VERSION = "${get_version(RELEASE_VERSION)}"
  }
}

target "minimal" {
  target = "minimal"
  tags = [
    "quay.io/seiferma/bitwarden-cli:minimal-${get_version(RELEASE_VERSION)}",
    "quay.io/seiferma/bitwarden-cli:minimal-latest"]
  args = {
    CLI_VERSION = "${get_version(RELEASE_VERSION)}"
  }
}

group "test" {
  targets = ["test-minimal", "test-app"]
}

target "test-minimal" {
  inherits = ["minimal"]
  platforms = ["linux/amd64"]
  tags = ["test-image-minimal"]
}

target "test-app" {
  inherits = ["app"]
  platforms = ["linux/amd64"]
  tags = ["test-image-app"]
}
