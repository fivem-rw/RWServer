local lang = vRP.lang

-- Money module, wallet/bank API
-- The money is managed with direct SQL requests to prevent most potential value corruptions
-- the wallet empty itself when respawning (after death)

-- 세금

MySQL.createCommand("vRP/get_tax", "SELECT statecoffers FROM tax")

MySQL.createCommand("vRP/add_tax", "UPDATE tax SET statecoffers = statecoffers + @statecoffers")
MySQL.createCommand("vRP/del_tax", "UPDATE tax SET statecoffers = statecoffers - @statecoffers")

MySQL.createCommand("vRP/add_hi", "UPDATE tax SET hi = hi + @hi")
MySQL.createCommand("vRP/delete_hi", "UPDATE tax SET hi = hi - @hi")

MySQL.createCommand("vRP/add_army", "UPDATE tax SET army = army + @army")
MySQL.createCommand("vRP/del_army", "UPDATE tax SET army = army - @army")

-- 법인

MySQL.createCommand("vRP/add_companycapital", "UPDATE elysium_company SET capital = capital + @capital WHERE user_id = @user_id")
MySQL.createCommand("vRP/del_companycapital", "UPDATE elysium_company SET capital = capital - @capital WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_company", "SELECT code,name,capital,stockprice,stocks,salary,salary1,salary2,salary3,salary4,salary5,salary6,salary7,salary8,ceosalary FROM elysium_company WHERE user_id = @user_id")

MySQL.createCommand("vRP/money_init_user", "INSERT IGNORE INTO vrp_user_moneys(user_id,wallet,bank,credit,loanlimit,loan,creditrating,exp,licrevoked) VALUES(@user_id,@wallet,@bank,@credit,@loanlimit,@loan,@creditrating,@exp,@licrevoked)")
MySQL.createCommand("vRP/get_money", "SELECT wallet,bank,credit,loanlimit,loan,creditrating,exp,licrevoked FROM vrp_user_moneys WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_money", "UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank, credit = @credit, loanlimit = @loanlimit, loan = @loan, creditrating = @creditrating, exp = @exp, licrevoked = @licrevoked WHERE user_id = @user_id")

-- load config
local cfg = module("cfg/money")
if GetConvar("server_env", "pro") == "dev" then
  cfg.open_wallet = cfg.dev.open_wallet
  cfg.open_bank = cfg.dev.open_bank
  cfg.open_credit = cfg.dev.open_credit
  cfg.open_loanlimit = cfg.dev.open_loanlimit
  cfg.open_loan = cfg.dev.open_loan
  cfg.open_creditrating = cfg.dev.open_creditrating
  cfg.open_exp = cfg.dev.open_exp
  cfg.open_licrevoekd = cfg.dev.open_licrevoked
end

-- API

function vRP.getTax(cbr)
  local task = Task(cbr)
  MySQL.query(
    "vRP/get_tax",
    {},
    function(rows, affected)
      local tax = rows[1]
      task({tax})
    end
  )
end

-- 법인

function vRP.getUserCompany(user_id, cbr)
  if true then
    task()
    return
  end
  local task = Task(cbr)

  if user_id ~= nil then
    MySQL.query(
      "vRP/get_company",
      {user_id = user_id},
      function(rows, affected)
        local company = rows[1]
        task({company})
      end
    )
  else
    task()
  end
end

-- 면허 정지 시스템

function vRP.getLicenseStatus(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return parseInt(tmp.licrevoked) or 0
  else
    return 0
  end
end

function vRP.setLicenseStatus(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.licrevoked = value
  end
end

-- 경험치 시스템

function vRP.getEXP(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return parseInt(tmp.exp) or 0
  else
    return 0
  end
end

function vRP.setEXP(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.exp = value
  end
end

-- 대출 시스템

function vRP.getLoan(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return parseInt(tmp.loan) or 0
  else
    return 0
  end
end

function vRP.setLoan(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.loan = value
  end
end

function vRP.getLoanLimit(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return parseInt(tmp.loanlimit) or 0
  else
    return 0
  end
end

function vRP.setLoanLimit(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.loanlimit = value
  end
end

function vRP.getCR(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return parseInt(tmp.creditrating) or 0
  else
    return 0
  end
end

function vRP.setCR(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.creditrating = value
  end
end

-- get money
-- cbreturn nil if error
function vRP.getMoney(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  local value = 0
  if tmp then
    value = parseInt(tmp.wallet) or 0
  else
    value = 0
  end
  vRP.syncCashItemMoney(user_id, value)
  return value
end

-- set money
function vRP.setMoney(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.wallet = value
  end
  vRP.syncCashItemMoney(user_id, value)
  vRP.updateDisplayMoney(user_id, value)
end

function vRP.syncCashItemMoney(user_id, value)
  local cashAmount = parseInt(vRP.getInventoryItemAmount(user_id, "cash"))
  local diff = parseInt(value) - cashAmount
  if diff > 0 then
    vRP.giveInventoryItem(user_id, "cash", math.abs(diff), false, true)
  elseif diff < 0 then
    vRP.tryGetInventoryItem(user_id, "cash", math.abs(diff), false, true)
  end
end

function vRP.updateDisplayMoney(user_id, value)
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source, {"money", lang.money.display({format_num(value) .. " 원"})})
  end
end

-- 크레딧 아이템화
function vRP.getCredit(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  local value = 0
  if tmp then
    value = parseInt(tmp.credit) or 0
  else
    value = 0
  end
  vRP.syncCreditItemCredit(user_id, value)
  return value
end

function vRP.setCredit(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.credit = value
  end
  vRP.syncCreditItemCredit(user_id, value)
end

function vRP.syncCreditItemCredit(user_id, value)
  local creditAmount = parseInt(vRP.getInventoryItemAmount(user_id, "credit"))
  local diff = parseInt(value) - creditAmount
  if diff > 0 then
    vRP.giveInventoryItem(user_id, "credit", math.abs(diff), false, true)
  elseif diff < 0 then
    vRP.tryGetInventoryItem(user_id, "credit", math.abs(diff), false, true)
  end
end

-- try a payment (돈)
-- return true or false (debited if true)
function vRP.tryPayment(user_id, amount)
  amount = parseInt(amount)
  local money = vRP.getMoney(user_id)
  if money >= amount then
    vRP.setMoney(user_id, money - amount)
    return true
  else
    return false
  end
end

-- 트라이 페이먼트 (크레딧)
function vRP.tryPaymentCredit(user_id, amount)
  amount = parseInt(amount)
  local credit = vRP.getCredit(user_id)
  if credit >= amount then
    vRP.setCredit(user_id, credit - amount)
    return true
  else
    return false
  end
end

-- give money
function vRP.giveMoney(user_id, amount)
  amount = parseInt(amount)
  local money = vRP.getMoney(user_id)
  vRP.setMoney(user_id, money + amount)
end

-- 크레딧 지급
function vRP.giveCredit(user_id, amount)
  amount = parseInt(amount)
  local credita = vRP.getCredit(user_id)
  vRP.setCredit(user_id, credita + amount)
end

-- get bank money
function vRP.getBankMoney(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    return parseInt(tmp.bank) or 0
  else
    return 0
  end
end

-- set bank money
function vRP.setBankMoney(user_id, value)
  local tmp = vRP.getUserTmpTable(user_id)
  if tmp then
    tmp.bank = value
  end
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source, {"bmoney", lang.money.bdisplay({format_num(value) .. " 원"})})
  end
end

-- give bank money
function vRP.giveBankMoney(user_id, amount)
  amount = parseInt(amount)
  if amount > 0 then
    local money = vRP.getBankMoney(user_id)
    vRP.setBankMoney(user_id, money + amount)
  end
end

-- 출금
-- return true or false (withdrawn if true)
function vRP.tryWithdraw(user_id, amount)
  amount = parseInt(amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    vRP.setBankMoney(user_id, money - amount)
    vRP.giveMoney(user_id, amount)
    return true
  else
    return false
  end
end

--법인 입금
function vRP.tryDepositToCompany(user_id, company_id, amount)
  if true then
    return
  end
  amount = parseInt(amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    vRP.setBankMoney(user_id, money - amount)
    MySQL.execute("vRP/add_companycapital", {capital = amount, user_id = company_id})
    return true
  else
    return false
  end
end

--법인 출금
function vRP.tryWithdrawToCompany(user_id, company_id, amount)
  if true then
    return
  end
  amount = parseInt(amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 then
    vRP.setBankMoney(user_id, money + amount)
    MySQL.execute("vRP/del_companycapital", {capital = amount, user_id = company_id})
    return true
  else
    return false
  end
end

-- 국고 출금

function vRP.tryWithdrawToTax(user_id, amount)
  amount = parseInt(amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 then
    vRP.setBankMoney(user_id, money + amount)
    MySQL.execute("vRP/del_tax", {statecoffers = amount})
    return true
  else
    return false
  end
end

-- 입금
-- return true or false (deposited if true)
function vRP.tryDeposit(user_id, amount)
  amount = parseInt(amount)
  if amount > 0 and vRP.tryPayment(user_id, amount) then
    vRP.giveBankMoney(user_id, amount)
    return true
  else
    return false
  end
end

function vRP.addTax(amount)
  amount = parseInt(amount)
  if amount > 0 then
    MySQL.execute("vRP/add_tax", {statecoffers = amount})
    return true
  else
    return false
  end
end

-- 크레딧 환전
function vRP.tryDepositCredit(user_id, amount)
  amount = parseInt(amount)
  if amount > 0 and vRP.tryPaymentCredit(user_id, amount) then
    vRP.giveBankMoney(user_id, amount * 1000)
    return true
  else
    return false
  end
end

-- 크레딧 역환전
function vRP.tryMoneyToCredit(user_id, amount)
  amount = parseInt(amount)
  if amount > 0 and vRP.tryFullPayment(user_id, amount * 1200) then
    vRP.giveCredit(user_id, amount)
    return true
  else
    return false
  end
end

-- try full payment (wallet + bank to complete payment)
-- return true or false (debited if true)
function vRP.tryFullPayment(user_id, amount)
  amount = parseInt(amount)
  local money = vRP.getMoney(user_id)
  if money >= amount then -- enough, simple payment
    return vRP.tryPayment(user_id, amount)
  else -- not enough, withdraw -> payment
    if vRP.tryWithdraw(user_id, amount - money) then -- withdraw to complete amount
      return vRP.tryPayment(user_id, amount)
    end
  end

  return false
end

-- events, init user account if doesn't exist at connection
AddEventHandler(
  "vRP:playerJoin",
  function(user_id, source, name, last_login)
    MySQL.execute(
      "vRP/money_init_user",
      {
        user_id = user_id,
        wallet = cfg.open_wallet,
        bank = cfg.open_bank,
        credit = cfg.open_credit,
        loanlimit = cfg.open_loanlimit,
        loan = cfg.open_loan,
        creditrating = cfg.open_creditrating,
        exp = cfg.open_exp,
        licrevoked = cfg.open_licrevoked
      },
      function(affected)
        -- load money (wallet,bank)
        local tmp = vRP.getUserTmpTable(user_id)
        if tmp then
          MySQL.query(
            "vRP/get_money",
            {user_id = user_id},
            function(rows, affected)
              if #rows > 0 then
                tmp.bank = rows[1].bank
                tmp.wallet = rows[1].wallet
                tmp.credit = rows[1].credit
                tmp.loanlimit = rows[1].loanlimit
                tmp.loan = rows[1].loan
                tmp.creditrating = rows[1].creditrating
                tmp.exp = rows[1].exp
                tmp.licrevoked = rows[1].licrevoked
              end
            end
          )
        end
      end
    )
  end
)

-- save money on leave
AddEventHandler(
  "vRP:playerLeave",
  function(user_id, source)
    -- (wallet,bank)
    local tmp = vRP.getUserTmpTable(user_id)
    if tmp and tmp.wallet ~= nil and tmp.bank ~= nil and tmp.credit ~= nil and tmp.loanlimit ~= nil and tmp.loan ~= nil and tmp.creditrating ~= nil and tmp.exp ~= nil then
      MySQL.execute(
        "vRP/set_money",
        {
          user_id = user_id,
          wallet = tmp.wallet,
          bank = tmp.bank,
          credit = tmp.credit,
          loanlimit = tmp.loanlimit,
          loan = tmp.loan,
          creditrating = tmp.creditrating,
          exp = tmp.exp,
          licrevoked = tmp.licrevoked
        }
      )
    end
  end
)

-- save money (at same time that save datatables)
AddEventHandler(
  "vRP:save",
  function()
    for k, v in pairs(vRP.user_tmp_tables) do
      if v.wallet ~= nil and v.bank ~= nil and v.credit ~= nil and v.loanlimit ~= nil and v.loan ~= nil and v.creditrating ~= nil and v.exp ~= nil then
        MySQL.execute(
          "vRP/set_money",
          {
            user_id = k,
            wallet = v.wallet,
            bank = v.bank,
            credit = v.credit,
            loanlimit = v.loanlimit,
            loan = v.loan,
            creditrating = v.creditrating,
            exp = v.exp
          }
        )
        Wait(0)
      end
    end
  end
)

local function ch_give(player, choice)
  -- get nearest player
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(
      player,
      {10},
      function(nplayer)
        if nplayer ~= nil then
          local nuser_id = vRP.getUserId(nplayer)
          local my_name = GetPlayerName(source)
          local nuser_name = GetPlayerName(nplayer)
          if nuser_id ~= nil then
            -- prompt number
            vRP.prompt(
              player,
              lang.money.give.prompt(),
              "",
              function(player, amount)
                local amount = parseInt(amount)
                if amount > 0 and vRP.tryPayment(user_id, amount) then
                  vRP.giveMoney(nuser_id, amount)
                  vRPclient.notify(player, {lang.money.given({format_num(amount)})})
                  vRPclient.notify(nplayer, {lang.money.received({format_num(amount)})})
                  sendToDiscord_money(16711680, "현금 거래 내역서", "보내는 사람 : " .. my_name .. "(" .. user_id .. "번)\n\n받는 사람 : " .. nuser_name .. "(" .. nuser_id .. "번)\n\n송금 금액 : " .. comma_value(amount) .. "원", os.date("처리일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
                else
                  vRPclient.notify(player, {lang.money.not_enough()})
                end
              end
            )
          else
            vRPclient.notify(player, {lang.common.no_player_near()})
          end
        else
          vRPclient.notify(player, {lang.common.no_player_near()})
        end
      end
    )
  end
end

function comma_value(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
    if (k == 0) then
      break
    end
  end
  return formatted
end

function sendToDiscord_money(color, name, message, footer)
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
    "https://discordapp.com/api/webhooks/682652831122980905/dJ1TvRl_6srkHWiOgJvQ_MQoXHWIcryS2-6Uj08EwDHEJEMPRrAcBREQYP_ZfZ3s8gIp",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

local function ch_givec(player, choice)
  -- 크레딧 송금
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(
      player,
      {10},
      function(nplayer)
        if nplayer ~= nil then
          local nuser_id = vRP.getUserId(nplayer)
          if nuser_id ~= nil then
            -- prompt number
            vRP.prompt(
              player,
              lang.credit.give.prompt(),
              "",
              function(player, amount)
                local amount = parseInt(amount)
                if amount > 0 and vRP.tryPaymentCredit(user_id, amount) then
                  vRP.giveCredit(nuser_id, amount)
                  vRPclient.notify(player, {lang.credit.given({amount})})
                  vRPclient.notify(nplayer, {lang.credit.received({amount})})
                else
                  vRPclient.notify(player, {lang.credit.not_enough()})
                end
              end
            )
          else
            vRPclient.notify(player, {lang.common.no_player_near()})
          end
        else
          vRPclient.notify(player, {lang.common.no_player_near()})
        end
      end
    )
  end
end

vRP.registerMenuBuilder(
  "main",
  function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
      choices["*현금 주기"] = {
        function(player, choice)
          vRP.buildMenu(
            "money",
            {player = player},
            function(menu)
              menu.name = "현금 주기"
              menu.css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}
              menu.onclose = function(player)
                vRP.openMainMenu({player})
              end

              menu[lang.money.give.title()] = {ch_give, lang.money.give.description()}

              vRP.openMenu(player, menu)
            end
          )
        end
      }

      add(choices)
    end
  end
)
