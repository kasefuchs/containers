function "make_tags" {
  params = [name, version]
  result = [
    "ghcr.io/kasefuchs/containers/${name}:latest",
    "ghcr.io/kasefuchs/containers/${name}:${version}",
    "ghcr.io/kasefuchs/containers/${name}:v${version}"
  ]
}

variable "versions" {
  type = map(string)
}

target "_versions" {
  args = {
    USQUE_VERSION                   = versions.usque
    BYEDPI_VERSION                  = versions.byedpi
    PEBBLE_VERSION                  = versions.pebble
    ALPINE_K8S_VERSION              = versions.alpine-k8s
    ICESHRIMP_NET_VERSION           = versions.iceshrimp-net
    GETTEXT_ENVSUBST_VERSION        = versions.gettext-envsubst
    ICESHRIMP_OBJECTSTORAGE_VERSION = versions.iceshrimp-objectstorage
  }
}

target "_common" {
  inherits  = ["_versions"]
  platforms = ["linux/amd64", "linux/arm64"]
}

group "default" {
  targets = [
    "byedpi",
    "iceshrimp-net",
    "pebble",
    "usque",
    "k8s-ci",
    "envsubst"
  ]
}

target "byedpi" {
  tags      = make_tags("byedpi", versions.byedpi)
  context   = "./images/byedpi"
  inherits  = ["_common"]
  platforms = ["linux/amd64", "linux/arm/v7", "linux/arm64", "linux/ppc64le"]
}

target "iceshrimp-net" {
  tags     = make_tags("iceshrimp.net", versions.iceshrimp-net)
  context  = "./images/iceshrimp.net"
  inherits = ["_common"]
}

target "pebble" {
  tags     = make_tags("pebble", versions.pebble)
  context  = "./images/pebble"
  inherits = ["_common"]
}

target "usque" {
  tags     = make_tags("usque", versions.usque)
  context  = "./images/usque"
  inherits = ["_common"]
}

target "k8s-ci" {
  tags     = make_tags("k8s-ci", versions.alpine-k8s)
  context  = "./images/k8s-ci"
  inherits = ["_common"]
}

target "envsubst" {
  tags     = make_tags("envsubst", versions.gettext-envsubst)
  context  = "./images/envsubst"
  inherits = ["_common"]
}
