class API::Param::Tests::Index < API::Base
    # resource :tests do
    # Legacy v1 in-path versioning
    version "v1" do
      get do
        present({ test: true, v: "v1 legacy" })
      end
    end

    # 1st instance of param versioning on v2
    version "v2.2", using: :custom_param do
      get do
        present({ test: true, v: "v2.2" })
      end
    end

    # 2nd instance of param versioning on v2
    version "v2.4", using: :custom_param do
      get do
        present({ test: true, v: "v2.4" })
      end
    end

    # 3rd instance of param versioning on v2
    version "v2.5", using: :custom_param do
      get do
        present({ test: true, v: "v2.5" })
      end
    end

    # Latest (bleeding edge) of api
    get do
      present({ test: true })
    end
  # end
end
