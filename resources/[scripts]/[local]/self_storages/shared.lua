locations = {
    ["packer1"] = {
        fee = 50,
        name = "아이템 포장센터",
        sub_name = "(광장지점)",
        size = 40000,
        cost = 1000000,
        storage_locations = {
            {x = 191.12634277344, y = -904.64428710938, z = 31.028440475464}
        }
    },
    ["packer2"] = {
        fee = 50,
        name = "아이템 포장센터",
        sub_name = "(메인차고지점)",
        size = 40000,
        cost = 1000000,
        storage_locations = {
            {x = 204.67253112793, y = -803.32952880859, z = 31.02813911438}
        }
    },
    ["packer3"] = {
        fee = 50,
        name = "아이템 포장센터",
        sub_name = "(경찰서지점)",
        size = 40000,
        cost = 1000000,
        storage_locations = {
            {x = 432.34048461914, y = -973.87091064453, z = 30.710729598999}
        }
    },
    ["packer4"] = {
        fee = 50,
        name = "아이템 포장센터",
        sub_name = "(의료국지점)",
        size = 40000,
        cost = 1000000,
        storage_locations = {
            {x = 369.73287963867, y = -602.65130615234, z = 28.866662979126}
        }
    },
    ["packer5"] = {
        fee = 50,
        name = "아이템 포장센터",
        sub_name = "(다이소지점)",
        size = 40000,
        cost = 1000000,
        storage_locations = {
            {x = -312.16696166992, y = -1027.6765136719, z = 30.385089874268}
        }
    }
}
function ReadableNumber(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then
        return 0
    elseif num >= 1000000000000 then
        ret = placeValue:format(num / 1000000000000) .. " Tril" -- trillion
    elseif num >= 1000000000 then
        ret = placeValue:format(num / 1000000000) .. " Bil" -- billion
    elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. " Mil" -- million
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = num -- hundreds
    end
    return ret
end
