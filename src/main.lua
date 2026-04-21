local mods = rom.mods
mods["SGG_Modding-ENVY"].auto()

---@diagnostic disable: lowercase-global
rom = rom
_PLUGIN = _PLUGIN
game = rom.game
modutil = mods["SGG_Modding-ModUtil"]
local chalk = mods["SGG_Modding-Chalk"]
local reload = mods["SGG_Modding-ReLoad"]
---@type AdamantModpackLib
lib = mods["adamant-ModpackLib"]

local dataDefaults = import("config.lua")
local config = chalk.auto("config.lua")

local PACK_ID = "speedrun"

---@class BugFixesBoonsInternal
---@field store ManagedStore|nil
---@field standaloneUi StandaloneRuntime|nil
---@field RegisterHooks fun()|nil
---@field DrawTab fun(imgui: table, session: AuthorSession)|nil
---@field DrawQuickContent fun(imgui: table, session: AuthorSession)|nil
BugFixesBoonsInternal = BugFixesBoonsInternal or {}
---@type BugFixesBoonsInternal
local internal = BugFixesBoonsInternal

public.definition = {
    modpack = PACK_ID,
    id = "BugFixesBoons",
    name = "Bug Fixes: Boons & Hammers",
    tooltip = "Collection of bug fixes for boons and hammers.",
    default = dataDefaults.Enabled,
    affectsRunData = true,
}

public.host = nil
local store
local session
internal.standaloneUi = nil

local function init()
    import_as_fallback(rom.game)

    import("data.lua")
    import("logic.lua")
    import("ui.lua")

    store, session = lib.createStore(config, public.definition, dataDefaults)
    internal.store = store

    public.host = lib.createModuleHost({
        definition = public.definition,
        store = store,
        session = session,
        hookOwner = internal,
        registerHooks = internal.RegisterHooks,
        drawTab = internal.DrawTab,
    })
    internal.standaloneUi = lib.standaloneHost(public.host)
end

local loader = reload.auto_single()

modutil.once_loaded.game(function()
    loader.load(nil, init)
end)

---@diagnostic disable-next-line: redundant-parameter
rom.gui.add_imgui(function()
    if internal.standaloneUi and internal.standaloneUi.renderWindow then
        internal.standaloneUi.renderWindow()
    end
end)

---@diagnostic disable-next-line: redundant-parameter
rom.gui.add_to_menu_bar(function()
    if internal.standaloneUi and internal.standaloneUi.addMenuBar then
        internal.standaloneUi.addMenuBar()
    end
end)
