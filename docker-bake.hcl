variable "RELEASE_VERSION" {
  # renovate: datasource=github-releases depName=bitwarden/clients
  default = "cli-v2025.1.3"
}

function "get_version" {
  params = [release_version]
  result = trimprefix(release_version, "cli-v")
}

group "default" {
  targets = ["default"]
}

target "default" {
  tags = [
    "quay.io/seiferma/bitwarden-cli:${get_version(RELEASE_VERSION)}",
    "quay.io/seiferma/bitwarden-cli:latest"]
  args = {
    CLI_VERSION = "${get_version(RELEASE_VERSION)}"
  }
}
