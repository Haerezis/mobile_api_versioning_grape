module API
  module Header
    class Endpoints < API::Base
        prefix "header"
        CURRENT_VERSION = "2025-01-31"
        version CURRENT_VERSION, using: :hb_date_header

        mount API::Header::Tests::Root
    end
  end
end
