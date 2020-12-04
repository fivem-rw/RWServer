resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_01_CLASS_ROCK" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706711437363511306/1c83e2f91a517d7e.ogg", volume = 0.2, name = "뉴 에이지" }
supersede_radio "RADIO_02_POP" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706711529252454469/8958bc0fc0286e8f.ogg", volume = 0.2, name = "유행하는 POP SONG" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706881747064717312/-_.ogg", volume = 0.2, name = "김마리 그리운날 그리운널" }
supersede_radio "RADIO_04_PUNK" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706709295865135154/1ed12e20a8fd47d4.ogg", volume = 0.2, name = "2000년대 추억의 음악" }
supersede_radio "RADIO_05_TALK_01" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706711637712961566/60752c53b2b3d054.ogg", volume = 0.2, name = "재즈" }
supersede_radio "RADIO_06_COUNTRY" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706704080394911774/b87a06ab29852ecf.ogg", volume = 0.2, name = "클럽 음악" }
supersede_radio "RADIO_07_DANCE_01" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706711572822753320/9856f18d6a99e6b6.ogg", volume = 0.2, name = "우타이테" }
supersede_radio "RADIO_08_MEXICAN" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706709256056995881/5.ogg", volume = 0.2, name = "멜론 5월 K-POP 차트" } 
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706714599537377290/LCK__-_DUDUDUNGA_vs_.ogg", volume = 0.2, name = "머쉬베놈 - 두둥등장" }
supersede_radio "RADIO_12_REGGAE" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706881763930144848/edm_HD_.ogg", volume = 0.2, name = "관짝 EDM" }
supersede_radio "RADIO_13_JAZZ" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706881829218681057/videoplayback_5.ogg", volume = 0.2, name = "2019 BEST 걸그룹 노래" }
supersede_radio "RADIO_14_DANCE_02" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706881845266219068/61ec142b5337a2ad.ogg", volume = 0.2, name = "한요한 범퍼카" }
supersede_radio "RADIO_15_MOTOWN" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706967684956553367/card.ogg", volume = 0.2, name = "카드캡터 체리 OST" }
supersede_radio "RADIO_16_SILVERLAKE" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706714587676016700/koreanhiphap.ogg", volume = 0.2, name = "2020년 5월 한국 힙합노래" }
supersede_radio "RADIO_17_FUNK" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706955072067600435/KK_.ogg", volume = 0.6, name = "K.K - 나비보벳따우" }
supersede_radio "RADIO_18_90S_ROCK" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706714597687558144/gangrap.ogg", volume = 0.2, name = "갱스터 힙합" }
supersede_radio "RADIO_20_THELAB" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706959210822500482/realword_1.ogg", volume = 0.2, name = "리얼월드 정규앨범 1집" }
--supersede_radio "RADIO_21_DLC_XM17" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706714597687558144/gangrap.ogg", volume = 0.2, name = "리얼월드 정규앨범 2집" }
--supersede_radio "RADIO_22_DLC_BATTLE_MIX1_RADIO" { url = "https://cdn.discordapp.com/attachments/706107859678658570/706714597687558144/gangrap.ogg", volume = 0.2, name = "리얼월드 정규앨범3집" }

files {
	"index.html"
}

ui_page "index.html"
shared_script "@evp/main.lua"
client_scripts {
	"data.js",
	"client.js"
}
