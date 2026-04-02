local internal = BugFixesBoonsInternal
local option_fns = internal.option_fns
local patch_fns = internal.patch_fns

table.insert(option_fns,
    {
        type = "checkbox",
        configKey = "CardioTorchFix",
        label = "Cardio Torch Fix",
        default = true,
        tooltip =
        "Fixes Cardio Gain interactions with Torch specials."
    })
table.insert(patch_fns, {
    key = "CardioTorchFix",
    fn = function(plan)
        if not TraitData.HestiaManaBoon then return end
        local args = TraitData.HestiaManaBoon.OnEnemyDamagedAction.Args
        plan:appendUnique(args, "MultihitProjectileWhitelist", "ProjectileTorchOrbit")
        plan:set(args.MultihitProjectileConditions, "ProjectileTorchOrbit", { Cooldown = 0.01 })
    end
})
