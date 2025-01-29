require "grape"
require_relative "#{Rails.root}/lib/grape/custom_param_versioner.rb"
require_relative "#{Rails.root}/lib/grape/hb_date_header_versioner.rb"

module API
  class Base < Grape::API
    format :json
    default_error_formatter :json
    content_type :json, "application/json"
  end
end
