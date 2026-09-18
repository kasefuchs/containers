variable "registry" {
  default = "ghcr.io/kasefuchs/containers"
}

variable "versions" {
  type = map(string)
}

function "tags" {
  params = [name, version]
  result = [
    "${registry}/${name}:latest",
    "${registry}/${name}:${version}",
    "${registry}/${name}:v${version}"
  ]
}

function "cache_to" {
  params = [name]
  result = ["type=registry,ref=${registry}/cache:${name},mode=max"]
}

function "cache_from" {
  params = [name]
  result = ["type=registry,ref=${registry}/cache:${name}"]
}

target "_common" {
  args      = { for k, v in versions : "${upper(replace(k, "-", "_"))}_VERSION" => v }
  platforms = ["linux/amd64", "linux/arm64"]
}

group "default" {
  targets = [
    "amneziawg",
    "amneziawg-go",
    "amneziawg-tools",
    "byedpi",
    "iceshrimp-net",
    "paperless-ngx",
    "pebble",
    "usque",
    "k8s-ci",
    "envsubst"
  ]
}

target "image" {
  name = replace(i.name, ".", "-")
  matrix = {
    i = [
      { name = "amneziawg-go", version = "amneziawg-go" },
      { name = "amneziawg-tools", version = "amneziawg-tools" },
      { name = "byedpi", version = "byedpi" },
      { name = "iceshrimp.net", version = "iceshrimp-net" },
      { name = "paperless-ngx", version = "paperless-ngx" },
      { name = "pebble", version = "pebble" },
      { name = "usque", version = "usque" },
      { name = "k8s-ci", version = "alpine-k8s" },
      { name = "envsubst", version = "gettext-envsubst" }
    ]
  }
  tags       = tags(i.name, versions[i.version])
  context    = "./images/${i.name}"
  inherits   = ["_common"]
  cache-to   = cache_to(i.name)
  cache-from = cache_from(i.name)
}

target "amneziawg" {
  tags    = tags("amneziawg", versions.amneziawg-go)
  context = "./images/amneziawg"
  contexts = {
    amneziawg-go    = "target:amneziawg-go"
    amneziawg-tools = "target:amneziawg-tools"
  }
  inherits   = ["_common"]
  cache-to   = cache_to("amneziawg")
  cache-from = cache_from("amneziawg")
}
