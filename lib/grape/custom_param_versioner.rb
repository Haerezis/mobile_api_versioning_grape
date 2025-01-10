require "grape"

module Grape
  module Middleware
    module Versioner
      class CustomParam < Param
        SEMVER_REGEX = /^v?(?<major>[1-9][0-9]*)(\.(?<minor>[0-9]+))?$/

        def to_semver_version(version)
          SEMVER_REGEX.match(version)&.yield_self { |m| [ m[:major].to_i, m[:minor].to_i ] }
        end

        def semver_versions
          @semver_versions ||= versions.map { |version| to_semver_version(version) }.compact
        end

        def potential_version_match?(potential_version)
          semver_potential_version = to_semver_version(potential_version)
          semver_versions.blank? || semver_versions.any? { |v| semver_potential_version[0] == v[0] && semver_potential_version[1] <= v[1] }
        end
      end
    end
  end
end
