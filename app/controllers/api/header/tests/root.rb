class API::Header::Tests::Root < API::Base
  resource :tests do
    mount API::Header::Tests::Index
  end
end
