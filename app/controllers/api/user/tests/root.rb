class API::User::Tests::Root < API::Base
  resource :tests do
    mount API::User::Tests::Index
  end
end
