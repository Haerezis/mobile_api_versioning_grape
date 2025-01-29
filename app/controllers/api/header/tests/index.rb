class API::Header::Tests::Index < API::Base
    # resource :tests do
    # Legacy v1 in-path versioning
    version "v1" do
      get do
        present({ test: true, v: "v1 legacy" })
      end
    end

    # 1st instance of param versioning on v2
    version "2025-01-10", using: :hb_date_header do
      get do
        present({ test: true, v: "2025-01-10" })
      end
    end

    # 2nd instance of param versioning on v2
    version "2025-01-12", using: :hb_date_header do
      get do
        present({ test: true, v: "2025-01-12" })
      end
    end

    # 3rd instance of param versioning on v2
    version "2025-01-13", using: :hb_date_header do
      get do
        present({ test: true, v: "2025-01-13" })
      end
    end

    # Latest (bleeding edge) of api
    get do
      present({ test: true, latest: true, current_version: API::Header::Endpoints::CURRENT_VERSION })
    end
  # end
end
