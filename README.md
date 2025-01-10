# README

Test application to investigate if Grape can be use for a versioning system for the Mobile API.

## Test

Run the application :
```bash
rails s
```

Curl calls :
```bash
# Legacy version, IN-PATH version
curl http://127.0.0.1:3000/api/user/v1/tests.json
# New version, 1st instance of "old" minor version : everything called with a version <= 2.2 should be answered by 2.2 endpoint
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.0
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.1
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.2

# 2nd instance of "old" minor version : everything called with a version <= 2.4 should be answered by 2.4 endpoint
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.3
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.4

# 3rd instance of "old" minor version : everything called with a version == 2.5 should be answered by 2.5 endpoint
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.5

# latest/bleeding edge version : everything called with a version > 2.5 (but still under 2.CURRENT_MINOR_VERSION) should be answered by the "unversioned" endpoint
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.6
curl http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.7

# Theses should fail
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/user/v2/tests.json
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/user/v2.0/tests.json
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/user/tests.json
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.8
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/user/tests.json\?apiver\=v2.42
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/api/user/tests.json\?apiver\=v3.0
```
