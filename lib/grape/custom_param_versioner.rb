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


        # Redefine this method to prevent allowing no version given
        def before
          potential_version = Rack::Utils.parse_nested_query(env[Rack::QUERY_STRING])[parameter_key]
          # Next list is uncommented in upstream, allowing blank version param
          # return if potential_version.blank?

          version_not_found! unless potential_version_match?(potential_version)
          env[Grape::Env::API_VERSION] = potential_version
          env[Rack::RACK_REQUEST_QUERY_HASH].delete(parameter_key) if env.key? Rack::RACK_REQUEST_QUERY_HASH
        end

        # Redefine this method to handle semver versions
        def potential_version_match?(potential_version)
          semver_potential_version = to_semver_version(potential_version)
          semver_versions.blank? || semver_versions.any? { |v| semver_potential_version[0] == v[0] && semver_potential_version[1] <= v[1] }
        end
      end
    end
  end
end
