variable "versions" {
  type = map(string)
  default = {
    # renovate: datasource=docker depName=tazihad/byedpi extractVersion=^v(?<version>.*)$
    byedpi = "0.17.3"

    # renovate: datasource=repology depName=debian_13_backports/cmake extractVersion=^(?<version>\d+\.\d+\.\d+)
    cmake = "4.3.2"

    # renovate: datasource=docker depName=iceshrimp.dev/iceshrimp/iceshrimp.net extractVersion=^v(?<version>.*)$ versioning=docker
    iceshrimp-net = "2026.1.1-beta"

    # renovate: datasource=github-releases depName=canonical/pebble extractVersion=^v(?<version>.*)$
    pebble = "1.32.0"

    # renovate: datasource=github-releases depName=microsoft/vcpkg versioning=loosy
    vcpkg = "2026.06.24"

    # renovate: datasource=github-releases depName=Diniboy1123/usque extractVersion=^v(?<version>.*)$
    usque = "4.2.0"
  }
}

target "_versions" {
  args = {
    BYEDPI_VERSION        = versions.byedpi
    CMAKE_VERSION         = versions.cmake
    ICESHRIMP_NET_VERSION = versions.iceshrimp-net
    PEBBLE_VERSION        = versions.pebble
    VCPKG_VERSION         = versions.vcpkg
    USQUE_VERSION         = versions.usque
  }
}
