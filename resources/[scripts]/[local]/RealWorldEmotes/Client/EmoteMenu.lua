rightPosition = {x = 1150, y = 100}
leftPosition = {x = 0, y = 100}
menuPosition = {x = 0, y = 200}

if Config.MenuPosition then
  if Config.MenuPosition == "left" then
    menuPosition = leftPosition
  elseif Config.MenuPosition == "right" then
    menuPosition = rightPosition
  end
end

if Config.CustomMenuEnabled then
  local RuntimeTXD = CreateRuntimeTxd("Custom_Menu_Head")
  local Object = CreateDui(Config.MenuImage, 512, 128)
  _G.Object = Object
  local TextureThing = GetDuiHandle(Object)
  local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, "Custom_Menu_Head", TextureThing)
  Menuthing = "Custom_Menu_Head"
else
  Menuthing = "shopui_title_sm_hangar"
end

_menuPool = NativeUI.CreatePool()
emoteMenu = NativeUI.CreateMenu("감정표현", "", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing)
actionMenu = NativeUI.CreateMenu("행동", "", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing)
danceMenu = NativeUI.CreateMenu("댄스", "", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing)
_menuPool:Add(emoteMenu)
_menuPool:Add(actionMenu)
_menuPool:Add(danceMenu)

function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

local EmoteTable = {}
local FavEmoteTable = {}
local KeyEmoteTable = {}
local DanceTable = {}
local PropETable = {}
local WalkTable = {}
local FaceTable = {}
local ShareTable = {}
local FavoriteEmote = ""

Citizen.CreateThread(
  function()
    while true do
      if Config.FavKeybindEnabled then
        if IsControlPressed(0, Config.FavKeybind) then
          if not IsPedSittingInAnyVehicle(PlayerPedId()) then
            if FavoriteEmote ~= "" then
              EmoteCommandStart(nil, {FavoriteEmote, 0})
              Wait(3000)
            end
          end
        end
      end
      Citizen.Wait(1)
    end
  end
)

lang = Config.MenuLanguage

function AddEmoteMenu(menu)
  local basicdance = _menuPool:AddSubMenu(danceMenu, Config.Languages[lang]["basicdance"], "", "", Menuthing, Menuthing)
  local basicactionmenu = _menuPool:AddSubMenu(actionMenu, Config.Languages[lang]["basicaction"], "", "", Menuthing, Menuthing)
  local propmenu = _menuPool:AddSubMenu(actionMenu, Config.Languages[lang]["propemotes"], "", "", Menuthing, Menuthing)

  if Config.SharedEmotesEnabled then
    sharemenu = _menuPool:AddSubMenu(actionMenu, Config.Languages[lang]["shareemotes"], Config.Languages[lang]["shareemotesinfo"], "", Menuthing, Menuthing)
    shareddancemenu = _menuPool:AddSubMenu(danceMenu, Config.Languages[lang]["sharedanceemotes"], "", "", Menuthing, Menuthing)
    table.insert(ShareTable, "none")
  end

  if not Config.SqlKeybinding then
    unbind2item = NativeUI.CreateItem(Config.Languages[lang]["rfavorite"], Config.Languages[lang]["rfavorite"])
    unbinditem = NativeUI.CreateItem(Config.Languages[lang]["prop2info"], "")
    --favmenu = _menuPool:AddSubMenu(basicactionmenu, Config.Languages[lang]["favoriteemotes"], Config.Languages[lang]["favoriteinfo"], "", Menuthing, Menuthing)
    --favmenu:AddItem(unbinditem)
    --favmenu:AddItem(unbind2item)
    --table.insert(FavEmoteTable, Config.Languages[lang]["rfavorite"])
    --table.insert(FavEmoteTable, Config.Languages[lang]["rfavorite"])
    --table.insert(EmoteTable, Config.Languages[lang]["favoriteemotes"])
  else
    table.insert(EmoteTable, "keybinds")
    keyinfo = NativeUI.CreateItem(Config.Languages[lang]["keybinds"], Config.Languages[lang]["keybindsinfo"] .. " /emotebind [~y~num4-9~w~] [~g~emotename~w~]")
    basicactionmenu:AddItem(keyinfo)
  end

  for a, b in pairsByKeys(DP.Emotes) do
    x, y, z = table.unpack(b)
    emoteitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
    basicactionmenu:AddItem(emoteitem)
    table.insert(EmoteTable, a)
    if not Config.SqlKeybinding then
      favemoteitem = NativeUI.CreateItem(z, Config.Languages[lang]["set"] .. z .. Config.Languages[lang]["setboundemote"])
      --favmenu:AddItem(favemoteitem)
      --table.insert(FavEmoteTable, a)
    end
  end

  for a, b in pairsByKeys(DP.Dances) do
    x, y, z = table.unpack(b)
    danceitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
    sharedanceitem = NativeUI.CreateItem(z, "")
    basicdance:AddItem(danceitem)
    if Config.SharedEmotesEnabled then
      shareddancemenu:AddItem(sharedanceitem)
    end
    table.insert(DanceTable, a)
  end

  if Config.SharedEmotesEnabled then
    for a, b in pairsByKeys(DP.Shared) do
      x, y, z, otheremotename = table.unpack(b)
      if otheremotename == nil then
        shareitem = NativeUI.CreateItem(z, "/nearby (~g~" .. a .. "~w~)")
      else
        shareitem = NativeUI.CreateItem(z, "/nearby (~g~" .. a .. "~w~) " .. Config.Languages[lang]["makenearby"] .. " (~y~" .. otheremotename .. "~w~)")
      end
      sharemenu:AddItem(shareitem)
      table.insert(ShareTable, a)
    end
  end

  for a, b in pairsByKeys(DP.PropEmotes) do
    x, y, z = table.unpack(b)
    propitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
    propmenu:AddItem(propitem)
    table.insert(PropETable, a)
    if not Config.SqlKeybinding then
      propfavitem = NativeUI.CreateItem(z, Config.Languages[lang]["set"] .. z .. Config.Languages[lang]["setboundemote"])
      --favmenu:AddItem(propfavitem)
      --table.insert(FavEmoteTable, a)
    end
  end

  if not Config.SqlKeybinding then
    --[[
    favmenu.OnItemSelect = function(sender, item, index)
      if FavEmoteTable[index] == Config.Languages[lang]["rfavorite"] then
        FavoriteEmote = ""
        ShowNotification(Config.Languages[lang]["rfavorite"], 2000)
        return
      end
      if Config.FavKeybindEnabled then
        FavoriteEmote = FavEmoteTable[index]
        ShowNotification("~o~" .. firstToUpper(FavoriteEmote) .. Config.Languages[lang]["newsetemote"])
      end
    end
    ]]
  end

  basicdance.OnItemSelect = function(sender, item, index)
    EmoteMenuStart(DanceTable[index], "dances")
  end

  if Config.SharedEmotesEnabled then
    sharemenu.OnItemSelect = function(sender, item, index)
      if ShareTable[index] ~= "none" then
        target, distance = GetClosestPlayer()
        if (distance ~= -1 and distance < 3) then
          _, _, rename = table.unpack(DP.Shared[ShareTable[index]])
          TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), ShareTable[index])
          SimpleNotify(Config.Languages[lang]["sentrequestto"] .. GetPlayerName(target))
        else
          SimpleNotify(Config.Languages[lang]["nobodyclose"])
        end
      end
    end

    shareddancemenu.OnItemSelect = function(sender, item, index)
      target, distance = GetClosestPlayer()
      if (distance ~= -1 and distance < 3) then
        _, _, rename = table.unpack(DP.Dances[DanceTable[index]])
        TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), DanceTable[index], "Dances")
        SimpleNotify(Config.Languages[lang]["sentrequestto"] .. GetPlayerName(target))
      else
        SimpleNotify(Config.Languages[lang]["nobodyclose"])
      end
    end
  end

  propmenu.OnItemSelect = function(sender, item, index)
    EmoteMenuStart(PropETable[index], "props")
  end

  basicactionmenu.OnItemSelect = function(sender, item, index)
    print(EmoteTable[index])
    if EmoteTable[index] ~= Config.Languages[lang]["favoriteemotes"] then
      EmoteMenuStart(EmoteTable[index], "emotes")
    end
  end
end

function AddCancelEmote(menu)
  local newitem = NativeUI.CreateItem(Config.Languages[lang]["cancelemote"], Config.Languages[lang]["cancelemoteinfo"])
  menu:AddItem(newitem)
  menu.OnItemSelect = function(sender, item, checked_)
    if item == newitem then
      EmoteCancel()
      DestroyAllProps()
    end
  end
end

function AddWalkMenu(menu)
  local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]["walkingstyles"], "", "", Menuthing, Menuthing)

  walkreset = NativeUI.CreateItem(Config.Languages[lang]["normalreset"], Config.Languages[lang]["resetdef"])
  submenu:AddItem(walkreset)
  table.insert(WalkTable, Config.Languages[lang]["resetdef"])

  --WalkInjured = NativeUI.CreateItem("부상", "")
  --submenu:AddItem(WalkInjured)
  --table.insert(WalkTable, "move_m@injured")

  for a, b in pairsByKeys(DP.Walks) do
    x = table.unpack(b)
    walkitem = NativeUI.CreateItem(a, "")
    submenu:AddItem(walkitem)
    table.insert(WalkTable, x)
  end

  submenu.OnItemSelect = function(sender, item, index)
    if item ~= walkreset then
      WalkMenuStart(WalkTable[index])
    else
      ResetPedMovementClipset(PlayerPedId())
    end
  end
end

function AddFaceMenu(menu)
  local submenu = _menuPool:AddSubMenu(menu, Config.Languages[lang]["moods"], "", "", Menuthing, Menuthing)

  facereset = NativeUI.CreateItem(Config.Languages[lang]["normalreset"], Config.Languages[lang]["resetdef"])
  submenu:AddItem(facereset)
  table.insert(FaceTable, "")

  for a, b in pairsByKeys(DP.Expressions) do
    x, y, z = table.unpack(b)
    faceitem = NativeUI.CreateItem(a, "")
    submenu:AddItem(faceitem)
    table.insert(FaceTable, a)
  end

  submenu.OnItemSelect = function(sender, item, index)
    if item ~= facereset then
      EmoteMenuStart(FaceTable[index], "expression")
    else
      ClearFacialIdleAnimOverride(PlayerPedId())
    end
  end
end

function OpenEmoteMenu()
  emoteMenu:Visible(not emoteMenu:Visible())
end
function OpenActionMenu()
  actionMenu:Visible(not actionMenu:Visible())
end
function OpenDanceMenu()
  danceMenu:Visible(not danceMenu:Visible())
end

function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

AddWalkMenu(emoteMenu)
AddFaceMenu(emoteMenu)
AddEmoteMenu(actionMenu)
AddCancelEmote(actionMenu)
AddCancelEmote(danceMenu)

_menuPool:RefreshIndex()

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      _menuPool:ProcessMenus()
    end
  end
)