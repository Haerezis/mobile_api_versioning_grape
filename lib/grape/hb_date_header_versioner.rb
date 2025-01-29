require "grape"

module Grape
  module Middleware
    module Versioner
      class HbDateHeader < AcceptVersionHeader
        ISO8601_REGEX = /(\d{4})-(\d\d)-(\d\d)/

        def before
          potential_version = (env[Grape::Http::Headers::HTTP_ACCEPT_VERSION] || "").strip

          if potential_version.empty?
            # If no Accept-Version header:
            throw :error, status: 406, headers: error_headers, message: "Accept-Version header must be set." if versions && strict?
            return
          end

          # If the requested version is not supported:
          throw :error, status: 406, headers: error_headers, message: "The requested version is not supported." unless potential_version_match?(potential_version)

          env[Grape::Env::API_VERSION] = potential_version
        end

        def to_date(version)
          return nil unless ISO8601_REGEX.match?(version)

          DateTime.iso8601(version)
        rescue Date::Error
          nil
        end

        def date_versions
          @date_versions ||= versions.map { |v| to_date(v) }.uniq.compact
        end

        def potential_version_match?(potential_version)
          date_potential_version = to_date(potential_version)

          return false if date_potential_version.nil?

          date_versions.blank? || date_versions.any? { |v| date_potential_version <= v }
        end
      end
    end
  end
end
