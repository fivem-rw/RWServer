resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "blip_info"

shared_script "@evp/main.lua"

client_scripts {
  "config.lua",
  "client.lua"
}

server_scripts {
  "@vrp/lib/utils.lua",
  "config.lua"
  --"@vrp/lib/utf8-utils.lua",
  --"tmp/merge.lua"
}

export "BuildBlips"