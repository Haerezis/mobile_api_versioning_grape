class API::Param::Tests::Root < API::Base
  resource :tests do
    mount API::Param::Tests::Index
  end
end
