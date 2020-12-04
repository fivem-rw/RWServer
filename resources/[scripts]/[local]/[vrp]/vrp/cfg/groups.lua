local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(player) (called when the player spawn with the group)
--- onjoin (optional): function(player) (called when the player join the group)
--- onleave (optional): function(player) (called when the player leave the group)
--- (you have direct access to vRP and vRPclient, the tunnel to client, in the config callbacks)

cfg.groups = {
  ["superadmin"] = {
    _config = {
      level = 1000,
      onspawn = function(player)
        vRPclient.notify(player, {"총관리자로 로그인하였습니다."})
      end
    },
    "chatrules.superadmin",
    "admin.cloakroom",
    "admin.loadshop",
    "admin.announce",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.spawnveh",
    "admin.deleteveh",
    "admin.vehicle",
    "admin.tp",
    "admin.revive",
    "admin.static",
    "admin.store_weapons",
    "admin.market",
    "admin.protect",
    "player.freeze",
    "player.group.add",
    "player.group.remove",
    "player.blips",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "player.givemoney",
    "player.givecredit",
    "player.givebank",
    "player.giveitem",
    "player.hottime",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "player.showname"
  },
  ["subadmin"] = {
    _config = {
      level = 900,
      onspawn = function(player)
        vRPclient.notify(player, {"부총관리자로 로그인하였습니다."})
      end
    },
    "chatrules.subadmin",
    "admin.cloakroom",
    "admin.loadshop",
    "admin.announce",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.deleteveh",
    "admin.vehicle",
    "admin.tp",
    "admin.revive",
    "admin.static",
    "admin.store_weapons",
    "admin.market",
    "admin.protect",
    "player.freeze",
    "player.group.add",
    "player.group.remove",
    "player.blips",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "player.showname"
  },
  ["rpadmin"] = {
    _config = {
      level = 800,
      onspawn = function(player)
        vRPclient.notify(player, {"관리자로 로그인하였습니다."})
      end
    },
    "kys.cloakroom",
    "real.adminnotice",
    "real.policenotice",
    "real.emsnotice",
    "real.staffnotice",
    "real.rebootnotice",
    "player.group.addemsab",
    "player.group.removeemsab",
    "player.givemoney",
    "player.givecredit",
    "player.givebank",
    "lic.police",
    "chatrules.rpadmin",
    "admin.cloakroom",
    "admin.loadshop",
    "admin.tickets",
    "admin.announce",
    "player.giveitem",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.spawnveh",
    "admin.deleteveh",
    "admin.vehicle",
    "admin.tp",
    "admin.revive",
    "admin.static",
    "admin.store_weapons",
    "admin.market",
    "admin.protect",
    "player.freeze",
    "player.group.add",
    "player.group.remove",
    "player.blips",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "player.check",
    "player.showname"
  },
  ["ingame.admin"] = {
    _config = {
      level = 800,
      onspawn = function(player)
        vRPclient.notify(player, {"인게임 관리자로 로그인하였습니다."})
      end
    },
    "kys.cloakroom",
    "real.adminnotice",
    "real.policenotice",
    "real.emsnotice",
    "real.staffnotice",
    "real.rebootnotice",
    "player.group.addemsab",
    "player.group.removeemsab",
    "lic.police",
    "admin.cloakroom",
    "admin.tickets",
    "admin.announce",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.deleteveh",
    "admin.vehicle",
    "admin.tp",
    "admin.revive",
    "admin.static",
    "admin.store_weapons",
    "player.freeze",
    "player.group.add",
    "player.group.remove",
    "player.blips",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "player.check",
    "player.showname"
    --"admin.spawnveh",
    --"admin.deleteveh"
  },  
  ["inspector"] = {
    _config = {
      level = 800,
      onspawn = function(player)
        vRPclient.notify(player, {"감사로 로그인하였습니다."})
      end
    },
    "chatrules.inspector",
    "admin.cloakroom",
    "admin.loadshop",
    "admin.tickets",
    "admin.announce",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.deleteveh",
    "admin.vehicle",
    "admin.tp",
    "admin.static",
    "admin.store_weapons",
    "player.freeze",
    "player.blips",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "player.showname"
  },
  ["dev.user"] = {
    _config = {
      level = 800,
      onspawn = function(player)
        vRPclient.notify(player, {"개발자로 로그인하였습니다."})
      end
    },
    "admin.spawnveh",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle"
  },  
  ["helper"] = {
    _config = {
      level = 700,
      onspawn = function(player)
        vRPclient.notify(player, {"스태프로 로그인하였습니다."})
      end
    },
    "chatrules.helper"
  },
  ["user"] = {
    "player.phone",
    "player.calladmin",
    "player.fix_haircut",
    "police.askid",
    "police.store_weapons",
    "police.store_armor",
    "player.store_money",
    "player.skip_coma",
    "player.loot",
    "player.player_menu",
    "player.userlist",
    "police.seizable", -- can be seized
    "farm.legal123", -- 광부 스크립트 적용
    "miner.market",
    "farm.legal3333", -- 나무꾼 스크립트 적용
    "huntingjobs", -- 사냥꾼 스크립트 적용
    "farm.legal",
    "milk.market",
    "user.paycheck"
  },
  ["revive"] = {
    "emergency.revive"
  },
  ["subae"] = {
    "subae.whitelisted"
  },
  ["prison"] = {
    "prison.whitelist"
  },  
  ["skateboard"] = {
    "player.skateboard"
  },
  ["redmember"] = {
    "redmember",
    "redmember.money",
    "redmembers"
  },
  ["acemember"] = {
    "acemember",
    "acemember.money",
    "acemembers"
  },
  ["royalmember"] = {
    "royalmember",
    "royalmember.money",
    "royalmembers"
  },
  ["noblemember"] = {
    "noblemember",
    "noblemember.money",
    "noblemembers",
    "huwon1.weapon",
    "parkour.player"
  },
  ["noblemembers"] = {
    "noblemember",
    "huwon1.weapon",
    "parkour.player"
  },
  ["firstmember"] = {
    "firstmember",
    "firstmember.money",
    "firstmembers",
    "mask.shop",
    "huwon1.weapon",
    "huwon2.weapon",
    "parkour.player",
  },
  ["firstfmember"] = {
    "firstfmember",
    "firstfmember.money",
    "firstfmembers",
    "mask.shop",
    "huwon1.weapon",
    "huwon2.weapon",
    "huwon3.weapon",
    "parkour.player",
  },
  ["trinitymember"] = {
    "trinitymember",
    "trinitymember.money",
    "trinitymembers",
    "mask.shop",
    "huwon1.weapon",
    "huwon2.weapon",
    "huwon3.weapon",
    "huwon4.weapon",
    "parkour.player",
  },
  ["crownmember"] = {
    "crownmember",
    "vehicle.hwrepair",
    "crownmember.money",
    "crownmembers",
    "mask.shop",
    "huwon1.weapon",
    "huwon2.weapon",
    "huwon3.weapon",
    "huwon4.weapon",
    "huwon5.weapon",
    "parkour.player",
  },
  ["prestigemember"] = {
    "prestigemember",
    "vehicle.hwrepair",
    "prestigemember.money",
    "prestigemembers",
    "huwon1.weapon",
    "huwon2.weapon",
    "huwon3.weapon",
    "parkour.player",
  },
  ["highendmember"] = {
    "highendmember",
    "vehicle.hwrepair",
    "highendmember.money",
    "highendmembers",
    "huwon1.weapon",
    "huwon2.weapon",
    "huwon3.weapon",
    "parkour.player",
  },
  ["musicboxmember"] = {
    "musicbox.player"
  },    
  ["ban8426"] = {
    "player.ban",
    "player.unban"
  },
  ["vehall8426"] = {
    "admin.spawnveh",
    "admin.deleteveh"
  },
  ["delveh8426"] = {
    "admin.deleteveh"
  },
  ["adminr8426"] = {
    "admin.cloakroom"
  },
  ["adminw8426"] = {
    "admin.loadshop"
  },
  ["showname"] = {
    "player.showname"
  },
  ["specialskin"] = {
    "player.specialskin"
  },
  ["관리자"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"관리자"})
      end
    },
    "admin.paycheck",
    "admin.whitelisted"
  },
  ["감사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"감사"})
      end
    },
    "inspector.paycheck",
    "inspector.whitelisted"
  },
  ["스태프장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"스태프장"})
      end
    },
    "staffboss.tc",
    "staft.bonus",
    "player.group.addstaffab",
    "player.group.delstaffab",
    "real.staffnotice",
    "player.blips",
    "helper.paycheck",
    "lic.police",
    "chatrules.helper",
    "admin.tickets",
    "player.check",
    "admin.announce",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.tp",
    "admin.static",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "helper.cloakroom",
    "helper.whitelisted"
  },
  ["스태프장[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"스태프장[퇴근]"})
      end
    },
    "staffboss.tc"
  },
  ["스태프"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"스태프"})
      end
    },
    "staff.tc",
    "staft.bonus",
    "real.staffnotice",
    "player.blips",
    "helper.paycheck",
    "lic.police",
    "chatrules.helper",
    "admin.tickets",
    "player.check",
    "admin.announce",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.tp",
    "admin.static",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "helper.cloakroom",
    "helper.whitelisted"
  },
  ["스태프[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"스태프[퇴근]"})
      end
    },
    "staff.tc"
  },
  ["임시스태프"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"임시 스태프"})
      end
    },
    "imstaff.tc",
    "staft.bonus",
    "real.staffnotice",
    "player.blips",
    "helper.paycheck",
    "lic.police",
    "chatrules.helper",
    "admin.tickets",
    "player.check",
    "admin.announce",
    "admin.menu",
    "admin.easy_unjail",
    "admin.spikes",
    "admin.godmode",
    "admin.tp",
    "admin.static",
    "player.tptowaypoint",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.coords",
    "player.tptome",
    "player.tpto",
    "emergency.revive",
    "police.menu",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "vehicle.repair",
    "repair.vehicle",
    "helper.cloakroom",
    "helper.whitelisted"
  },
  ["임시스태프[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"임시 스태프[퇴근]"})
      end
    },
    "imstaff.tc",
    "staff2.tc"
  },
  ["시내버스기사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"시내버스기사"})
      end
    },
    "bus.vehicle",
    "bus.cloakroom",
    "bus.paycheck"
  },
  ["관광버스기사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"관광버스기사"})
      end
    },
    "bus.vehicle",
    "bus.cloakroom",
    "bus.paycheck"
  },
  ["독사회 두목"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 리더 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.godfather",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia1.paycheck", -- Paycheck ( if you want)
    "player.group.adddok",
    "player.group.removedok",
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },
  ["독사회 부두목"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 부두목 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.godfather",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia2.paycheck", -- Paycheck ( if you want)
    "player.group.adddok",
    "player.group.removedok",
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },
  ["독사회 고문"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 고문 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.godfather",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia3.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },
  ["독사회 간부"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 간부 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia4.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },
  ["독사회 전무"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 전무 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia5.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },  
  ["독사회 비서"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 비서 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia5.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },
  ["독사회 행동대장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 행동대장 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia6.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },
  ["독사회 행동원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 행동원 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a1",
    "casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia7.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },
  ["독사회 수습일원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 독사회 수습일원 입니다."})
      end
    },
    "gang.whitelisted",
    "mk2w.a1",
    "chatrules.blood1",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    --"mafia8.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "dok.whitelisted",
    "harvest.weed"
  },  
  ["백사회 두목"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 리더 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    "chatrules.godfather",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia1.paycheck", -- Paycheck ( if you want)
    "player.group.addmafia",
    "player.group.removemafia",
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["백사회 부두목"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 부두목 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    "chatrules.godfather",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia2.paycheck", -- Paycheck ( if you want)
    "player.group.addmafia",
    "player.group.removemafia",
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["백사회 고문"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 고문 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    --"casinotoken.market",
    "chatrules.godfather",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia3.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["백사회 간부"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 간부 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
    --"casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia4.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["백사회 전무"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 전무 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
    --"casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia5.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },  
  ["백사회 비서"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 비서 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
    --"casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia5.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["백사회 행동대장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 행동대장 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
    --"casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia6.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["백사회 행동원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 행동원 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
   -- "casinotoken.market",
    "chatrules.blood2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia7.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["백사회 수습일원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 백사회 수습일원 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
    "chatrules.blood1",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "mafia.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"mafia8.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "mafia.realestate",
    "mafia.whitelisted",
    "mafia.cloakroom",
    "harvest.weed"
  },
  ["흑사회 두목"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 리더 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
   -- "casinotoken.market",
    "chatrules.shh4",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh1.paycheck", -- Paycheck ( if you want)
    "player.group.addshh",
    "player.group.removeshh",
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["흑사회 부두목"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 부두목 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
  --  "casinotoken.market",
    "chatrules.shh3",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh2.paycheck", -- Paycheck ( if you want)
    "player.group.addshh",
    "player.group.removeshh",
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["흑사회 고문"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 고문 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
 --   "casinotoken.market",
    "chatrules.shh3",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh3.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["흑사회 간부"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 간부 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a2", -- 스나이퍼 이용
    "mk2w.a1",
  --  "casinotoken.market",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh4.paycheck",
    "chatrules.shh5",
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["흑사회 전무"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 전무 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
   -- "casinotoken.market",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh5.paycheck",
    "chatrules.shh5",
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },  
  ["흑사회 비서"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 비서 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
    --"casinotoken.market",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh5.paycheck",
    "chatrules.shh5",
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["흑사회 행동대장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 행동대장 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
 --   "casinotoken.market",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh6.paycheck", -- Paycheck ( if you want)
    "chatrules.shh6",
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["흑사회 행동원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 행동원 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
 --   "casinotoken.market",
    "chatrules.shh2",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh7.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["흑사회 수습일원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 흑사회 수습일원 입니다."})
      end
    },
    "drug.gang", -- 마약 원재료 구매
    "gang.whitelisted",
    "mk2w.a1",
    "chatrules.shh1",
    "police.menu", -- Acces to the police menu to use all of the things below.
    "police.easy_cuff", -- Acces to cuff someone
    "police.drag", -- Acces to drag a a cuffed person
    "police.putinveh", -- Acces to put a handcuff player in a vehicle.
    "police.getoutveh", -- Acces to take out a handcuff player from a vehicle
    "shh.loadshop", -- Gunshop for the mafia.
    "police.store_weapons", -- Acces to store weapons
    "mafia.vehicle", -- Acces to the garage.
    "mafia.whitelisted", -- Whitelisted group
    --"shh8.paycheck", -- Paycheck ( if you want)
    "mission.drugseller.weed",
    "drugseller.market",
    "shh.cloakroom",
    "shh.realestate",
    "shh.whitelisted",
    "harvest.weed"
  },
  ["퍼스트렉카 회장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 회장입니다."})
      end
    },
    "vehicle.frrepair",
    "frrepairkit",
    "rekcar.megaphone",
    "frekcar.vehicle",
    "admin.deleteveh",
    "frk_tc01",
    "fristrc.service",
    "erjio.a1",
    "erjio.market",
    "chatrules.gmchairman",
    "gm1.paycheck",
    "gm.vehicle",
    "gm.whitelisted",
    "gm.cloakroom",
    "player.group.addgm",
    "player.group.removegm"
  },
  ["퍼스트렉카 회장[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 회장입니다."})
      end
    },
    "frk_tc01",
    "chatrules.gmchairman",
    "gm.whitelisted",
  },  
  ["퍼스트렉카 사장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 사장입니다."})
      end
    },
    "vehicle.frrepair",
    "frrepairkit",
    "rekcar.megaphone",
    "frekcar.vehicle",
    "admin.deleteveh",
    "frk_tc02",
    "fristrc.service",
    "erjio.a1",
    "erjio.market",
    "chatrules.gmchairman",
    --"gm2.paycheck",
    "gm.whitelisted",
    "gm.cloakroom",
    "player.group.addgm",
    "player.group.removegm"
  },
  ["퍼스트렉카 사장[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 사장입니다."})
      end
    },
    "frk_tc02",
    "chatrules.gmchairman",
    "gm.whitelisted",
  },   
  ["퍼스트렉카 부사장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 부사장입니다."})
      end
    },
    "vehicle.frrepair",
    "frrepairkit",
    "rekcar.megaphone",
    "frekcar.vehicle",
    "admin.deleteveh",
    "frk_tc03",
    "fristrc.service",
    "erjio.a1",
    "erjio.market",
    "chatrules.gmchairman",
    --"gm3.paycheck",
    "gm.whitelisted",
    "gm.cloakroom"
  },
  ["퍼스트렉카 부사장[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 부사장입니다."})
      end
    },
    "frk_tc03",
    "chatrules.gmchairman",
    "gm.whitelisted",
  },    
  ["퍼스트렉카 전무이사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 전무이사입니다."})
      end
    },
    "vehicle.frrepair",
    "frrepairkit",
    "rekcar.megaphone",
    "frekcar.vehicle",
    "admin.deleteveh",
    "frk_tc04",
    "fristrc.service",
    "erjio.a1",
    "chatrules.gmchairman",
    --"gm4.paycheck",
    "gm.whitelisted",
    "gm.cloakroom"
  },
  ["퍼스트렉카 전무이사[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 전무이사입니다."})
      end
    },
    "frk_tc04",
    "chatrules.gmchairman",
    "gm.whitelisted",
  },    
  ["퍼스트렉카 상무이사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 상무이사입니다."})
      end
    },
    "vehicle.frrepair",
    "frrepairkit",
    "rekcar.megaphone",
    "frekcar.vehicle",
    "frk_tc05",
    "fristrc.service",
    "erjio.a1",
    "chatrules.gmchairman",
    --"gm5.paycheck",
    "gm.whitelisted",
    "gm.cloakroom"
  },
  ["퍼스트렉카 상무이사[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 상무이사입니다."})
      end
    },
    "frk_tc05",
    "chatrules.gmchairman",
    "gm.whitelisted",
  },  
  ["퍼스트렉카 사원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 사원입니다."})
      end
    },
    "vehicle.frrepair",
    "frrepairkit",
    "rekcar.megaphone",
    "frekcar.vehicle",
    "frk_tc06",
    "fristrc.service",
    "erjio.a1",
    "chatrules.gmchairman",
    --"gm6.paycheck",
    "gm.whitelisted",
    "gm.cloakroom"
  },
  ["퍼스트렉카 사원[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 사원입니다."})
      end
    },
    "frk_tc06",
    "chatrules.gmchairman",
    "gm.whitelisted",
  },  
  ["퍼스트렉카 인턴"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 인턴입니다."})
      end
    },
    "vehicle.frrepair",
    "frrepairkit",
    "rekcar.megaphone",
    "frekcar.vehicle",
    "frk_tc07",
    "fristrc.service",
    "erjio.a1",
    "chatrules.gmchairman",
    --"gm7.paycheck",
    "gm.whitelisted",
    "gm.cloakroom"
  },
  ["퍼스트렉카 인턴[퇴근]"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 퍼스트 렉카 인턴입니다."})
      end
    },
    "frk_tc07",
    "chatrules.gmchairman",
    "gm.whitelisted",
  },
  ["치안총감"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "policebts.market",
    "SWAT3.loadshop",
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.poldirector",
    "Captain.cloakroom",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    "police.putinveh",
    "police.getoutveh",
    "police.service",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "SWAT2.loadshop",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "SWAT.loadshop",
    "cop.whitelisted",
    "police.loadshop",
    "police1.paycheck",
    "police.menu_interaction",
    "police.mission",
    "player.group.addcop",
    "player.group.removecop",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police1.tc" --출퇴근
  },
  ["치안총감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police1.tc" --출퇴근
  },
  ["치안정감"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "SWAT3.loadshop",
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.policecaptain",
    "Captain.cloakroom",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.service",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.loadshop",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "SWAT.loadshop",
    "cop.whitelisted",
    "police2.paycheck",
    "police.menu_interaction",
    "SWAT2.loadshop",
    "police.mission",
    "player.group.addcop",
    "player.group.removecop",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police2.tc" --치안정감 출퇴근
  },
  ["치안정감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police2.tc" --출근
  },
  ["치안감"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "SWAT3.loadshop",
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.policecaptain",
    "Captain.cloakroom",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.service",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "SWAT2.loadshop",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.loadshop",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "SWAT.loadshop",
    "cop.whitelisted",
    "police3.paycheck",
    "police.menu_interaction",
    "police.mission",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police3.tc" --출퇴근
  },
  ["치안감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police3.tc" --출퇴근
  },
  ["경무관"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "SWAT3.loadshop",
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.policecaptain",
    "Captain.cloakroom",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    "police.putinveh",
    "police.getoutveh",
    "police.service",
    "SWAT2.loadshop",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.loadshop",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "SWAT.loadshop",
    "cop.whitelisted",
    "police3.paycheck",
    "police.menu_interaction",
    "police.mission",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "polices1_tc" --출퇴근
  },
  ["경무관[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "polices1_tc" --출퇴근
  },
  ["파출소장"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "player.blips",
    "chatrules.policecaptain",
    "Captain.cloakroom",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.service",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.loadshop",
    "police.seize.weapons",
    "SWAT2.loadshop",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "SWAT.loadshop",
    "cop.whitelisted",
    "police3.paycheck",
    "police.menu_interaction",
    "police.mission",
    "police.megaphone",
    "player.group.addcop",
    "player.group.removecop",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police10.tc" --출퇴근
  },
  ["파출소장[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police10.tc" --출퇴근
  },
  ["파출대원"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "player.blips",
    "chatrules.lspd4",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "SWAT.loadshop",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "SWAT2.loadshop",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "cop.whitelisted",
    --"player.list",
    "police6.paycheck",
    "police.mission",
    --"player.blips",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police11.tc" --출퇴근
  },
  ["파출대원[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police11.tc" --출퇴근
  },
  ["경정"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "SWAT3.loadshop",
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd5",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.vehicle",
    "SWAT.loadshop",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "SWAT2.loadshop",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "cop.whitelisted",
    --"player.list",
    "police4.paycheck",
    "police.mission",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police4.tc" --출퇴근
  },
  ["경정[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police4.tc" --출퇴근
  },
  ["경감"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "SWAT3.loadshop",
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd5",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    "SWAT.loadshop",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "SWAT2.loadshop",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "police.loadshop",
    "cop.whitelisted",
    --"player.list",
    "police5.paycheck",
    "police.mission",
    --"player.blips",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police5.tc" --출퇴근
  },
  ["경감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police5.tc" --출퇴근
  },
  ["경위"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "SWAT2.loadshop",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd4",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "SWAT.loadshop",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "police.loadshop",
    "cop.whitelisted",
    --"player.list",
    "police6.paycheck",
    "police.mission",
    --"player.blips",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police6.tc" --출퇴근
  },
  ["경위[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police6.tc" --출퇴근
  },
  ["경사"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd3",
    "SWAT.loadshop",
    "SWAT2.loadshop",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "police.loadshop",
    "cop.whitelisted",
    --"player.list",
    "police7.paycheck",
    "police.mission",
    --"player.blips",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police7.tc" --출퇴근
  },
  ["경사[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police7.tc" --출퇴근
  },
  ["경장"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd2",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "SWAT.loadshop",
    "SWAT2.loadshop",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "police.loadshop",
    "cop.whitelisted",
    --"player.list",
    "police8.paycheck",
    "police.mission",
    --"player.blips",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police8.tc" --출퇴근
  },
  ["경장[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police8.tc" --출퇴근
  },
  ["순경"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.bg",
    "real.policenotice",
    "police_ch.pc",
    "policia.em_servico",
    "cop",
    "lic.police",
    "policer.vehicle",
    "SWAT2.loadshop",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd1",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "police.loadshop",
    "cop.whitelisted",
    --"player.list",
    "police9.paycheck",
    "police.mission",
    --"player.blips",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police9.tc" --출퇴근
  },
  ["순경[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police9.tc" --출퇴근
  },
  ["경찰훈련생"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd1",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    --"police.handcuff",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    --"police.jail",
    --"police.fine",
    "police.announce",
    -- "-police.store_weapons",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "police.vehicle",
    "police.loadshop",
    "cop.whitelisted",
    --"player.list",
    "police9.paycheck",
    "police.mission",
    --"player.blips",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "police12.tc" --출퇴근
  },
  ["경찰훈련생[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "cop.whitelisted",
    "police.menu",
    "police.cloakroom",
    "police12.tc" --출퇴근
  },
  ["경찰 의경"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "lic.police",
    "policer.vehicle",
    "player.group.addsubae",
    "player.group.removesubae",
    "player.check",
    "chatrules.lspd1",
    "Officer.cloakroom",
    "highway.cloakroom",
    "police.cloakroom",
    "police.pc",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.spikes",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.service",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "police.vehicle",
    "cop.whitelisted",
    "police.mission",
    "police.menu_interaction",
    "police.megaphone",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle"
  },
  ["소방총감"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "player.group.addemsab",
    "player.group.removeemsab",
    "ems.jt",
    "chatrules.emscheif1",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems1.paycheck",
    "ems.mission",
    "ems.announce",
    "player.group.addems",
    "player.group.removeems",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems1.tc" -- 출퇴근
  },
  ["소방총감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems1.tc" --출퇴근
  },
  ["소방정감"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "player.group.addemsab",
    "player.group.removeemsab",
    "ems.jt",
    "chatrules.emscheif1",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems2.paycheck",
    "ems.mission",
    "ems.announce",
    "player.group.addems",
    "player.group.removeems",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems2.tc" -- 출퇴근
  },
  ["소방정감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems2.tc" --출퇴근
  },
  ["소방감"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "player.group.addemsab",
    "player.group.removeemsab",
    "ems.jt",
    "chatrules.emscheif1",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems01.paycheck",
    "ems.mission",
    "ems.announce",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems01.tc" -- 출퇴근
  },
  ["소방감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems01.tc" --출퇴근
  },
  ["소방준감"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.emscheif2",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems3.paycheck",
    "ems.announce",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems3.tc" -- 출퇴근
  },
  ["소방준감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems3.tc" --출퇴근
  },
  ["소방정"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.emscheif2",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems02.paycheck",
    "ems.mission",
    "ems.announce",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems02.tc" -- 출퇴근
  },
  ["소방정[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems02.tc" --출퇴근
  },
  ["소방령"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.emscheif2",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems4.paycheck",
    "ems.mission",
    "ems.announce",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems4.tc" -- 출퇴근
  },
  ["소방령[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems4.tc" --출퇴근
  },
  ["소방경"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.emscheif2",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems5.paycheck",
    "ems.mission",
    "ems.announce",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems5.tc" -- 출퇴근
  },
  ["소방경[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems5.tc" --출퇴근
  },
  ["소방위"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.emscheif2",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems6.paycheck",
    "ems.mission",
    "ems.announce",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems6.tc" -- 출퇴근
  },
  ["소방위[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems6.tc" --출퇴근
  },
  ["소방장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.paramedic",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emscheck.revive",
    "emergency.cloakroom",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems7.paycheck",
    "ems.mission",
    "ems.announce",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems7.tc" -- 출퇴근
  },
  ["소방장[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems7.tc" --출퇴근
  },
  ["소방대원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.emssnr",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems8.paycheck",
    "ems.mission",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle",
    "ems8.tc" -- 출퇴근
  },
  ["소방대원[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {false})
      end
    },
    "ems.whitelisted",
    "ems8.tc" --출퇴근
  },
  ["소방교육생"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 EMS 시스템 접속 완료."})
      end
    },
    "real.emsnotice",
    "ems.jt",
    "chatrules.emssnr",
    "emergency.revive",
    "police.pc",
    --"police.wanted",
    "emergency.shop",
    "emergency.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    --"player.list",
    "police.menu_interaction",
    "ems.mission",
    "admin.deleteveh",
    "vehicle.repair",
    "repair.vehicle"
  },
  ["emsab"] = {
    "emergency.revive",
    "emergency.service",
    "emscheck.revive",
    "emergency.vehicle",
    "ems.whitelisted"
  },
  -- 리얼 다이소
  ["리얼다이소 회장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 회장입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.paycheck", --월급
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.a1",
    "daiso.market",
    "player.group.adddaiso",
    "player.group.removedaiso"
  },
  ["리얼다이소 사장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 사장입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.market",
    "daiso.a1",
    "player.group.adddaiso2",
    "player.group.removedaiso2"
  },
  ["리얼다이소 전무이사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 전무이사 입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.a1",
    "daiso.market",
    "player.group.adddaiso2",
    "player.group.removedaiso2"
  },
  ["리얼다이소 부장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 부장 입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.a1",
    "daiso.market"
  },
  ["리얼다이소 팀장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 팀장 입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.a1"
  },
  ["리얼다이소 대리"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 대리 입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.a1"
  },
  ["리얼다이소 사원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 사원 입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.a1"
  },
  ["리얼다이소 인턴"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼다이소 인턴 입니다."})
      end
    },
    "chatrules.tow", --기능없는거
    "daiso.vehicle", --전용차량
    "tow.whitelisted",
    --기능X
    "daiso.a1"
  },  
  ["월드렉카 대표"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼방송국 대표입니다."})
      end
    },
    "tow.whitelisted",
    "tow.service",
    --  "carjacker.lockpick",
    "player.group.addtow",
    "player.group.removetow"
  },
  ["월드렉카 이사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 월드렉카 이사입니다."})
      end
    },
    "chatrules.tow",
    "tow2.paycheck",
    "tow.vehicle",
    "tow.whitelisted",
    "tow.cloakroom",
    "tow.service",
    "carjacker.lockpick",
    "player.group.addtow",
    "player.group.removetow"
  },
  ["월드렉카 부장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 월드렉카 부장입니다."})
      end
    },
    "chatrules.tow",
    "tow.vehicle",
    "tow.whitelisted",
    "tow.cloakroom",
    "tow.service",
    "carjacker.lockpick"
  },
  ["월드렉카 차장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 월드렉카 차장입니다."})
      end
    },
    "chatrules.tow",
    "tow.vehicle",
    "tow.whitelisted",
    "tow.cloakroom",
    "tow.service",
    "carjacker.lockpick"
  },
  ["월드렉카 과장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 월드렉카 과장입니다."})
      end
    },
    "chatrules.tow",
    "tow.vehicle",
    "tow.whitelisted",
    "tow.cloakroom",
    "tow.service",
    "carjacker.lockpick"
  },
  ["월드렉카 대리"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 월드렉카 대리입니다."})
      end
    },
    "chatrules.tow",
    "tow.vehicle",
    "tow.whitelisted",
    "tow.cloakroom",
    "tow.service",
    "carjacker.lockpick"
  },
  ["월드렉카 주임"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 월드렉카 주임입니다."})
      end
    },
    "chatrules.tow",
    "tow.vehicle",
    "tow.whitelisted",
    "tow.cloakroom",
    "tow.service",
    "carjacker.lockpick"
  },
  ["월드렉카 사원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 월드렉카 사원입니다."})
      end
    },
    "chatrules.tow",
    "tow.vehicle",
    "tow.whitelisted",
    "tow.cloakroom",
    "tow.service",
    "carjacker.lockpick"
  },
  ["수도방위사령부 사령관"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "elysium.army.executive",
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy1.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 소장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy2.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 준장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy3.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 대령"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy4.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 중령"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy5.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 소령"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy6.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 대위"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy7.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 중위"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy8.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 소위"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy9.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 준위"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy10.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 원사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy11.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 상사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy12.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 중사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy13.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 하사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy14.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 병장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy15.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 상병"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy16.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 일병"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy17.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 이병"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy18.paycheck",
    "army.whitelisted"
  },
  ["수도방위사령부 훈련병"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"ECDC 접속 완료! 충성!"})
      end
    },
    "admin.deleteveh",
    "elysiumarmy.cloakroom",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.menu",
    "toggle.service",
    "police.freeze",
    "-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
    "elysiumarmy.vehicle",
    "elysiumarmy.loadshop",
    "emergency.market",
    "emergency.shop",
    "elysiumarmy19.paycheck",
    "army.whitelisted"
  },
  ---> 교도소 팩션 직업 리스트
  ["교정 본부장"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "player.kick",
    "kys1.tc",
    "vehicle.repair",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "player.group.addkys",
    "player.group.removekys",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys1.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교정 본부장[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys1.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["교정 부본부장"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "player.kick",
    "kys2.tc",
    "vehicle.repair",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "player.group.addkys2",
    "player.group.removekys2",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys2.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교정 부본부장[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys2.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["교정 이사관"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "player.kick",
    "kys001.tc",
    "vehicle.repair",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys001.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },  
  ["교정 이사관[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys2.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },  
  ["교정 과장"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "kys3.tc",
    "vehicle.repair",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys3.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교정 과장[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys3.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["서기관"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "kys002.tc",
    "vehicle.repair",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys002.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["서기관[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys002.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },  
  ["교정관"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "kys4.tc",
    "vehicle.repair",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys4.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교정관[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys4.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["교감"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "kys5.tc",
    "vehicle.repair",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys5.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교감[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys5.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["교위관"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys6.paycheck",
    "police.mission",
    "police.menu_interaction",
    "kys6.tc",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교위관[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys6.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["교사관"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "kys7.tc",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys7.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교사관[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys7.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["교도관"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "kys8.tc",
    "emergency.revive",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys8.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교도관[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys8.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ["교정본부 훈련생"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "kyojung.blips",
    "kys.cloakroom",
    "kys.loadshop",
    "police.pc",
    "kys.vehicle",
    "police.putinveh",
    "police.getoutveh",
    "police.drag",
    "police.easy_cuff",
    "police.easy_fine",
    "police.easy_jail",
    "police.easy_unjail",
    "police.menu",
    "police.check",
    "toggle.service",
    "kys9.tc",
    "police.freeze",
    "police.wanted",
    "police.seize.weapons",
    "police.seize.items",
    "police.announce",
    "-police.seizable",
    "kys.whitelisted",
    "kys9.paycheck",
    "police.mission",
    "police.menu_interaction",
    "admin.deleteveh",
    "player.group.removeprison",
    "player.group.addprison"
  },
  ["교정본부 훈련생[퇴근]"] = {
    _config = {
      gtype = "job",
      onjoin = function(player)
        vRPclient.setCop(player, {true})
      end,
      onspawn = function(player)
        vRPclient.setCop(player, {true})
      end,
      onleave = function(player)
        vRPclient.setCop(player, {true})
      end
    },
    "police.menu",
    "kys9.tc",
    "kys.cloakroom",
    "kys.whitelisted"
  },
  ----------------------------------------------------------------------------------------------------------------------------
  ["대통령"] = {
    _config = {
      gtype = "job",
      isChanged = true,
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼월드 대통령 입니다."})
      end
    },
    "president1.paycheck",
    "president.vehicle",
    "gov.cloakroom",
    "gov.whitelisted",
    "player.group.addgov",
    "player.group.removegov"
  },
  ["대통령 비서"] = {
    _config = {
      gtype = "job",
      isChanged = true,
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 대통령 비서 입니다."})
      end
    },
    "president2.paycheck",
    "president.vehicle",
    "gov.cloakroom",
    "gov.whitelisted"
  },
  ["대통령 경호원"] = {
    _config = {
      gtype = "job",
      isChanged = true,
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 대통령 경호원 입니다."})
      end
    },
    "president3.paycheck",
    "president.vehicle",
    "gov.cloakroom",
    "gov.whitelisted"
  },
  ["국무총리"] = {
    _config = {
      gtype = "job",
      isChanged = true,
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼월드 국무총리 입니다."})
      end
    },
    "gov1.paycheck",
    "gov.vehicle",
    "president.vehicle",
    "gov.cloakroom",
    "gov.whitelisted"
  },
  ["국회의원"] = {
    _config = {
      gtype = "job",
      isChanged = true,
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼월드 국회의원 입니다."})
      end
    },
    "gov2.paycheck",
    "gov.vehicle",
    "president.vehicle",
    "gov.cloakroom",
    "gov.whitelisted"
  },
  ["사채업자"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 사채업자 입니다!"})
      end
    }
  },
  ["거지"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 거지 입니다!"})
      end
    }
  },
  ["DJ"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 DJ 입니다!"})
      end
    }
  },  
  ["호구"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 호구 입니다!"})
      end
    }
  },
  ["실업자"] = {
    _config = {
      gtype = "job",
      isChanged = true,
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 실업자 입니다."})
      end
    },
    "citizen.paycheck"
  },
  ["광부"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 광부 입니다!"})
      end
    },
    "farm.legal123", -- 광부 스크립트 적용
    "miner.market",
    "farm.legal3333", -- 나무꾼 스크립트 적용
    "huntingjobs", -- 사냥꾼 스크립트 적용
    "farm.legal",
    "milk.market"
  },
  ["나무꾼"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 나무꾼 입니다!"})
      end
    },
    "farm.legal123", -- 광부 스크립트 적용
    "miner.market",
    "farm.legal3333", -- 나무꾼 스크립트 적용
    "huntingjobs", -- 사냥꾼 스크립트 적용
    "farm.legal",
    "milk.market"
  },
  ["사냥꾼"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 사냥꾼 입니다!"})
      end
    },
    "farm.legal123", -- 광부 스크립트 적용
    "miner.market",
    "farm.legal3333", -- 나무꾼 스크립트 적용
    "huntingjobs", -- 사냥꾼 스크립트 적용
    "farm.legal",
    "milk.market"
  },
  ["배달부"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부 입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery1",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.2"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery2",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.3"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery3",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.4"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery4",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.5"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery5",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.6"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery6",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.7"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery7",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.8"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery8",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.9"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery9",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.10"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery10",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.11"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery11",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.12"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery12",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.13"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery13",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.14"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery14",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["배달부 LV.15"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 배달부입니다!"})
      end
    },
    "chatrules.delivery",
    "mission.delivery15",
    "delivery.vehicle",
    "delivery.paycheck",
    "delivery.service"
  },
  ["어부"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 어부입니다. 월척이다!"})
      end
    },
    "mission.delivery.fish",
    "fisher.service",
    "fisher.vehicle"
  },
  ["의료수송원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 의료수송원 입니다."})
      end
    },
    "mission.delivery.medical",
    "medical.service",
    "medical.make",
    "medical.vehicle",
    "medical.paycheck"
  },
  ["정비공"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"리얼월드 정비공님 어서오세요!"})
      end
    },
    "chatrules.mechanic",
    "vehicle.repair",
    "vehicle.replace",
    "repair.service",
    "mission.repair.satellite_dishes",
    "mission.repair.wind_turbines",
    "repair.vehicle",
    "repair.market",
    "repair.paycheck",
    "repair.whitelisted"
  },
  ["택배기사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 택배기사 입니다."})
      end
    },
    "chatrules.ups",
    "ups.cloakroom",
    "okups",
    "ups.paycheck"
  },
  ["택시"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 리얼월드 소속 법인 택시기사 입니다."})
      end
    },
    "uber.service",
    "uber.vehicle",
    "uber.mission",
    "uber.paycheck",
    "uber.whitelisted"
  },
  ["개인택시"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 개인 택시기사 입니다."})
      end
    },
    "uber.service",
    "uber.vehicle",
    "uber2.vehicle",
    "uber.mission",
    "uber2.paycheck",
    "uber.whitelisted"
  },
  ["트럭기사"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 트럭기사 입니다!"})
      end
    },
    "trucker.vehicle",
    "trucker.mission",
    "trucker.paycheck"
  },
  ["피자배달부"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 피자배달부 입니다!"})
      end
    },
    "domino.vehicle",
    "domino.mission",
    "domino.paycheck"
  },
  ["환경미화원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 환경미화원 입니다."})
      end
    },
    "chatrules.trash",
    "mission.collect.trash",
    "trash.vehicle",
    "trash.paycheck"
  },
  ["현금호송원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"You are a Bank Driver. Salary: 2000."})
      end
    },
    "chatrules.moneybank",
    "mission.Bank.moneybank",
    "bankdriver.vehicle",
    "bankdriver.paycheck",
    "bankdriver.money"
  },
  ["마약밀매상"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "drugseller.market",
    "chatrules.drug",
    --"mission.weed.mission1",
    "harvest.weed",
    "mission.drugseller.weed"
  },
  ["마약밀매상 LV.2"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission2",
    "harvest.weed"
  },
  ["마약밀매상 LV.3"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission3",
    "harvest.weed"
  },
  ["마약밀매상 LV.4"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission4",
    "harvest.weed"
  },
  ["마약밀매상 LV.5"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission5",
    "harvest.weed"
  },
  ["마약밀매상 LV.6"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission6",
    "harvest.weed"
  },
  ["마약밀매상 LV.7"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission7",
    "harvest.weed"
  },
  ["마약밀매상 LV.8"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission8",
    "harvest.weed"
  },
  ["마약밀매상 LV.9"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission9",
    "harvest.weed"
  }, 
  ["마약밀매상 LV.10"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission10",
    "harvest.weed"
  },  
  ["마약밀매상 LV.11"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission11",
    "harvest.weed"
  },  
  ["마약밀매상 LV.12"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission12",
    "harvest.weed"
  },  
  ["마약밀매상 LV.13"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission13",
    "harvest.weed"
  },  
  ["마약밀매상 LV.14"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
    "chatrules.drug",
    "mission.weed.mission14",
    "harvest.weed"
  },  
  ["마약밀매상 LV.15"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 마약밀매상 입니다!"})
      end
    },
      "chatrules.drug",
      "mission.weed.mission15",
      "harvest.weed"
  },
  ["도미노피자 직원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {"당신은 도미노피자 직원 입니다!"})
      end
    },
    "chatrules.domino2",
    "mission.delivery.domino",
    "domino.vehicle",
    "domino.paycheck",
    "domino.service"
  },
  ["리얼문화방송 국장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs1.paycheck",
    "cbs.whitelisted",
    "player.group.addcbs",
    "realhc.vehicle",
    "player.group.removecbs"
  },
  ["리얼문화방송 부국장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs2.paycheck",
    "cbs.whitelisted",
    "player.group.addcbs2",
    "realhc.vehicle",
    "player.group.removecbs2"
  },
  ["리얼문화방송 사장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs3.paycheck",
    "cbs.whitelisted",
    "player.group.addcbs3",
    "realhc.vehicle",
    "player.group.removecbs3"
  },
  ["리얼문화방송 부사장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs4.paycheck",
    "realhc.vehicle",
    "cbs.whitelisted"
  },
  ["리얼문화방송 부장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs5.paycheck",
    "realhc.vehicle",
    "cbs.whitelisted"
  },
  ["리얼문화방송 차장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs6.paycheck",
    "realhc.vehicle",
    "cbs.whitelisted"
  },
  ["리얼문화방송 과장"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs7.paycheck",
    "realhc.vehicle",
    "cbs.whitelisted"
  },
  ["리얼문화방송 대리"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs8.paycheck",
    "realhc.vehicle",
    "cbs.whitelisted"
  },
  ["리얼문화방송 사원"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs9.paycheck",
    "realhc.vehicle",
    "cbs.whitelisted"
  },
  ["리얼문화방송 인턴"] = {
    _config = {
      gtype = "job",
      onspawn = function(player)
        vRPclient.notify(player, {""})
      end
    },
    "realcbs10.paycheck",
    "realhc.vehicle",
    "cbs.whitelisted"
  },
  ["mask.shop"] = {
    "mask.shop"
  },  
  ["title.enable"] = {
    "title.enable"
  },
  ["title.basic1"] = {
    "title.basic"
  },
  ["title.basic2"] = {
    "title.basic"
  },
  ["title.basic3"] = {
    "title.basic"
  },
  ["title.basic4"] = {
    "title.basic"
  },
  ["title.basic5"] = {
    "title.basic"
  },
  ["title.basic6"] = {
    "title.basic"
  },
  ["title.basic7"] = {
    "title.basic"
  },
  ["title.basic8"] = {
    "title.basic"
  },
  ["title.basic9"] = {
    "title.basic"
  },
  ["title.basic10"] = {
    "title.basic"
  },
  ["title.basic11"] = {
    "title.basic"
  },
  ["title.basic12"] = {
    "title.basic"
  },
  ["title.advanced1"] = {
    "title.advanced"
  },
  ["title.advanced2"] = {
    "title.advanced"
  },
  ["title.advanced3"] = {
    "title.advanced"
  },
  ["title.advanced4"] = {
    "title.advanced"
  },
  ["title.advanced5"] = {
    "title.advanced"
  },
  ["title.advanced6"] = {
    "title.advanced"
  },
  ["title.advanced7"] = {
    "title.advanced"
  },
  ["title.advanced8"] = {
    "title.advanced"
  },
  ["title.advanced9"] = {
    "title.advanced"
  },
  ["title.advanced10"] = {
    "title.advanced"
  },
  ["title.rare1"] = {
    "title.rare"
  },
  ["title.rare2"] = {
    "title.rare"
  },
  ["title.rare3"] = {
    "title.rare"
  },
  ["title.rare4"] = {
    "title.rare"
  },
  ["title.rare5"] = {
    "title.rare"
  },
  ["title.rare6"] = {
    "title.rare"
  },
  ["title.unique1"] = {
    "title.unique"
  },
  ["title.unique2"] = {
    "title.unique"
  },
  ["title.unique3"] = {
    "title.unique"
  },
  ["title.unique4"] = {
    "title.unique"
  },
  ["title.god1"] = {
    "title.god"
  },
  ["title.god2"] = {
    "title.god"
  },
  ["title.god3"] = {
    "title.god"
  },
  ["title.god4"] = {
    "title.god"
  },
  ["title.zombie1"] = {
    "title.zombie"
  },
  ["title.zombie2"] = {
    "title.zombie"
  },
  ["title.zombie3"] = {
    "title.zombie"
  },
  ["title.gold1"] = {
    "title.gold"
  },
  ["title.gold2"] = {
    "title.gold",
    "title.gold.paycheck"
  },
  ["title.supporter1"] = {
    "title.supporter"
  },
  ["title.supporter2"] = {
    "title.supporter"
  },
  ["title.supporter3"] = {
    "title.supporter"
  },
  ["title.supporter4"] = {
    "title.supporter"
  },
  ["title.supporter5"] = {
    "title.supporter"
  },
  ["title.supporter6"] = {
    "title.supporter"
  },
  ["title.supporter7"] = {
    "title.supporter"
  },
  ["title.supporter8"] = {
    "title.supporter"
  },
  ["title.supporter9"] = {
    "title.supporter"
  },
  ["title.supporter10"] = {
    "title.supporter"
  },
  ["nameicon.admin1"] = {
    "nameicon.admin1"
  },
  ["nameicon.admin2"] = {
    "nameicon.admin2"
  },
  ["nameicon.admin3"] = {
    "nameicon.admin3"
  },
  ["nameicon.yh"] = {
    "nameicon.yh"
  },
  ["nameicon.hy"] = {
    "nameicon.hy"
  },
  ["nameicon.bl"] = {
    "nameicon.bl"
  },
  ["nameicon.lj"] = {
    "nameicon.lj"
  },
  ["nameicon.ad"] = {
    "nameicon.ad"
  },
  ["nameicon.god"] = {
    "nameicon.god"
  },
  ["nameicon.helper1"] = {
    "nameicon.helper1"
  },
  ["nameicon.helper2"] = {
    "nameicon.helper2"
  },
  ["nameicon.helper3"] = {
    "nameicon.helper3"
  },
  ["nameicon.moderator"] = {
    "nameicon.moderator"
  }
}

-- groups are added dynamically using the API or the menu, but you can add group when an user join here
cfg.users = {
  [1] = {
    -- give superadmin and admin group to the first created user on the database
    "superadmin",
    "admin",
    "recruiter"
  }
}

-- group selectors
-- _config
--- x,y,z, blipid, blipcolor, permissions (optional)

cfg.selectors = {
  ["구인구직"] = {
    _config = {
      x = -550.63606689453,
      y = -191.31655334473,
      z = 38.219722747803,
      blipid = 351,
      blipcolor = 47,
      text = "구인 구직"
    },
    "정비공",
    "배달부",
    "어부",
    --"환경미화원",
    "피자배달부",
    "의료수송원",
    --"트럭기사",
    "택배기사",
    "택시"
  },
  ["직업선택"] = {
    _config = {
      x = -2239.912109375,
      y = 261.56512451172,
      z = 174.60891723633,
      blipid = 351,
      blipcolor = 47,
      text = "직업 선택"
    },
    "정비공",
    "배달부",
    "어부",
    --"환경미화원",
    "피자배달부",
    "의료수송원",
    "트럭기사",
    "택배기사",
    "택시"
  },
  ["drugseller job"] = {
    _config = {x = 382.15795898438, y = -816.17822265625, z = 29.304250717163, blipid = 277, blipcolor = 4},
    "마약밀매상"
  }
}

return cfg
