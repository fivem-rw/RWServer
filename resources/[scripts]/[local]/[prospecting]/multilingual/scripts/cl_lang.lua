local DEBUG = false
local function debugLog() end
if DEBUG then debugLog = function(...)
    print(...)
end end

local LANG_ENUM = {
    [0] = "american",
    [1] = "french",
    [2] = "german",
    [3] = "italia",
    [4] = "spanish",
    [5] = "portuguese",
    [6] = "polish",
    [7] = "russian",
    [8] = "korean",
    [9] = "chinesetraditional",
    [10] = "japanese",
    [11] = "mexican",
    [12] = "chinesesimplified",
}

function HandleResourceJsonFile(resource, file)
    local lang = GetCurrentLanguage()
    local json_data = LoadResourceFile(resource, file)
    if json_data then
        local lang_data = json.decode(json_data)
        if lang_data and type(lang_data) == 'table' then
            -- Always load freedom labels
            local american_entries = lang_data["american"]
            if american_entries then
                for _, entry_data in next, american_entries do
                    if entry_data["LABEL"] and entry_data["TRANSLATION"] then
                        AddTextEntry(entry_data["LABEL"], entry_data["TRANSLATION"])
                    end
                end
            else
                debugLog("failed to load", file, "from", resource, "(missing base translation)")
            end
            if lang ~= 0 then
                -- Load the non-american language on-top
                local lang_name = LANG_ENUM[lang] or "american" -- but default to freedom just in case
                local lang_entries = lang_data[lang_name]
                if lang_entries then
                    for _, entry_data in next, lang_entries do
                        AddTextEntry(entry_data["LABEL"], entry_data["TRANSLATION"])
                    end
                else
                    debugLog("failed to load", file, "from", resource, "(missing language " .. lang_name .. ")")
                end
            end
        else
            debugLog("failed to load", file, "from", resource, "(invalid data)")
        end
    else
        debugLog("failed to load", file, "from", resource)
    end
end

function HandleResourceJsonMetadata(resource)
    if GetNumResourceMetadata(resource, "language_json") > 0 then
        for i = 0, GetNumResourceMetadata(resource, "language_json") - 1 do
            HandleResourceJsonFile(resource, GetResourceMetadata(resource, "language_json", i))
        end
    end
end

function HandleResource(resource)
    HandleResourceJsonMetadata(resource)
end

AddEventHandler('onClientResourceStart', HandleResource)
