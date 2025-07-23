target "pytest" {
  output = ["type=docker"]
  tags = ["swr.eu-de.otc.t-systems.com/sv-test-registry/documents:latest"]
}