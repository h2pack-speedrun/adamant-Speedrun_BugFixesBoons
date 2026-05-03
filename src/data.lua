-- luacheck: globals BugFixesBoonsInternal
local internal = BugFixesBoonsInternal

internal.patch_fns = {}
internal.hook_fns = {}
internal.option_fns = {}

local PACK_ID = "speedrun"

function internal.BuildStorage()
    local storage = {}
    for _, option in ipairs(internal.option_fns) do
        if option.type == "checkbox" then
            table.insert(storage, {
                type = "bool",
                alias = option.configKey,
                configKey = option.configKey,
            })
        else
            error(("Unsupported option type '%s' in %s"):format(tostring(option.type), PACK_ID .. ".BugFixesBoons"))
        end
    end
    return storage
end

import("behaviors/BraidFix.lua")
import("behaviors/CardioTorchFix.lua")
import("behaviors/ETFix.lua")
import("behaviors/OmegaCastFix.lua")
import("behaviors/PoseidonWavesFix.lua")
import("behaviors/SecondStageChanneling.lua")
import("behaviors/ShimmeringFix.lua")

return internal
