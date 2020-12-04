resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"
shared_script "@evp/main.lua"
-- Client Scripts
client_script "client/main.lua"

-- Server Scripts
server_script "server/main.lua"

-- NUI Default Page
ui_page("client/html/index.html")

files(
    {
        "client/html/index.html",
        "client/html/sounds/doorbell.ogg",
        "client/html/sounds/doorknock.ogg",
        "client/html/sounds/robberydraw.ogg",
        "client/html/sounds/robberyglass.ogg",
        "client/html/sounds/robberyglassbreak.ogg",
        "client/html/sounds/towtruck.ogg",
        "client/html/sounds/towtruck2.ogg",
        "client/html/sounds/radioclick.ogg",
        "client/html/sounds/radiostatic1.ogg",
        "client/html/sounds/radiostatic2.ogg",
        "client/html/sounds/radiostatic3.ogg",
        "client/html/sounds/deepfried.ogg",
        "client/html/sounds/jumpland.ogg",
        "client/html/sounds/rapell.ogg",
        "client/html/sounds/heartmonbeat.ogg",
        "client/html/sounds/heartmondead.ogg",
        "client/html/sounds/ventilator.ogg",
        "client/html/sounds/Shop.ogg",
        "client/html/sounds/payphonestart.ogg",
        "client/html/sounds/payphoneend.ogg",
        "client/html/sounds/payphoneringing.ogg",
        "client/html/sounds/consume.ogg",
        "client/html/sounds/metaldetector.ogg",
        "client/html/sounds/metaldetected.ogg",
        "client/html/sounds/Clothes1.ogg",
        "client/html/sounds/beltalarm.ogg",
        "client/html/sounds/seatbelt.ogg",
        "client/html/sounds/seatbeltoff.ogg",
        "client/html/sounds/StashOpen.ogg",
        "client/html/sounds/LockerOpen.ogg",
        "client/html/sounds/DoorOpen.ogg",
        "client/html/sounds/DoorClose.ogg",
        "client/html/sounds/Stash.ogg",
        "client/html/sounds/lock.ogg",
        "client/html/sounds/unlock.ogg",
        "client/html/sounds/handcuff.ogg",
        "client/html/sounds/jaildoor.ogg",
        "client/html/sounds/photo.ogg",
        "client/html/sounds/lockpick.ogg",
        "client/html/sounds/impactdrill.ogg",
        "client/html/sounds/dice.ogg",
        "client/html/sounds/keydoors.ogg",
        "client/html/sounds/pickup.ogg",
        "client/html/sounds/cellcall.ogg",
        "client/html/sounds/windows.ogg",
        "client/html/sounds/demo.ogg",
        "client/html/sounds/flashbang.ogg",
        "client/html/sounds/pinpull.ogg",
        "client/html/sounds/pager.ogg"
    }
)
