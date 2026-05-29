function "make_tags" {
  params = [name, version]
  result = [
    "ghcr.io/kasefuchs/containers/${name}:latest",
    "ghcr.io/kasefuchs/containers/${name}:${version}",
    "ghcr.io/kasefuchs/containers/${name}:v${version}"
  ]
}

target "_common" {
  inherits  = ["_versions"]
  platforms = ["linux/amd64", "linux/arm64"]
}

group "default" {
  targets = ["byedpi", "cmake", "iceshrimp-net", "pebble", "usque", "vcpkg"]
}

target "byedpi" {
  tags      = make_tags("byedpi", versions.byedpi)
  context   = "./images/byedpi"
  inherits  = ["_common"]
  platforms = ["linux/amd64", "linux/arm/v7", "linux/arm64", "linux/ppc64le"]
}

target "cmake" {
  tags     = make_tags("cmake", versions.cmake)
  context  = "./images/cmake"
  inherits = ["_common"]
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

target "vcpkg" {
  tags    = make_tags("vcpkg", versions.vcpkg)
  context = "./images/vcpkg"
  contexts = {
    cmake = "target:cmake"
  }
  inherits = ["_common"]
}
