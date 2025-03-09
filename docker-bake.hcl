variable "VERSION" {
  default = "2025.1.3"
}

group "default" {
  targets = ["default"]
}

target "default" {
  tags = ["quay.io/seiferma/bitwarden-cli:${VERSION}", "quay.io/seiferma/bitwarden-cli:latest"]
  args = {
    CLI_VERSION = "${VERSION}"
  }
}
