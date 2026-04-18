-- luacheck: globals BugFixesBoonsInternal public
local internal = BugFixesBoonsInternal

internal.patch_fns = {}
internal.hook_fns = {}
internal.option_fns = {}

local PACK_ID = "speedrun"

local function BuildStorage(options)
    local storage = {}
    for _, option in ipairs(options) do
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

public.definition.storage = BuildStorage(internal.option_fns)

function internal.BuildPatchPlan(plan, activeStore)
    for _, b in ipairs(internal.patch_fns) do
        if activeStore.read(b.key) and b.fn then
            b.fn(plan)
        end
    end
end

function internal.RegisterHooks()
    for _, fn in ipairs(internal.hook_fns) do
        fn()
    end
end

return internal
