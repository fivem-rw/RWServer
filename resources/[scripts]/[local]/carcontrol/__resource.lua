resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "vrp"

ui_page "html/carcontrol.html"

file {
  "html/carbon.jpg",
  "html/carcontrol.html",
  "html/doorFrontLeft.png",
  "html/doorFrontRight.png",
  "html/doorRearLeft.png",
  "html/doorRearRight.png",
  "html/frontHood.png",
  "html/ignition.png",
  "html/rearHood.png",
  "html/rearHood2.png",
  "html/seatFrontLeft.png",
  "html/template.html",
  "html/windowFrontLeft.png",
  "html/windowFrontRight.png",
  "html/windowRearLeft.png",
  "html/windowRearRight.png",
  "html/interiorLight.png"
}
shared_script "@evp/main.lua"
client_scripts {
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "utils.lua",
  "client.lua",
  "cl_seatseater.lua"
}
