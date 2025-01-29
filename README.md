# README

Test application to investigate if Grape can be use for a versioning system for the Mobile API.

## Test Param versioning

Run the application :
```bash
rails s
```

Curl calls :
```bash
# Legacy version, IN-PATH version
curl http://127.0.0.1:3000/api/param/v1/tests.json
# New version, 1st instance of "old" minor version : everything called with a version <= 2.2 should be answered by 2.2 endpoint
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.0
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.1
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.2

# 2nd instance of "old" minor version : everything called with a version <= 2.4 should be answered by 2.4 endpoint
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.3
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.4

# 3rd instance of "old" minor version : everything called with a version == 2.5 should be answered by 2.5 endpoint
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.5

# latest/bleeding edge version : everything called with a version > 2.5 (but still under 2.CURRENT_MINOR_VERSION) should be answered by the "unversioned" endpoint
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.6
curl http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.7

# Theses should fail
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/param/v2/tests.json
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/param/v2.0/tests.json
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/param/tests.json
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.8
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/param/tests.json\?apiver\=v2.42
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/param/tests.json\?apiver\=v3.0
```


## Test Header Date versioning

Run the application :
```bash
rails s
```

Curl calls :
```bash
# Legacy version, IN-PATH version
curl http://127.0.0.1:3000/api/header/v1/tests.json
# 1st instance of "old"  version : everything called with a version <= 2025-01-10 should be answered by 2025-01-10 endpoint
curl -H "Accept-Version:2025-01-01" http://127.0.0.1:3000/api/header/tests.json
curl -H "Accept-Version:2025-01-02" http://127.0.0.1:3000/api/header/tests.json
curl -H "Accept-Version:2025-01-03" http://127.0.0.1:3000/api/header/tests.json

# 2nd instance of "old" version : everything called with a version <= 2025-01-12 should be answered by 2025-01-12 endpoint
curl -H "Accept-Version:2025-01-11" http://127.0.0.1:3000/api/header/tests.json
curl -H "Accept-Version:2025-01-12" http://127.0.0.1:3000/api/header/tests.json

# 3rd instance of "old" version : everything called with a version == 2025-01-13 should be answered by 2025-01-13 endpoint
curl -H "Accept-Version:2025-01-13" http://127.0.0.1:3000/api/header/tests.json

# latest/bleeding edge version : everything called with a version > 2025-01-14 (but still under "latest" 2025-01-31) should be answered by the "unversioned"/"latest" endpoint
curl -H "Accept-Version:2025-01-14" http://127.0.0.1:3000/api/header/tests.json
curl -H "Accept-Version:2025-01-20" http://127.0.0.1:3000/api/header/tests.json

# No version should be served by the first (oldest) version 2025-01-10, because strict mode is not enabled
curl http://127.0.0.1:3000/api/header/tests.json

# Theses should fail
curl -H "Accept-Version:2025-01"    -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/header/tests.json
curl -H "Accept-Version:2025"       -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/header/tests.json
curl -H "Accept-Version:2026-01-01" -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/header/tests.json
curl -H "Accept-Version:2025-02-01" -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/header/tests.json
```
