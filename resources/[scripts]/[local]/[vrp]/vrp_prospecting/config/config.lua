--[[
    bScript™ vrp_prospect (https://www.bareungak.com/)
    
    Sort : Configuration
	Version : 1.01

    Author : Bareungak (https://steamcommunity.com/id/Bareungak)
]]
--[[

    LICENSE (EN)

    Licenses are provided in a leased form to the licensed purchaser and under no circumstances can be transferred to another person.

    Seller and developer shall not be liable for any legal indemnity if the licensed purchaser cancels the licence in violation of the terms and conditions.

    In the event of property damage to the developer or seller caused by a significant event in connection with the license, 
    the developer or seller shall claim damages and be designated as a competent court near the developer or seller's location in the event of a lawsuit.

    The terms and conditions take effect after the corresponding script is applied.

]]
--[[

    라이선스 (KO)

    허가된 구매자에게 라이선스를 임대형식으로 제공하며 어떠한 경우에도 타인에게 라이선스를 양도 할 수 없다.

    허가된 구매자가 해당 약관을 위반하여 라이선스가 취소되는 경우 판매자와 개발자는 그 어떤 법적 배상의 책임을 지지 않는다.

    라이선스와 관련하여 중대한 사건으로 인해 개발자 또는 판매자에게 재산상의 손해가 발생한 경우
    개발자 또는 판매자는 해당 구매자에게 손해배상을 청구하고, 소송시 개발자 또는 판매자 소재지 근처의 관할 법원으로 지정한다.

    해당 스크립트를 적용한 이후 부터 해당 약관의 효력이 발생한다.

]]
--[[

    구매자 : 블린#8279 (270173476357144576)
    UID : #13
    구매 일시 : 2020.03.10

    에게 임대 형식으로 라이선스를 적용하며, 약관 위반사항 또는 라이선스와 관련하여 중대한 사건 발생으로 인해 
    개발자 판매자에게 재산상의 손해가 발생한 경우 구매자가 전적으로 책임지며, 라이선스는 취소되 해당 에드온을 사용할 수 없다.

]]
-- 아이템 위치 (아이템 ID / 수량 / 아이템 이름 / 희귀도)

cfg = {}

cfg.locations = {
    {
        x = 1600.185,
        y = 6622.714,
        z = 15.85106,
        data = {
            id = "ksrandom",
            amount = 1,
            name = "🎫희미한 티켓"
        }
    },
    {
        x = 1548.082,
        y = 6633.096,
        z = 2.377085,
        data = {
            id = "ksrandom",
            amount = 1,
            name = "🎫희미한 티켓"
        }
    },
    {
        x = 1504.235,
        y = 6579.784,
        z = 4.365892,
        data = {
            id = "ksrandom",
            amount = 1,
            name = "🎫희미한 티켓"
        }
    },
    {
        x = 1580.016,
        y = 6547.394,
        z = 15.96557,
        data = {
            id = "ksrandom",
            amount = 1,
            name = "🎫희미한 티켓",
            valuable = true
        }
    },
    {
        x = 1634.586,
        y = 6596.688,
        z = 22.55633,
        data = {
            id = "ksrandom",
            amount = 1,
            name = "🎫희미한 티켓"
        }
    },
    {
        x = 415.5217590332,
        y = -1006.2969360352,
        z = 29.259206771851,
        data = {
            id = "ksrandom",
            amount = 1,
            name = "🎫희미한 티켓"
        }
    }
}
-- 아이템 테이블 (아이템 ID / 수량 / 확률 / 아이템 이름 / 희소성)

cfg.item_pool = {
    {id = "ksrandom", amount = 1, name = "🎫희미한 티켓", valuable = false},
    {id = "ksrandom", amount = 1, name = "🎫희미한 티켓", valuable = false},
    {id = "ksrandom", amount = 1, name = "🎫희미한 티켓", valuable = false},
    {id = "ksrandom", amount = 1, name = "🎫희미한 티켓", valuable = true},
    {id = "ksrandom", amount = 1, name = "🎫희미한 티켓", valuable = false},
    {id = "ksrandom", amount = 1, name = "🎫희미한 티켓", valuable = true}
}

-- 구역 생성 (백터 3(X,Y,Z) / 구역 사이즈 / 맵 아이콘 ID / 맵 아이콘 이름)

cfg.base_location = vector3(1580.9, 6592.204, 13.84828)
cfg.area_size = 100.0
cfg.blip_sprite = 485
cfg.blip_name = "탐지장"
