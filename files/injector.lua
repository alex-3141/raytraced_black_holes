---@diagnostic disable: undefined-global

local function esc(str)
        str = str:gsub("([^%w%s])", "%%%1")
        str = str:gsub("%s+", "%%%s*")
        return str
end

local function shaderReplace(text, line, replacement)
        return text:gsub(line, replacement)
end

local function shaderInsertAfter(text, line, insertion)
        return text:gsub("(" .. line .. ")", "%1\n" .. insertion)
end

local function injectShadercode(_MaxBlackHoles, _MaxDiscs)
        local patchVersion = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/version.frag")
        local patchDefines = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/defines.frag")
        local patchMainLoop = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/main_loop.frag")
        local patchLiquids = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/liquids.frag")
        local patchGlow = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/glow.frag")
        local patchFogCoords = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/fog_coords.frag")
        local patchSkylightCoords = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/skylight_coords.frag")
        local patchFog = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/fog.frag")
        local patchNightvision = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/nightvision.frag")
        local patchLights = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/lights.frag")
        local patchShroom = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/shroom.frag")
        local patchOverlay = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/overlay.frag")
        local patchLowHealth = ModTextFileGetContent("mods/raytraced_black_holes/files/patches/low_health.frag")

        local shadercode = ModTextFileGetContent("data/shaders/post_final.frag")

        -- Bump version to at least 130
        local versionStart, versionEnd, version = string.find(shadercode, "#version%s(%d+)")
        if (tonumber(version) < 130) then
                shadercode = shaderReplace(shadercode, "#version " .. version, patchVersion)
        end

        local defineUniforms = ""
        for i = 0, _MaxBlackHoles - 1, 1 do
                defineUniforms = defineUniforms .. "uniform vec4 RBH_" .. i .. ";\n"
        end

        patchDefines = patchDefines:gsub("__uniforms__", defineUniforms)

        local defineUniformsDisc = ""
        for i = 0, _MaxDiscs - 1, 1 do
                defineUniformsDisc = defineUniformsDisc .. "uniform vec4 RBH_DISC_" .. i .. ";\n"
        end

        patchDefines = patchDefines:gsub("__uniforms_disc__", defineUniformsDisc)

        local defineSafestep = ""
        for i = 0, _MaxBlackHoles - 1, 1 do
                defineSafestep = defineSafestep .. "CALC_SAFE_DIST(" .. i .. ");\n"
        end

        patchDefines = patchDefines:gsub("__safestep__", defineSafestep)

        local defineCalcAccel = ""
        for i = 0, _MaxBlackHoles - 1, 1 do
                defineCalcAccel = defineCalcAccel .. "CALC_ACCELERATION(" .. i .. ");\n"
        end

        patchDefines = patchDefines:gsub("__acceleration__", defineCalcAccel)

        local defineRenderDisc = ""
        for i = 0, _MaxDiscs - 1, 1 do
                defineRenderDisc = defineRenderDisc .. "RENDER_DISC(" .. i .. ");\n"
        end

        patchDefines = patchDefines:gsub("__render_disc__", defineRenderDisc)

        shadercode = shaderInsertAfter(shadercode, esc("uniform sampler2D tex_debug2;"), patchDefines)
        shadercode = shaderInsertAfter(shadercode, esc("vec2 tex_coord_glow = tex_coord_glow_;"), patchMainLoop)
        shadercode = shaderReplace(shadercode,
                esc("liquid_mask * sin( distortion_mult + (tex_coord.x + camera_pos.x / world_viewport_size.x ) * DISTORTION_SCALE_MULT) * DISTORTION_SCALE_MULT2,") ..
                "%s+" ..
                esc("liquid_mask * cos( distortion_mult + (tex_coord.y - camera_pos.y / world_viewport_size.y ) * DISTORTION_SCALE_MULT) * DISTORTION_SCALE_MULT2"),
                patchLiquids)
        shadercode = shaderInsertAfter(shadercode, esc("glow = max( vec3(0.0), glow - 0.008 );"), patchGlow)

        -- Make these tex coords not read directly from the uniform so we can patch them
        shadercode = shadercode:gsub('varying vec2 tex_coord_fogofwar;', 'varying vec2 __TEX_COORD_FOGOFWAR__;')
        shadercode = shadercode:gsub('tex_coord_fogofwar', 'RBH_tex_coord_fogofwar')
        shadercode = shadercode:gsub('varying vec2 __TEX_COORD_FOGOFWAR__;', 'varying vec2 tex_coord_fogofwar;')
        shadercode = shaderInsertAfter(shadercode, esc("vec2 FOG_TEX_SIZE = vec2( 64.0 ) * camera_inv_zoom_ratio;"), patchFogCoords)

        shadercode = shadercode:gsub('varying vec2 tex_coord_skylight;', 'varying vec2 __TEX_COORD_SKYLIGHT__;')
        shadercode = shadercode:gsub('tex_coord_skylight', 'RBH_tex_coord_skylight')
        shadercode = shadercode:gsub('varying vec2 __TEX_COORD_SKYLIGHT__;', 'varying vec2 tex_coord_skylight;')
        shadercode = shaderInsertAfter(shadercode, esc("const vec2  SKY_TEX_SIZE   = vec2( 32.0 );"), patchSkylightCoords)

        shadercode = shaderInsertAfter(shadercode, esc("dust_amount = fog_value.g;") .. "%s+" .. esc("}"), patchFog)
        shadercode = shaderInsertAfter(shadercode, esc("float edge_dist = length(tex_coord - vec2(0.5)) * 2.0;"), patchNightvision)
        shadercode = shaderInsertAfter(shadercode, esc("color_fg.rgb = clamp(color_fg.rgb, vec3(0.0,0.0,0.0), vec3(1.0,1.0,1.0));"), patchLights)
        shadercode = shaderInsertAfter(shadercode, esc("color.g = mix( color.g, brightness_shroom * 2.0 * color.g * (sin( time * 1.5 ) + 1.0) * 0.5 + noise.b / 64.0, drugged_color_amount);"), patchShroom)
        shadercode = shaderReplace(shadercode, esc("color.rgb = mix( color, overlay_color.rgb, overlay_color.a );"), patchOverlay)
        shadercode = shaderReplace(shadercode, esc("float a = length(tex_coord - vec2(0.5,0.5));"), patchLowHealth)

        ModTextFileSetContent("data/shaders/post_final.frag", shadercode)
end

return {
        injectShadercode = injectShadercode
}
