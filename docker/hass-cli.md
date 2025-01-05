## Baisc info

By default, hass-cli outputs in YAML format. To switch to JSON output, add the `-o json` flag. This is particularly useful when piping the output to `jq` for JSON processing.

## Create areas

**command:**
```bash
hass-cli area create main kitchen bedroom        
```

## Delete areas

**command:**
```bash
hass-cli area delete bedroom
```

## Create long live access token 

**raw command:**
```json
{"type":"auth/long_lived_access_token","lifespan":3650,"client_name":"hasscli","id":79}
```

**command:**
```bash
hass-cli raw ws auth/long_lived_access_token --json='{"lifespan":3650,"client_name":"hass-cli"}'
```

**results:**
```yaml
id: 1
type: result
success: true
result: 
    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkZWNmYmI1ZGQ1MjQ0ZmYyYTcyY2YzZGQyODJjM2M3MyIsImlhdCI6MTczNTExNzYxNiwiZXhwIjoyMDUwNDc3NjE2fQ.nrWX6LbcWAEYiFbOrjdM7SKDCdQmbhBQL40C32UbQRY
```



## Get list of refresh tokens

**raw command:**
```json
{"type":"auth/refresh_tokens","id":80}
```

**command:**
```bash
hass-cli raw ws auth/refresh_tokens
```

**results:**
```yaml
id: 1
type: result
success: true
result:
   -  auth_provider_type: homeassistant
      client_icon: mdi:robot
      client_id:
      client_name: Home Assistant CLI
      created_at: '2024-12-24T22:27:25.222519+00:00'
      expire_at:
      id: 0255d5d3e7514b1f89793f21db1662fc
      is_current: true
      last_used_at: '2024-12-24T22:27:25.222555+00:00'
      last_used_ip:
      type: long_lived_access_token
   -  auth_provider_type: homeassistant
      client_icon:
      client_id: http://localhost:8123/
      client_name:
      created_at: '2024-12-24T22:33:36.140604+00:00'
      expire_at: '2025-03-25T08:59:34.216587+00:00'
      id: 0b3ebe708caa4cadb64c670c60dbda59
      is_current: false
      last_used_at: '2024-12-25T08:59:34.216587+00:00'
      last_used_ip: 172.18.0.1
      type: normal
   -  auth_provider_type:
      client_icon:
      client_id:
      client_name: hasscli
      created_at: '2024-12-25T09:04:51.226733+00:00'
      expire_at:
      id: a9dd07efd31c446880dbd65b331fb873
      is_current: false
      last_used_at: '2024-12-25T09:04:51.227576+00:00'
      last_used_ip:
      type: long_lived_access_token
   -  auth_provider_type:
      client_icon:
      client_id:
      client_name: hass-cli
      created_at: '2024-12-25T09:06:56.563730+00:00'
      expire_at:
      id: decfbb5dd5244ff2a72cf3dd282c3c73
      is_current: false
      last_used_at: '2024-12-25T09:06:56.564453+00:00'
      last_used_ip:
      type: long_lived_access_token
```


## Delete long live access token 

**raw command:**
```json
{"type":"auth/delete_refresh_token","refresh_token_id":"decfbb5dd5244ff2a72cf3dd282c3c73","id":42}	1735118043.6735342
```

**command:**
```bash
hass-cli raw ws auth/delete_refresh_token --json='{"refresh_token_id":"decfbb5dd5244ff2a72cf3dd282c3c73"}'
```

**results:**
```yaml
id: 1
type: result
success: true
result: {}
```