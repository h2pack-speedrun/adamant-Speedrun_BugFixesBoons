local PACK_ID = "speedrun"

local data = {
    patches = {},
    hooks = {},
    options = {},
}

local function register(path)
    local behavior = import(path)
    if behavior.option then
        table.insert(data.options, behavior.option)
    end
    for _, patch in ipairs(behavior.patches or {}) do
        table.insert(data.patches, patch)
    end
    for _, hook in ipairs(behavior.hooks or {}) do
        table.insert(data.hooks, hook)
    end
end

function data.buildStorage()
    local storage = {}
    for _, option in ipairs(data.options) do
        if option.type == "checkbox" then
            table.insert(storage, {
                type = "bool",
                alias = option.alias,
                default = option.default == true,
            })
        else
            error(("Unsupported option type '%s' in %s"):format(tostring(option.type), PACK_ID .. ".BugFixesBoons"))
        end
    end
    return storage
end

register("behaviors/BraidFix.lua")
register("behaviors/CardioTorchFix.lua")
register("behaviors/ETFix.lua")
register("behaviors/OmegaCastFix.lua")
register("behaviors/PoseidonWavesFix.lua")
register("behaviors/SecondStageChanneling.lua")
register("behaviors/ShimmeringFix.lua")

return data
