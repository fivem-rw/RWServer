-- a basic ATM implementation

local lang = vRP.lang
local cfg = module("cfg/atms")
local atms = cfg.atms

local function play_atm_enter(player)
  vRPclient.playAnim(player, {false, {{"amb@prop_human_atm@male@enter", "enter"}, {"amb@prop_human_atm@male@idle_a", "idle_a"}}, false})
end

local function play_atm_exit(player)
  vRPclient.playAnim(player, {false, {{"amb@prop_human_atm@male@exit", "exit"}}, false})
end

local function atm_choice_deposit(player, choice)
  play_atm_enter(player) --anim

  vRP.prompt(
    source,
    lang.atm.deposit.prompt(),
    "",
    function(player, v)
      play_atm_exit(player)

      v = parseInt(v)

      if v > 0 then
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
          if vRP.tryDeposit(user_id, v) then
            vRPclient.notify(source, {lang.atm.deposit.deposited({format_num(v)})})
          else
            vRPclient.notify(source, {lang.money.not_enough()})
          end
        end
      else
        vRPclient.notify(source, {lang.common.invalid_value()})
      end
    end
  )
end

local function atm_choice_depositcredit(player, choice)
  play_atm_enter(player) --anim

  vRP.prompt(
    source,
    lang.atm.depositcredit.prompt(),
    "",
    function(player, v)
      play_atm_exit(player)

      v = parseInt(v)

      if v > 0 then
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
          if vRP.tryDepositCredit(user_id, v) then
            vRPclient.notify(source, {lang.atm.depositcredit.deposited({format_num(v)})})
          else
            vRPclient.notify(source, {lang.money.not_enough()})
          end
        end
      else
        vRPclient.notify(source, {lang.common.invalid_value()})
      end
    end
  )
end

local function atm_choice_moneytocredit(player, choice)
  play_atm_enter(player) --anim

  vRP.prompt(
    source,
    lang.atm.moneytocredit.prompt(),
    "",
    function(player, v)
      play_atm_exit(player)

      v = parseInt(v)

      if v > 0 then
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
          if vRP.tryMoneyToCredit(user_id, v) then
            vRPclient.notify(source, {lang.atm.moneytocredit.deposited({format_num(v)})})
          else
            vRPclient.notify(source, {lang.money.not_enough()})
          end
        end
      else
        vRPclient.notify(source, {lang.common.invalid_value()})
      end
    end
  )
end

local function atm_choice_withdraw(player, choice)
  play_atm_enter(player)

  vRP.prompt(
    source,
    lang.atm.withdraw.prompt(),
    "",
    function(player, v)
      play_atm_exit(player) --anim

      v = parseInt(v)

      if v > 0 then
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
          if vRP.tryWithdraw(user_id, v) then
            vRPclient.notify(source, {lang.atm.withdraw.withdrawn({format_num(v)})})
          else
            vRPclient.notify(source, {lang.atm.withdraw.not_enough()})
          end
        end
      else
        vRPclient.notify(source, {lang.common.invalid_value()})
      end
    end
  )
end

local function atm_choice_repayloan(player, choice)
  play_atm_enter(player)
  local user_id = vRP.getUserId(source)
  local loan = tonumber(vRP.getLoan(user_id))
  local loanlimit = tonumber(vRP.getLoanLimit(user_id))
  if loan <= 0 then
    vRPclient.notify(player, {"대출하신 금액이 없습니다."})
  else
    vRP.prompt(
      source,
      "얼마를 상환하시겠습니까? 현재 대출금:" .. loan,
      "",
      function(player, v)
        play_atm_exit(player) --anim
        v = parseInt(v)

        if v > loan then
          vRPclient.notify(source, {"대출금 보다 많은 금액입니다!"})
        else
          if v == loan then
            if user_id ~= nil then
              if vRP.tryFullPayment(user_id, v) then
                local CR = vRP.getCR(user_id)
                vRP.setCR(user_id, CR - 0.30)
                vRPclient.notify(source, {lang.atm.withdraw.withdrawn({v})})
                vRPclient.notify(source, {"대출금이 전액 상환되었습니다."})
                vRP.setLoan(user_id, loan - v)
                vRP.setLoanLimit(user_id, loanlimit + v)
              else
                vRPclient.notify(source, {lang.atm.withdraw.not_enough()})
              end
            end
          else
            if v > 0 then
              if user_id ~= nil then
                if vRP.tryFullPayment(user_id, v) then
                  vRPclient.notify(source, {lang.atm.withdraw.withdrawn({v})})
                  vRPclient.notify(source, {"대출금이 일부 상환되었습니다."})
                  vRP.setLoan(user_id, loan - v)
                  vRP.setLoanLimit(user_id, loanlimit + v)
                else
                  vRPclient.notify(source, {lang.atm.withdraw.not_enough()})
                end
              end
            else
              vRPclient.notify(source, {lang.common.invalid_value()})
            end
          end
        end
      end
    )
  end
end

local atm_menu = {
  name = lang.atm.title(),
  css = {top = "75px", header_color = "rgba(0,255,125,0.75)"}
}

atm_menu[lang.atm.deposit.title()] = {atm_choice_deposit, lang.atm.deposit.description()}
atm_menu[lang.atm.withdraw.title()] = {atm_choice_withdraw, lang.atm.withdraw.description()}
--atm_menu[lang.atm.depositcredit.title()] = {atm_choice_depositcredit, lang.atm.depositcredit.description()}
--atm_menu[lang.atm.moneytocredit.title()] = {atm_choice_moneytocredit,lang.atm.moneytocredit.description()}
--atm_menu["대출금 상환"] = {atm_choice_repayloan, "대출금을 상환합니다.<br />(현금 가능)"}

local function atm_enter()
  local user_id = vRP.getUserId(source)
  local loan = vRP.getLoan(user_id)
  if user_id ~= nil then
    atm_menu[lang.atm.info.title()] = {
      function()
      end,
      lang.atm.info.bank({format_num(vRP.getBankMoney(user_id))})
    }
    --[[
    atm_menu[lang.atm.checkloanlimit.title()] = {
      function()
      end,
      lang.atm.checkloanlimit.bank({math.ceil(tonumber(vRP.getLoanLimit(user_id)))})
    }
    if loan == 0 then
      atm_menu[lang.atm.noloaninfo.title()] = {
        function()
        end,
        lang.atm.noloaninfo.bank({vRP.getLoan(user_id)})
      }
    else
      atm_menu[lang.atm.loaninfo.title()] = {
        function()
        end,
        lang.atm.loaninfo.bank({vRP.getLoan(user_id)})
      }
    end
    ]]
    vRP.openMenu(source, atm_menu)
  end
end

local function atm_leave()
  vRP.closeMenu(source, true)
end

local function build_client_atms(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    Citizen.CreateThread(
      function()
        for k, v in pairs(atms) do
          local x, y, z, text = table.unpack(v)

          vRPclient.addBlip(source, {x, y, z, 108, 4, lang.atm.title()})
          vRPclient.addMarker(source, {x, y, z - 1, 1.2, 1.2, 0.2, 0, 255, 125, 125, 100, text})

          vRP.setArea(source, "vRP:atm" .. k, x, y, z, 0.6, 1.5, atm_enter, atm_leave)

          Citizen.Wait(0)
        end
      end
    )
  end
end

AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    if first_spawn then
      build_client_atms(source)
    end
  end
)
