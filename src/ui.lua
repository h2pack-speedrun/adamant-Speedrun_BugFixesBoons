-- luacheck: globals BugFixesBoonsInternal lib
local internal = BugFixesBoonsInternal

local function DrawOptions(ui, uiState)
    for _, option in ipairs(internal.option_fns or {}) do
        if option.type == "checkbox" then
            lib.widgets.checkbox(ui, uiState, option.configKey, {
                label = option.label,
                tooltip = option.tooltip,
            })
        end
    end
end

function internal.DrawTab(ui, uiState)
    DrawOptions(ui, uiState)
end

return internal
