module API
  module Param
    class Endpoints < API::Base
        prefix "param"
        CURRENT_MAJOR_VERSION = 2
        CURRENT_MINOR_VERSION = 7
        version "v#{CURRENT_MAJOR_VERSION}.#{CURRENT_MINOR_VERSION}", using: :custom_param

        mount API::Param::Tests::Root
    end
  end
end
