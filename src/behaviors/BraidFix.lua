local internal = BugFixesBoonsInternal
local option_fns = internal.option_fns
local patch_fns = internal.patch_fns

table.insert(option_fns,
    {
        type = "checkbox",
        configKey = "BraidFix",
        label = "Braid Fix",
        default = true,
        tooltip =
        "Fixes Braid of Atlas to properly buff casts."
    })
table.insert(patch_fns, {
    key = "BraidFix",
    fn = function(plan)
        if not TraitData.TemporaryImprovedCastTrait then return end
        local mods = TraitData.TemporaryImprovedCastTrait.AddOutgoingDamageModifiers
        plan:set(mods, "ValidProjectiles", WeaponSets.CastProjectileNames)
        plan:set(mods, "WeaponOrProjectileRequirement", true)
    end
})
