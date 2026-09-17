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

target "_versions" {
  args = {
    ALPINE_K8S_VERSION              = versions.alpine-k8s
    AMNEZIAWG_GO_VERSION            = versions.amneziawg-go
    AMNEZIAWG_TOOLS_VERSION         = versions.amneziawg-tools
    BYEDPI_VERSION                  = versions.byedpi
    GETTEXT_ENVSUBST_VERSION        = versions.gettext-envsubst
    ICESHRIMP_NET_VERSION           = versions.iceshrimp-net
    ICESHRIMP_OBJECTSTORAGE_VERSION = versions.iceshrimp-objectstorage
    PAPERLESS_NGX_VERSION           = versions.paperless-ngx
    PEBBLE_VERSION                  = versions.pebble
    USQUE_VERSION                   = versions.usque
  }
}

target "_common" {
  inherits  = ["_versions"]
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

target "amneziawg-go" {
  tags       = tags("amneziawg-go", versions.amneziawg-go)
  context    = "./images/amneziawg-go"
  inherits   = ["_common"]
  cache-to   = cache_to("amneziawg-go")
  cache-from = cache_from("amneziawg-go")
}

target "amneziawg-tools" {
  tags       = tags("amneziawg-tools", versions.amneziawg-tools)
  context    = "./images/amneziawg-tools"
  inherits   = ["_common"]
  cache-to   = cache_to("amneziawg-tools")
  cache-from = cache_from("amneziawg-tools")
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

target "byedpi" {
  tags       = tags("byedpi", versions.byedpi)
  context    = "./images/byedpi"
  inherits   = ["_common"]
  cache-to   = cache_to("byedpi")
  cache-from = cache_from("byedpi")
}

target "iceshrimp-net" {
  tags       = tags("iceshrimp.net", versions.iceshrimp-net)
  context    = "./images/iceshrimp.net"
  inherits   = ["_common"]
  cache-to   = cache_to("iceshrimp.net")
  cache-from = cache_from("iceshrimp.net")
}

target "paperless-ngx" {
  tags       = tags("paperless-ngx", versions.paperless-ngx)
  context    = "./images/paperless-ngx"
  inherits   = ["_common"]
  cache-to   = cache_to("paperless-ngx")
  cache-from = cache_from("paperless-ngx")
}

target "pebble" {
  tags       = tags("pebble", versions.pebble)
  context    = "./images/pebble"
  inherits   = ["_common"]
  cache-to   = cache_to("pebble")
  cache-from = cache_from("pebble")
}

target "usque" {
  tags       = tags("usque", versions.usque)
  context    = "./images/usque"
  inherits   = ["_common"]
  cache-to   = cache_to("usque")
  cache-from = cache_from("usque")
}

target "k8s-ci" {
  tags       = tags("k8s-ci", versions.alpine-k8s)
  context    = "./images/k8s-ci"
  inherits   = ["_common"]
  cache-to   = cache_to("k8s-ci")
  cache-from = cache_from("k8s-ci")
}

target "envsubst" {
  tags       = tags("envsubst", versions.gettext-envsubst)
  context    = "./images/envsubst"
  inherits   = ["_common"]
  cache-to   = cache_to("envsubst")
  cache-from = cache_from("envsubst")
}
