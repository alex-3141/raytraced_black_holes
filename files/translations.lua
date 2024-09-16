---@diagnostic disable: undefined-global

local function apply()
        local common = ModTextFileGetContent("data/translations/common.csv")
        local tl = ModTextFileGetContent("mods/raytraced_black_holes/files/translations.csv")
        common = common .. "\n" .. tl .. "\n"
        common = common:gsub("\r", ""):gsub("\n\n+", "\n")
        ModTextFileSetContent("data/translations/common.csv", common)
end

return {
        apply = apply
}
