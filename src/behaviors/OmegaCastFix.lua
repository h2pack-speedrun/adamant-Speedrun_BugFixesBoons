local internal = BugFixesBoonsInternal
local option_fns = internal.option_fns
local patch_fns = internal.patch_fns

table.insert(option_fns,
    {
        type = "checkbox",
        configKey = "OmegaCastFix",
        label = "Omega Cast Fix",
        default = true,
        tooltip =
        "Fixes OCast moves not counting as cast damage."
    })
table.insert(patch_fns, {
    key = "OmegaCastFix",
    fn = function(plan)
        local missingCastProjectiles = {
            "ApolloCastRapid",
            "AresProjectile",
            "ZeusApolloSynergyStrike",
            "DemeterCastStorm",
            "AthenaCastProjectile",
        }
        for _, projectileName in ipairs(missingCastProjectiles) do
            plan:appendUnique(WeaponSets, "CastProjectileNames", projectileName)
        end
    end
})
