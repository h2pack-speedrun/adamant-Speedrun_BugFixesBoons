-- luacheck: globals BugFixesBoonsInternal
local internal = BugFixesBoonsInternal

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
