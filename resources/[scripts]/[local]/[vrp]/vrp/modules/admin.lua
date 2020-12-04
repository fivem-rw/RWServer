local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")

local function ch_whitelist(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.whitelist") then
    vRP.prompt(
      player,
      "고유번호: ",
      "",
      function(player, id)
        id = parseInt(id)
        vRP.setWhitelisted(id, true)
        vRPclient.notify(player, {"whitelisted user " .. id})
      end
    )
  end
end

local function ch_unwhitelist(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.unwhitelist") then
    vRP.prompt(
      player,
      "고유번호: ",
      "",
      function(player, id)
        id = parseInt(id)
        vRP.setWhitelisted(id, false)
        vRPclient.notify(player, {"un-whitelisted user " .. id})
      end
    )
  end
end

local function ch_addgroup(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.add") then
    local groupTopLevel = vRP.getGroupTopLevel(user_id)
    if groupTopLevel > 0 then
      vRP.prompt(
        player,
        "고유번호: ",
        "",
        function(player, id)
          id = parseInt(id)
          vRP.prompt(
            player,
            "그룹/직업명: ",
            "",
            function(player, group)
              local source = vRP.getUserSource(id)
              if source then
                if vRP.isExistGroup(group) and groupTopLevel > vRP.getGroupLevel(group) then
                  local groupTopLevelTarget = vRP.getGroupTopLevel(id)
                  if groupTopLevel > groupTopLevelTarget or user_id == id then
                    vRP.addUserGroup(id, group)
                    vRPclient.notify(player, {"~g~고유번호 ~w~" .. id .. " 에 ~w~" .. group .. " ~g~추가 완료"})
                  else
                    vRPclient.notify(player, {"~r~해당 유저를 변경할 권한이 없습니다."})
                  end
                else
                  vRPclient.notify(player, {"~r~그룹이 존재하지 않습니다."})
                end
              else
                vRPclient.notify(player, {"~r~접속중인 유저가 아닙니다."})
              end
            end
          )
        end
      )
    end
  end
end

local function ch_removegroup(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.remove") then
    local groupTopLevel = vRP.getGroupTopLevel(user_id)
    if groupTopLevel > 0 then
      vRP.prompt(
        player,
        "고유번호: ",
        "",
        function(player, id)
          id = parseInt(id)
          vRP.prompt(
            player,
            "그룹/직업명: ",
            "",
            function(player, group)
              local source = vRP.getUserSource(id)
              if source then
                if vRP.isExistGroup(group) and groupTopLevel > vRP.getGroupLevel(group) then
                  local groupTopLevelTarget = vRP.getGroupTopLevel(id)
                  if groupTopLevel > groupTopLevelTarget or user_id == id then
                    vRP.removeUserGroup(id, group)
                    vRPclient.notify(player, {"~g~고유번호 ~w~" .. id .. " 에 ~w~" .. group .. " ~g~제거 완료"})
                  else
                    vRPclient.notify(player, {"~r~해당 유저를 변경할 권한이 없습니다."})
                  end
                else
                  vRPclient.notify(player, {"~r~그룹이 존재하지 않습니다."})
                end
              else
                vRPclient.notify(player, {"~r~접속중인 유저가 아닙니다."})
              end
            end
          )
        end
      )
    end
  end
end

local function ch_addpart(player, perm)
  vRP.prompt(
    player,
    "고유번호: ",
    "",
    function(player, id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(
          player,
          "직급: ",
          "",
          function(player, group)
            if group ~= nil then
              if vRP.hasPermissionByGroup(group, perm) then
                if not vRP.hasGroup(id, group) then
                  vRP.addUserGroup(id, group)
                  vRPclient.notify(player, {"~g~고유번호 ~r~" .. id .. "~g~에 ~r~" .. group .. "~g~이 추가되었습니다."})
                else
                  vRPclient.notify(player, {"~r~이 사용자는 이미 해당 직급을 가지고 있습니다."})
                end
              else
                vRPclient.notify(player, {"~r~해당 직급은 임명할 권한이 없습니다."})
              end
            else
              vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
            end
          end
        )
      end
    end
  )
end

local function ch_removepart(player, perm)
  vRP.prompt(
    player,
    "고유번호: ",
    "",
    function(player, id)
      id = parseInt(id)
      if id ~= nil then
        vRP.prompt(
          player,
          "직급: ",
          "",
          function(player, group)
            if group ~= nil then
              if vRP.hasPermissionByGroup(group, perm) then
                if vRP.hasGroup(id, group) then
                  vRP.removeUserGroup(id, group)
                  vRPclient.notify(player, {"~g~고유번호 ~r~" .. id .. "~g~에 ~r~" .. group .. "~g~이 제거되었습니다."})
                else
                  vRPclient.notify(player, {"~r~이 사용자는 해당 직급을 가지고 있지 않습니다."})
                end
              else
                vRPclient.notify(player, {"~r~해당 직급을 제거할 권한이 없습니다."})
              end
            else
              vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
            end
          end
        )
      end
    end
  )
end
-- 임시스태프 직급

local function ch_addstaffab(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addstaffab") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "임시스태프",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "임시스태프" then
                  vRP.addUserGroup(id, "임시스태프")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_delstaffab(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removestaffab") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "임시스태프")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

-- EMS 알바

local function ch_addemsab(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addemsab") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "소방청알바",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "소방청알바" then
                  vRP.addUserGroup(id, "emsab")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_delemsab(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removeemsab") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "emsab")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

-- 교정본부

local function ch_addkys(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addkys") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "부본부장, 교정이사관, 교정과장, 서기관, 교정관, 교감, 교위관, 교사관, 교도관, 훈련생",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "부본부장" then
                  vRP.addUserGroup(id, "교정 부본부장")
                end
                if groupprefix == "교정이사관" then
                  vRP.addUserGroup(id, "교정 이사관")
                end                
                if groupprefix == "교정과장" then
                  vRP.addUserGroup(id, "교정 과장")
                end
                if groupprefix == "서기관" then
                  vRP.addUserGroup(id, "서기관")
                end                
                if groupprefix == "교정관" then
                  vRP.addUserGroup(id, "교정관")
                end
                if groupprefix == "교감" then
                  vRP.addUserGroup(id, "교감")
                end
                if groupprefix == "교위관" then
                  vRP.addUserGroup(id, "교위관")
                end
                if groupprefix == "교사관" then
                  vRP.addUserGroup(id, "교사관")
                end
                if groupprefix == "교도관" then
                  vRP.addUserGroup(id, "교도관")
                end
                if groupprefix == "훈련생" then
                  vRP.addUserGroup(id, "교정본부 훈련생")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_delkys(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removekys") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "교정 부본부장")
        vRP.removeUserGroup(id, "교정 이사관")
        vRP.removeUserGroup(id, "교정 과장")
        vRP.removeUserGroup(id, "서기관")
        vRP.removeUserGroup(id, "교정관")
        vRP.removeUserGroup(id, "교감")
        vRP.removeUserGroup(id, "교위관")
        vRP.removeUserGroup(id, "교사관")
        vRP.removeUserGroup(id, "교도관")
        vRP.removeUserGroup(id, "교정본부 훈련생")
        vRP.addUserGroup(id, "실업자")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

local function ch_addkys2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addkys2") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "교정 이사관, 교정과장, 서기관, 교정관, 교감, 교위관, 교사관, 교도관, 훈련생",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "교정 이사관" then
                  vRP.addUserGroup(id, "교정 이사관")
                end                
                if groupprefix == "교정과장" then
                  vRP.addUserGroup(id, "교정 과장")
                end
                if groupprefix == "서기관" then
                  vRP.addUserGroup(id, "서기관")
                end                
                if groupprefix == "교정관" then
                  vRP.addUserGroup(id, "교정관")
                end
                if groupprefix == "교감" then
                  vRP.addUserGroup(id, "교감")
                end
                if groupprefix == "교위관" then
                  vRP.addUserGroup(id, "교위관")
                end
                if groupprefix == "교사관" then
                  vRP.addUserGroup(id, "교사관")
                end
                if groupprefix == "교도관" then
                  vRP.addUserGroup(id, "교도관")
                end
                if groupprefix == "훈련생" then
                  vRP.addUserGroup(id, "교정본부 훈련생")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_delkys2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removekys2") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "교정 이사관")
        vRP.removeUserGroup(id, "교정 과장")
        vRP.removeUserGroup(id, "서기관")
        vRP.removeUserGroup(id, "교정관")
        vRP.removeUserGroup(id, "교감")
        vRP.removeUserGroup(id, "교위관")
        vRP.removeUserGroup(id, "교사관")
        vRP.removeUserGroup(id, "교도관")
        vRP.removeUserGroup(id, "교정본부 훈련생")
        vRP.addUserGroup(id, "실업자")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

-- 리얼 문화방송

local function ch_addcbs(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addcbs") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "부국장, 사장, 부사장, 차장, 과장, 대리, 사원, 인턴",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "부국장" then
                  vRP.addUserGroup(id, "리얼문화방송 부국장")
                end
                if groupprefix == "사장" then
                  vRP.addUserGroup(id, "리얼문화방송 사장")
                end
                if groupprefix == "부사장" then
                  vRP.addUserGroup(id, "리얼문화방송 부사장")
                end
                if groupprefix == "차장" then
                  vRP.addUserGroup(id, "리얼문화방송 차장")
                end
                if groupprefix == "과장" then
                  vRP.addUserGroup(id, "리얼문화방송 과장")
                end
                if groupprefix == "대리" then
                  vRP.addUserGroup(id, "리얼문화방송 대리")
                end
                if groupprefix == "사원" then
                  vRP.addUserGroup(id, "리얼문화방송 사원")
                end
                if groupprefix == "인턴" then
                  vRP.addUserGroup(id, "리얼문화방송 인턴")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_delcbs(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removecbs") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "리얼문화방송 부국장")
        vRP.removeUserGroup(id, "리얼문화방송 사장")
        vRP.removeUserGroup(id, "리얼문화방송 부사장")
        vRP.removeUserGroup(id, "리얼문화방송 차장")
        vRP.removeUserGroup(id, "리얼문화방송 과장")
        vRP.removeUserGroup(id, "리얼문화방송 대리")
        vRP.removeUserGroup(id, "리얼문화방송 사원")
        vRP.removeUserGroup(id, "리얼문화방송 인턴")
        vRP.addUserGroup(id, "실업자")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

-- 리얼문화방송 부국장

local function ch_addcbs2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addcbs2") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "사장, 부사장, 차장, 과장, 대리, 사원, 인턴",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "사장" then
                  vRP.addUserGroup(id, "리얼문화방송 사장")
                end
                if groupprefix == "부사장" then
                  vRP.addUserGroup(id, "리얼문화방송 부사장")
                end
                if groupprefix == "차장" then
                  vRP.addUserGroup(id, "리얼문화방송 차장")
                end
                if groupprefix == "과장" then
                  vRP.addUserGroup(id, "리얼문화방송 과장")
                end
                if groupprefix == "대리" then
                  vRP.addUserGroup(id, "리얼문화방송 대리")
                end
                if groupprefix == "사원" then
                  vRP.addUserGroup(id, "리얼문화방송 사원")
                end
                if groupprefix == "인턴" then
                  vRP.addUserGroup(id, "리얼문화방송 인턴")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_delcbs2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removecbs2") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "리얼문화방송 사장")
        vRP.removeUserGroup(id, "리얼문화방송 부사장")
        vRP.removeUserGroup(id, "리얼문화방송 차장")
        vRP.removeUserGroup(id, "리얼문화방송 과장")
        vRP.removeUserGroup(id, "리얼문화방송 대리")
        vRP.removeUserGroup(id, "리얼문화방송 사원")
        vRP.removeUserGroup(id, "리얼문화방송 인턴")
        vRP.addUserGroup(id, "실업자")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

-- 리얼 문화방송 사장

local function ch_addcbs3(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addcbs3") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "부사장, 차장, 과장, 대리, 사원, 인턴",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "부사장" then
                  vRP.addUserGroup(id, "리얼문화방송 부사장")
                end
                if groupprefix == "차장" then
                  vRP.addUserGroup(id, "리얼문화방송 차장")
                end
                if groupprefix == "과장" then
                  vRP.addUserGroup(id, "리얼문화방송 과장")
                end
                if groupprefix == "대리" then
                  vRP.addUserGroup(id, "리얼문화방송 대리")
                end
                if groupprefix == "사원" then
                  vRP.addUserGroup(id, "리얼문화방송 사원")
                end
                if groupprefix == "인턴" then
                  vRP.addUserGroup(id, "리얼문화방송 인턴")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_delcbs3(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removecbs3") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "리얼문화방송 부사장")
        vRP.removeUserGroup(id, "리얼문화방송 차장")
        vRP.removeUserGroup(id, "리얼문화방송 과장")
        vRP.removeUserGroup(id, "리얼문화방송 대리")
        vRP.removeUserGroup(id, "리얼문화방송 사원")
        vRP.removeUserGroup(id, "리얼문화방송 인턴")
        vRP.addUserGroup(id, "실업자")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

-- 리얼문화방송 끝

-- 리얼 다이소

local function ch_adddaiso(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.adddaiso") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "사장, 전무이사, 부장, 팀장, 대리, 사원",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "사장" then
                  vRP.addUserGroup(id, "리얼다이소 사장")
                end
                if groupprefix == "전무이사" then
                  vRP.addUserGroup(id, "리얼다이소 전무이사")
                end
                if groupprefix == "부장" then
                  vRP.addUserGroup(id, "리얼다이소 부장")
                end
                if groupprefix == "팀장" then
                  vRP.addUserGroup(id, "리얼다이소 팀장")
                end
                if groupprefix == "대리" then
                  vRP.addUserGroup(id, "리얼다이소 대리")
                end
                if groupprefix == "사원" then
                  vRP.addUserGroup(id, "리얼다이소 사원")
                end
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_deldaiso(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removedaiso") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "리얼다이소 사장")
        vRP.removeUserGroup(id, "리얼다이소 전무이사")
        vRP.removeUserGroup(id, "리얼다이소 부장")
        vRP.removeUserGroup(id, "리얼다이소 팀장")
        vRP.removeUserGroup(id, "리얼다이소 대리")
        vRP.removeUserGroup(id, "리얼다이소 사원")
        vRP.addUserGroup(id, "실업자")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

local function ch_adddaiso2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.adddaiso2") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "부장, 팀장, 대리, 사원, 인턴",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "부장" then
                  vRP.addUserGroup(id, "리얼다이소 부장")
                end
                if groupprefix == "팀장" then
                  vRP.addUserGroup(id, "리얼다이소 팀장")
                end
                if groupprefix == "대리" then
                  vRP.addUserGroup(id, "리얼다이소 대리")
                end
                if groupprefix == "사원" then
                  vRP.addUserGroup(id, "리얼다이소 사원")
                end
                if groupprefix == "인턴" then
                  vRP.addUserGroup(id, "리얼다이소 인턴")
                end                
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

local function ch_deldaiso2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removedaiso2") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        --   vRP.prompt(player,"Group to add: ","",function(player,group)
        vRP.removeUserGroup(id, "리얼다이소 부장")
        vRP.removeUserGroup(id, "리얼다이소 팀장")
        vRP.removeUserGroup(id, "리얼다이소 대리")
        vRP.removeUserGroup(id, "리얼다이소 사원")
        vRP.removeUserGroup(id, "리얼다이소 인턴")
        vRP.addUserGroup(id, "실업자")
        vRPclient.notify(player, {"~b~해고 완료"})
        --  end)
      end
    )
  end
end

-- 부장 전용

local function ch_adddaiso3(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.adddaiso3") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        if id ~= nil then
          vRP.prompt(
            player,
            "팀장, 대리, 사원,  인턴",
            "",
            function(player, groupprefix)
              if groupprefix ~= nil then
                if groupprefix == "팀장" then
                  vRP.addUserGroup(id, "리얼다이소 팀장")
                end
                if groupprefix == "대리" then
                  vRP.addUserGroup(id, "리얼다이소 대리")
                end
                if groupprefix == "사원" then
                  vRP.addUserGroup(id, "리얼다이소 사원")
                end
                if groupprefix == "인턴" then
                  vRP.addUserGroup(id, "리얼다이소 인턴")
                end                
              else
                vRPclient.notify(player, {"~r~정확한 직급을 적어주세요."})
              end
            end
          )
        end
      end
    )
  end
end

-- 리얼 다이소 끝

local function ch_addcop(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addcop") then
    ch_addpart(player, "cop.whitelisted")
  end
end

local function ch_removecop(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removecop") then
    ch_removepart(player, "cop.whitelisted")
  end
end

local function ch_addems(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addems") then
    ch_addpart(player, "ems.whitelisted")
  end
end

local function ch_removeems(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removeems") then
    ch_removepart(player, "ems.whitelisted")
  end
end

local function ch_adddok(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.adddok") then
    ch_addpart(player, "dok.whitelisted")
  end
end

local function ch_removedok(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removedok") then
    ch_removepart(player, "dok.whitelisted")
  end
end

local function ch_addmafia(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addmafia") then
    ch_addpart(player, "mafia.whitelisted")
  end
end

local function ch_removemafia(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removemafia") then
    ch_removepart(player, "mafia.whitelisted")
  end
end

local function ch_addshh(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addshh") then
    ch_addpart(player, "shh.whitelisted")
  end
end

local function ch_removeshh(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removeshh") then
    ch_removepart(player, "shh.whitelisted")
  end
end

local function ch_addgm(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addgm") then
    ch_addpart(player, "gm.whitelisted")
  end
end

local function ch_removegm(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removegm") then
    ch_removepart(player, "gm.whitelisted")
  end
end

local function ch_addtow(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addtow") then
    ch_addpart(player, "tow.whitelisted")
  end
end

local function ch_removetow(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removetow") then
    ch_removepart(player, "tow.whitelisted")
  end
end

local function ch_addgov(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addgov") then
    ch_addpart(player, "gov.whitelisted")
  end
end

local function ch_removegov(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removegov") then
    ch_removepart(player, "gov.whitelisted")
  end
end

local function ch_kick(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.kick") then
    vRP.prompt(
      player,
      "강퇴 대상 고유번호: ",
      "",
      function(player, id)
        id = parseInt(id)
        vRP.prompt(
          player,
          "사유: ",
          "",
          function(player, reason)
            local source = vRP.getUserSource(id)
            if source ~= nil then
              vRP.kick(source, reason)
              vRPclient.notify(player, {"강제퇴장 완료 " .. id})
            end
          end
        )
      end
    )
  end
end

local function ch_ban(player, choice)
  local user_id = vRP.getUserId(player)
  local name = GetPlayerName(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.ban") then
    vRP.prompt(
      player,
      "차단 대상 고유번호: ",
      "",
      function(player, id)
        id = parseInt(id)
        vRP.prompt(
          player,
          "사유: ",
          "",
          function(player, reason)
            local source = vRP.getUserSource(id)
            local target_name = GetPlayerName(source)
            if source ~= nil then
              vRP.ban(source, reason)
              vRPclient.notify(player, {"차단 완료 " .. id})
              sendToDiscord_ban(16711680, "영구정지 로그", "차단한 관리자 : " .. name .. "(" .. user_id .. "번)\n\n차단 대상 : " .. target_name .. "(" .. id .. "번)\n\n차단 사유 : " .. reason .. "", os.date("처리일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록"))
            else
              vRP.banByUserId(source, reason)
              vRPclient.notify(player, {"[미접속] 차단 완료 " .. id})
              sendToDiscord_ban2(16711680, "미접속자 영구정지 로그", "차단한 관리자 : " .. name .. "(" .. user_id .. "번)\n\n차단 대상 : " .. target_name .. "(" .. id .. "번)\n\n차단 사유 : " .. reason .. "", os.date("처리일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록"))
            end
          end
        )
      end
    )
  end
end

local function ch_reboot_start(player, choice)
  local user_id = vRP.getUserId(player)
  local name = GetPlayerName(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.ban") then
    vRP.prompt(
      player,
      "리붓 설정시간: ",
      "",
      function(player, time)
        TriggerEvent("reboot:start", time)
      end
    )
  end
end

local function ch_reboot_stop(player, choice)
  local user_id = vRP.getUserId(player)
  local name = GetPlayerName(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.ban") then
    TriggerEvent("reboot:stop")
  end
end

function sendToDiscord_ban(color, name, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["url"] = "https://i.imgur.com/xGCgBw1.png",
      ["footer"] = {
        ["text"] = footer
      }
    }
  }
  PerformHttpRequest(
    "https://discordapp.com/api/webhooks/685804244137541668/4RiawOdNXjNJ1smi1FJ-uq9Jm52K4VTE7URzEYcRgSAtWD4LnD9ljaOPD1w2q3U9MqXZ",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

function sendToDiscord_ban2(color, name, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["url"] = "https://i.imgur.com/xGCgBw1.png",
      ["footer"] = {
        ["text"] = footer
      }
    }
  }
  PerformHttpRequest(
    "https://discordapp.com/api/webhooks/685804244137541668/4RiawOdNXjNJ1smi1FJ-uq9Jm52K4VTE7URzEYcRgSAtWD4LnD9ljaOPD1w2q3U9MqXZ",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

local function ch_unban(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.unban") then
    vRP.prompt(
      player,
      "차단 해제 대상 고유번호: ",
      "",
      function(player, id)
        id = parseInt(id)
        vRP.setBanned(id, false)
        vRPclient.notify(player, {"차단 해제 완료 " .. id})
      end
    )
  end
end

local function ch_coords(player, choice)
  vRPclient.getPosition(
    player,
    {},
    function(x, y, z)
      vRP.prompt(
        player,
        "좌표확인 / 복사 Ctrl-A Ctrl-C",
        x .. "," .. y .. "," .. z,
        function(player, choice)
        end
      )
    end
  )
end

local function ch_tptome(player, choice)
  vRPclient.getPosition(
    player,
    {},
    function(x, y, z)
      vRP.prompt(
        player,
        "고유번호:",
        "",
        function(player, user_id)
          local tplayer = vRP.getUserSource(tonumber(user_id))
          if tplayer ~= nil then
            vRPclient.teleport(tplayer, {x, y, z})
          end
        end
      )
    end
  )
end

local function ch_tpto(player, choice)
  vRP.prompt(
    player,
    "고유번호:",
    "",
    function(player, user_id)
      local tplayer = vRP.getUserSource(tonumber(user_id))
      if tplayer ~= nil then
        vRPclient.notify(player, {"해당 플레이어에게 이동."})
        vRPclient.getPosition(
          tplayer,
          {},
          function(x, y, z)
            vRPclient.teleport(player, {x, y, z})
          end
        )
      end
    end
  )
end

local function ch_tptocoords(player, choice)
  vRP.prompt(
    player,
    "좌표입력(x,y,z):",
    "",
    function(player, fcoords)
      local coords = {}
      for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
        table.insert(coords, tonumber(coord))
      end

      local x, y, z = 0, 0, 0
      if coords[1] ~= nil then
        x = coords[1]
      end
      if coords[2] ~= nil then
        y = coords[2]
      end
      if coords[3] ~= nil then
        z = coords[3]
      end

      vRPclient.teleport(player, {x, y, z})
    end
  )
end

local function ch_givemoney(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "금액:",
      "",
      function(player, amount)
        amount = parseInt(amount)
        vRP.giveMoney(user_id, amount)
      end
    )
  end
end

local function ch_givecredit(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "대상 고유번호: ",
      "",
      function(player, id)
        if id == nil or id == "" then
          return
        end
        id = parseInt(id)
        vRP.prompt(
          player,
          "값: ",
          "",
          function(player, amount)
            amount = parseInt(amount)
            vRP.giveCredit(id, amount)
          end
        )
      end
    )
  end
end

local function ch_setloan(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "대상 고유번호: ",
      "",
      function(player, id)
        if id == nil or id == "" then
          return
        end
        id = parseInt(id)
        vRP.prompt(
          player,
          "값: ",
          "",
          function(player, amount)
            amount = parseInt(amount)
            vRP.setLoan(id, tonumber(amount))
          end
        )
      end
    )
  end
end

local function ch_setcr(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "대상 고유번호: ",
      "",
      function(player, id)
        if id == nil or id == "" then
          return
        end
        id = parseInt(id)
        vRP.prompt(
          player,
          "값: ",
          "",
          function(player, amount)
            --amount = parseInt(amount)
            vRP.setCR(id, tonumber(amount))
          end
        )
      end
    )
  end
end

local function ch_hottime(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "대상 고유번호: ",
      "",
      function(player, id)
        if id == nil or id == "" then
          return
        end
        id = parseInt(id)
        amount = parseInt(5000000)
        vRP.giveBankMoney(id, amount)
        vRPclient.notify(id, {"핫타임 보상 : ~g~5,000,000"})
      end
    )
  end
end

local function ch_givebank(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "대상 고유번호: ",
      "",
      function(player, id)
        if id == nil or id == "" then
          return
        end
        id = parseInt(id)
        vRP.prompt(
          player,
          "값: ",
          "",
          function(player, amount)
            amount = parseInt(amount)
            vRP.giveBankMoney(id, amount)
            vRPclient.notify(id, {"~g~은행에 돈이 들어왔습니다."})
          end
        )
      end
    )
  end
end

local function ch_giveitem(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "아이템ID:",
      "",
      function(player, idname)
        idname = idname or ""
        vRP.prompt(
          player,
          "수량:",
          "",
          function(player, amount)
            amount = parseInt(amount)
            if idname == "skinbox" or idname == "skinbox_random" or idname == "smaskbox" or idname == "smaskbox_random" or idname == "itembox" or idname == "carbox" or idname == "carbox_random" or idname == "wdcard" then
              vRP.prompt(
                player,
                "내용물:",
                "",
                function(player, data)
                  if data == "" then
                    return false
                  else
                    local name, description, weight, dataType = vRP.getItemDefinition(idname)
                    local itemData = {}
                    local u_str = ""
                    local contentItems = splitString(data, "\n")
                    itemData.type = dataType
                    itemData.content = {}
                    if idname == "skinbox" or idname == "smaskbox" or idname == "carbox" then
                      u_str = idname .. "_" .. data
                    end
                    for _, v in pairs(contentItems) do
                      local contentItemData = splitString(v, ":")
                      if contentItemData[2] then
                        table.insert(itemData.content, {contentItemData[1], parseInt(contentItemData[2])})
                      else
                        table.insert(itemData.content, contentItemData[1])
                      end
                    end
                    vRP.getDataitemId(
                      itemData,
                      u_str,
                      function(id)
                        if parseInt(id) > 0 then
                          vRP.giveInventoryItem(user_id, idname .. "|" .. id, amount, itemData, true)
                        end
                      end
                    )
                  end
                end
              )
            else
              vRP.giveInventoryItem(user_id, idname, amount, true)
            end
          end
        )
      end
    )
  end
end

local function ch_calladmin(player, choice)
  local user_id = vRP.getUserId(player)
  local name = GetPlayerName(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      "어떤 문제가 있나요?",
      "",
      function(player, desc)
        --desc = desc or ""
        if desc ~= nil then
          if string.len(desc) >= 15 then
            local answered = false
            local players = {}
            for k, v in pairs(vRP.rusers) do
              local player = vRP.getUserSource(tonumber(k))
              -- check user
              if vRP.hasPermission(k, "admin.tickets") and player ~= nil then
                table.insert(players, player)
              end
            end

            -- send notify and alert to all listening players
            for k, v in pairs(players) do
              vRP.request(
                v,
                "스태프 호출 [고유번호 : ".. user_id .." | 닉네임 : "..name.."] 수락하시겠습니까?: " .. htmlEntities.encode(desc),
                120,
                function(v, ok)
                  if ok then -- take the call
                    if not answered then
                      -- answer the call
                      vRPclient.notify(player, {"뉴비도우미가 호출을 받았습니다."})
                      vRPclient.getPosition(
                        player,
                        {},
                        function(x, y, z)
                          vRPclient.teleport(v, {x, y, z})
                        end
                      )
                      answered = true
                    else
                      vRPclient.notify(v, {"이미 완료된 호출입니다."})
                    end
                  end
                end
              )
            end
            vRPclient.notify(player, {"~g~도우미를 호출했습니다."})
          else
            vRPclient.notify(player, {"~r~호출 사유를 5자 이상 입력하세요!"})
          end
        else
          vRPclient.notify(player, {"~r~호출 사유를 작성해주세요!"})
        end
      end
    )
  end
end

local player_customs = {}

local function ch_display_custom(player, choice)
  vRPclient.getCustomization(
    player,
    {},
    function(custom)
      if player_customs[player] then -- hide
        player_customs[player] = nil
        vRPclient.removeDiv(player, {"customization"})
      else -- show
        local content = ""
        for k, v in pairs(custom) do
          content = content .. k .. " => " .. json.encode(v) .. "<br />"
        end

        player_customs[player] = true
        vRPclient.setDiv(
          player,
          {
            "customization",
            ".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ",
            content
          }
        )
      end
    end
  )
end

-- 죄수 등록 및 해제
local function ch_prison(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removeprison") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        group = "prison"
        vRP.removeUserGroup(id, group)
        vRPclient.notify(player, {"~r~죄수 등록~w~이 해제 되었습니다"})
      end
    )
  end
end

local function ch_prison2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addprison") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        group = "prison"
        vRP.addUserGroup(id, group)
        vRPclient.notify(player, {"~g~죄수 등록~w~이 되었습니다"})
      end
    )
  end
end
-- 죄수 메뉴 종료

-- 수배자등록 및 해제
local function ch_subae(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.removesubae") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        group = "subae"
        vRP.removeUserGroup(id, group)
        vRPclient.notify(player, {"~r~수배해제~w~가 되었습니다"})
      end
    )
  end
end

local function ch_subae2(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id, "player.group.addsubae") then
    vRP.prompt(
      player,
      "고유 번호 : ",
      "",
      function(player, id)
        id = parseInt(id)
        group = "subae"
        vRP.addUserGroup(id, group)
        vRPclient.notify(player, {"~g~수배등록~w~이 되었습니다"})
      end
    )
  end
end
--수배자 메뉴 종료

local function ch_noclip(player, choice)
  vRPclient.toggleNoclip(player, {})
end

-- Hotkey Open Admin Menu 1/2
function vRP.openAdminMenu(source)
  vRP.buildMenu(
    "admin",
    {player = source},
    function(menudata)
      menudata.name = "Admin"
      menudata.css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}
      vRP.openMenu(source, menudata)
    end
  )
end

-- Hotkey Open Admin Menu 2/2
function tvRP.openAdminMenu()
  vRP.openAdminMenu(source)
end

vRP.registerMenuBuilder(
  "main",
  function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
      -- build admin menu
      choices["**관리"] = {
        function(player, choice)
          vRP.buildMenu(
            "admin",
            {player = player},
            function(menu)
              menu.name = "관리"
              menu.css = {top = "75px", header_color = "rgba(200,0,0,0.75)"}
              menu.onclose = function(player)
                vRP.openMainMenu(player)
              end
              if vRP.hasPermission(user_id, "player.group.add") then
                menu["*권한 추가"] = {ch_addgroup}
              end
              if vRP.hasPermission(user_id, "player.group.remove") then
                menu["*권한 삭제"] = {ch_removegroup}
              end
              if vRP.hasPermission(user_id, "player.group.addcop") then
                menu["경찰 임명"] = {ch_addcop}
              end
              if vRP.hasPermission(user_id, "player.group.removecop") then
                menu["경찰 해임"] = {ch_removecop}
              end
              if vRP.hasPermission(user_id, "player.group.addprison") then
                menu["*수감자 등록"] = {ch_prison2}
              end
              if vRP.hasPermission(user_id, "player.group.removeprison") then
                menu["*수감자 해제"] = {ch_prison}
              end              
              if vRP.hasPermission(user_id, "player.group.addsubae") then
                menu["*수배자 등록"] = {ch_subae2}
              end
              if vRP.hasPermission(user_id, "player.group.removesubae") then
                menu["*수배자 해제"] = {ch_subae}
              end             
              if vRP.hasPermission(user_id, "player.group.addems") then
                menu["EMS 임명"] = {ch_addems}
              end
              if vRP.hasPermission(user_id, "player.group.removeems") then
                menu["EMS 해임"] = {ch_removeems}
              end
              if vRP.hasPermission(user_id, "player.group.adddok") then
                menu["독사회 조직원 추가"] = {ch_adddok}
              end
              if vRP.hasPermission(user_id, "player.group.removedok") then
                menu["독사회 조직원 해고"] = {ch_removedok}
              end              
              if vRP.hasPermission(user_id, "player.group.addmafia") then
                menu["백사회 조직원 추가"] = {ch_addmafia}
              end
              if vRP.hasPermission(user_id, "player.group.removemafia") then
                menu["백사회 조직원 해고"] = {ch_removemafia}
              end
              if vRP.hasPermission(user_id, "player.group.addshh") then
                menu["흑사회 조직원 추가"] = {ch_addshh}
              end
              if vRP.hasPermission(user_id, "player.group.removeshh") then
                menu["흑사회 조직원 해고"] = {ch_removeshh}
              end
              if vRP.hasPermission(user_id, "player.group.addgm") then
                menu["퍼스트렉카 직원 추가"] = {ch_addgm}
              end
              if vRP.hasPermission(user_id, "player.group.removegm") then
                menu["퍼스트렉카 직원 해고"] = {ch_removegm}
              end
              if vRP.hasPermission(user_id, "player.group.addemsab") then
                menu["소방청 알바 고용"] = {ch_addemsab}
              end
              if vRP.hasPermission(user_id, "player.group.removeemsab") then
                menu["소방청 알바 해고"] = {ch_delemsab}
              end
              if vRP.hasPermission(user_id, "player.group.addstaffab") then
                menu["임시 스태프 채용"] = {ch_addstaffab}
              end
              if vRP.hasPermission(user_id, "player.group.removestaffab") then
                menu["임시 스태프 해고"] = {ch_delstaffab}
              end
              if vRP.hasPermission(user_id, "player.group.addcbs") then
                menu["리얼문화방송 직원 추가"] = {ch_addcbs}
              end
              if vRP.hasPermission(user_id, "player.group.removecbs") then
                menu["리얼문화방송 직원 해고"] = {ch_delcbs}
              end
              if vRP.hasPermission(user_id, "player.group.addkys") then
                menu["교정본부 공무원 추가"] = {ch_addkys}
              end
              if vRP.hasPermission(user_id, "player.group.removekys") then
                menu["교정본부 공무원 해고"] = {ch_delkys}
              end
              if vRP.hasPermission(user_id, "player.group.addkys2") then
                menu["교정본부 공무원 추가"] = {ch_addkys2}
              end
              if vRP.hasPermission(user_id, "player.group.removekys2") then
                menu["교정본부 공무원 해고"] = {ch_delkys2}
              end
              if vRP.hasPermission(user_id, "player.group.addcbs2") then
                menu["리얼문화방송 직원 추가"] = {ch_addcbs2}
              end
              if vRP.hasPermission(user_id, "player.group.removecbs2") then
                menu["리얼문화방송 직원 해고"] = {ch_delcbs2}
              end
              if vRP.hasPermission(user_id, "player.group.addcbs3") then
                menu["리얼문화방송 직원 추가"] = {ch_addcbs3}
              end
              if vRP.hasPermission(user_id, "player.group.removecbs3") then
                menu["리얼문화방송 직원 해고"] = {ch_delcbs3}
              end
              if vRP.hasPermission(user_id, "player.group.adddaiso") then
                menu["리얼다이소 직원 추가"] = {ch_adddaiso}
              end
              if vRP.hasPermission(user_id, "player.group.removedaiso") then
                menu["리얼다이소 직원 해고"] = {ch_deldaiso}
              end
              if vRP.hasPermission(user_id, "player.group.adddaiso2") then
                menu["리얼다이소 직원 추가"] = {ch_adddaiso2}
              end
              if vRP.hasPermission(user_id, "player.group.removedaiso2") then
                menu["리얼다이소 직원 해고"] = {ch_deldaiso2}
              end
              if vRP.hasPermission(user_id, "player.group.adddaiso3") then
                menu["리얼다이소 직원 추가"] = {ch_adddaiso3}
              end
              if vRP.hasPermission(user_id, "player.group.addgov") then
                menu["국가직 임명"] = {ch_addgov}
              end
              if vRP.hasPermission(user_id, "player.group.removegov") then
                menu["국가직 해임"] = {ch_removegov}
              end
              if vRP.hasPermission(user_id, "player.kick") then
                menu["*[특수]플레이어 게임추방"] = {ch_kick}
              end
              if vRP.hasPermission(user_id, "player.ban") then
                menu["*[특수]플레이어 영구정지"] = {ch_ban}
              end
              if vRP.hasPermission(user_id, "player.unban") then
                menu["*[특수]영구정지 해제"] = {ch_unban}
              end
              if vRP.hasPermission(user_id, "player.ban") then
                menu["*[특수]리붓 프로세스 시작"] = {ch_reboot_start}
              end
              if vRP.hasPermission(user_id, "player.ban") then
                menu["*[특수]리붓 프로세스 종료"] = {ch_reboot_stop}
              end
              if vRP.hasPermission(user_id, "player.noclip") then
                menu["*[관리자]노클립"] = {ch_noclip}
              end
              if vRP.hasPermission(user_id, "player.coords") then
                menu["*[관리자]좌표확인"] = {ch_coords}
              end
              if vRP.hasPermission(user_id, "player.tptome") then
                menu["*[특수]나에게 텔레포트"] = {ch_tptome}
              end
              if vRP.hasPermission(user_id, "player.tpto") then
                menu["*[특수]상대에게 텔포하기"] = {ch_tpto}
              end
              if vRP.hasPermission(user_id, "player.tpto") then
                menu["*[관리자]좌표로 텔포"] = {ch_tptocoords}
              end
              if vRP.hasPermission(user_id, "player.givemoney") then
                menu["돈 생성"] = {ch_givemoney}
              end
              if vRP.hasPermission(user_id, "player.givebank") then
                menu["*[관리자]은행 돈 생성"] = {ch_givebank}
              end
              if vRP.hasPermission(user_id, "player.givecredit") then
              menu["*[관리자]배틀코인 생성"] = {ch_givecredit}
              end
              if vRP.hasPermission(user_id, "player.giveitem") then
                menu["*[관리자]아이템 생성"] = {ch_giveitem}
              end
              if vRP.hasPermission(user_id, "elysium.adminloan") then
              --menu["**대출 설정"] = {ch_setloan}
              end
              if vRP.hasPermission(user_id, "elysium.adminloan") then
              --menu["**신용등급 설정"] = {ch_setcr}
              end
              if vRP.hasPermission(user_id, "player.hottime") then
              --menu["*핫타임 지급"] = {ch_hottime}
              end
              if vRP.hasPermission(user_id, "player.display_custom") then
              --menu["Display customization"] = {ch_display_custom}
              end
              if vRP.hasPermission(user_id, "player.calladmin") then
                menu["**도우미 호출"] = {ch_calladmin}
              end

              vRP.openMenu(player, menu)
            end
          )
        end
      }

      add(choices)
    end
  end
)

RegisterNetEvent("proxy_vrp:action")
AddEventHandler(
  "proxy_vrp:action",
  function(type)
    local player = source
    local user_id = vRP.getUserId(player)
    if not user_id then
      return
    end
    if type == "ch_noclip" then
      if vRP.hasPermission(user_id, "player.noclip") then
        ch_noclip(source, "")
      end
    elseif type == "ch_tpto" then
      if vRP.hasPermission(user_id, "player.tpto") then
        ch_tpto(source, "")
      end
    elseif type == "ch_tptome" then
      if vRP.hasPermission(user_id, "player.tpto") then
        ch_tptome(source, "")
      end
    elseif type == "ch_tptocoords" then
      if vRP.hasPermission(user_id, "player.tpto") then
        ch_tptocoords(source, "")
      end
    elseif type == "ch_coords" then
      if vRP.hasPermission(user_id, "player.tpto") then
        ch_coords(source, "")
      end
    elseif type == "ch_giveitem" then
      if vRP.hasPermission(user_id, "player.giveitem") then
        ch_giveitem(source, "")
      end
    elseif type == "ch_givemoney" then
      if vRP.hasPermission(user_id, "player.givemoney") then
        ch_givemoney(source, "")
      end
    elseif type == "ch_givebank" then
      if vRP.hasPermission(user_id, "player.givebank") then
        ch_givebank(source, "")
      end
    elseif type == "ch_addgroup" then
      if vRP.hasPermission(user_id, "player.group.add") then
        ch_addgroup(source, "")
      end
    elseif type == "ch_removegroup" then
      if vRP.hasPermission(user_id, "player.group.remove") then
        ch_removegroup(source, "")
      end
    elseif type == "ch_kick" then
      if vRP.hasPermission(user_id, "player.kick") then
        ch_kick(source, "")
      end
    elseif type == "ch_ban" then
      if vRP.hasPermission(user_id, "player.ban") then
        ch_ban(source, "")
      end
    elseif type == "ch_unban" then
      if vRP.hasPermission(user_id, "player.unban") then
        ch_unban(source, "")
      end
    elseif type == "ch_reboot_start" then
      if vRP.hasPermission(user_id, "player.ban") then
        ch_reboot_start(source, "")
      end
    elseif type == "ch_reboot_stop" then
      if vRP.hasPermission(user_id, "player.ban") then
        ch_reboot_stop(source, "")
      end
    elseif type == "ch_calladmin" then
      if vRP.hasPermission(user_id, "player.calladmin") then
        ch_calladmin(source, "")
      end
    elseif type == "ch_addsubae" then
      if vRP.hasPermission(user_id, "player.group.addsubae") then
        ch_subae2(source, "")
      end
    elseif type == "ch_removesubae" then
      if vRP.hasPermission(user_id, "player.group.removesubae") then
        ch_subae(source, "")
      end
    elseif type == "ch_addcop" then
      if vRP.hasPermission(user_id, "player.group.addcop") then
        ch_addcop(source, "")
      end
    elseif type == "ch_removecop" then
      if vRP.hasPermission(user_id, "player.group.removecop") then
        ch_removecop(source, "")
      end
    elseif type == "ch_addems" then
      if vRP.hasPermission(user_id, "player.group.addems") then
        ch_addems(source, "")
      end
    elseif type == "ch_removeems" then
      if vRP.hasPermission(user_id, "player.group.removeems") then
        ch_removeems(source, "")
      end
    elseif type == "ch_addemsab" then
      if vRP.hasPermission(user_id, "player.group.addemsab") then
        ch_addemsab(source, "")
      end
    elseif type == "ch_delemsab" then
      if vRP.hasPermission(user_id, "player.group.removeemsab") then
        ch_delemsab(source, "")
      end
    elseif type == "ch_adddok" then
      if vRP.hasPermission(user_id, "player.group.adddok") then
        ch_adddok(source, "")
      end
    elseif type == "ch_removedok" then
      if vRP.hasPermission(user_id, "player.group.removedok") then
        ch_removedok(source, "")
      end      
    elseif type == "ch_addmafia" then
      if vRP.hasPermission(user_id, "player.group.addmafia") then
        ch_addmafia(source, "")
      end
    elseif type == "ch_removemafia" then
      if vRP.hasPermission(user_id, "player.group.removemafia") then
        ch_removemafia(source, "")
      end
    elseif type == "ch_addshh" then
      if vRP.hasPermission(user_id, "player.group.addshh") then
        ch_addshh(source, "")
      end
    elseif type == "ch_removeshh" then
      if vRP.hasPermission(user_id, "player.group.removeshh") then
        ch_removeshh(source, "")
      end
    elseif type == "ch_addgm" then
      if vRP.hasPermission(user_id, "player.group.addgm") then
        ch_addgm(source, "")
      end
    elseif type == "ch_removegm" then
      if vRP.hasPermission(user_id, "player.group.removegm") then
        ch_removegm(source, "")
      end
    elseif type == "ch_addcbs" then
      if vRP.hasPermission(user_id, "player.group.addcbs") then
        ch_addcbs(source, "")
      end
    elseif type == "ch_removecbs" then
      if vRP.hasPermission(user_id, "player.group.removecbs") then
        ch_delcbs(source, "")
      end
    elseif type == "ch_addkys" then
      if vRP.hasPermission(user_id, "player.group.addkys") then
        ch_addkys(source, "")
      elseif vRP.hasPermission(user_id, "player.group.addkys2") then
        ch_addkys2(source, "")
      end
    elseif type == "ch_removekys" then
      if vRP.hasPermission(user_id, "player.group.removekys") then
        ch_delkys(source, "")
      elseif vRP.hasPermission(user_id, "player.group.removekys2") then
        ch_delkys2(source, "")
      end
    elseif type == "ch_adddaiso" then
      if vRP.hasPermission(user_id, "player.group.adddaiso") then
        ch_adddaiso(source, "")
      elseif vRP.hasPermission(user_id, "player.group.adddaiso2") then
        ch_adddaiso2(source, "")
      elseif vRP.hasPermission(user_id, "player.group.adddaiso3") then
        ch_adddaiso3(source, "")
      end
    elseif type == "ch_removedaiso" then
      if vRP.hasPermission(user_id, "player.group.removedaiso") then
        ch_deldaiso(source, "")
      elseif vRP.hasPermission(user_id, "player.group.removedaiso2") then
        ch_deldaiso2(source, "")
      end

    elseif type == "ch_addstaffab" then
      if vRP.hasPermission(user_id, "player.group.addstaffab") then
        ch_addstaffab(source, "")
      end
    elseif type == "ch_delstaffab" then
      if vRP.hasPermission(user_id, "player.group.removestaffab") then
        ch_delstaffab(source, "")
      end
    end
  end
)

-- admin god mode
-- function task_god()
-- SetTimeout(10000, task_god)

-- for k,v in pairs(vRP.getUsersByPermission("admin.god")) do
-- vRP.setHunger(v, 0)
-- vRP.setThirst(v, 0)

-- local player = vRP.getUserSource(v)
-- if player ~= nil then
-- vRPclient.setHealth(player, {200})
-- end
-- end
-- end

-- task_god()
