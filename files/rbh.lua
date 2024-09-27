---@diagnostic disable: undefined-global

local injector = dofile_once("mods/raytraced_black_holes/files/injector.lua")
local bench = dofile_once("mods/raytraced_black_holes/files/bench.lua")

local injectShadercode
local updateUniforms
local normalize_vec3
local getBlackHoleType
local getBlackHoleSize
local blackHoleIsRegistered
local patchBlackHole
local findNewBlackHoles
local updateBlackHoles
local checkForPause
local doDeltaTimeStuff
local processBlackHoles
local run
local bhScale
local getBlackHole
local worldToShaderPos
local frameDrawEnd
local pushToGPU
local onWorldInitialized

local FRAME_ACC = 5
local ThisFrameTime = 0
local LastFrameTime = 0
local FrameTimes = {}
for i = 1, FRAME_ACC, 1 do
        table.insert(FrameTimes, 1 / 60)
end
local FrameTime = 1 / 60
local active_black_holes = {}
local EARTH = 5.972e24
local EARTHMASSES = 147.0
local SCALEMASS = 1.683e28
local DEFAULT_BLACK_HOLE_SIZE = 12
local SCALE_TO_SHADOW = true
local VIEWPORT_SCALE
local SCALE
local SCALE_FACTOR
local DISC_THRESHOLD_MIN
local DISC_THRESHOLD_MIN_SMALL
local DISC_THRESHOLD_MAX
local DISC_THRESHOLD_MAX_SMALL
local SMALL_DISCS

onWorldInitialized = function()
        updateUniforms()
        local title = GameTextGetTranslatedOrNot('$rbh_title')
        local welcome = GameTextGetTranslatedOrNot('$rbh_welcome')
        local firstRunMessage = '[' .. title .. '] ' .. welcome
        GamePrint(firstRunMessage)
        bench.clearOverlay()
        ModSettingSet('raytraced_black_holes.run_benchmark', false)
        local virtResX = MagicNumbersGetValue("VIRTUAL_RESOLUTION_X")
        local virtResY = MagicNumbersGetValue("VIRTUAL_RESOLUTION_Y")
        VIEWPORT_SCALE = 1 / math.min(virtResX / 427, virtResY / 242)
        SCALE = 0.85 * VIEWPORT_SCALE
        SCALE_FACTOR = SCALE * (EARTH * EARTHMASSES) / SCALEMASS
        DISC_THRESHOLD_MIN = 0.03 * VIEWPORT_SCALE
        DISC_THRESHOLD_MIN_SMALL = 0.0;
        DISC_THRESHOLD_MAX = 0.05 * VIEWPORT_SCALE
        DISC_THRESHOLD_MAX_SMALL = 0.015 * VIEWPORT_SCALE
        SMALL_DISCS = ModSettingGet("raytraced_black_holes.accretion_disks_on_small_black_holes_enabled")
end

injectShadercode = function()
        injector.injectShadercode(HARDCAP, HARDCAP)
        bench.createOverlay()
end

updateUniforms = function()
        local discs_enabled = ModSettingGet("raytraced_black_holes.accretion_discs_enabled")
        local disc_bloom_intensity = ModSettingGet("raytraced_black_holes.accretion_disc_bloom_intensity")
        local depth = ModSettingGet("raytraced_black_holes.scene_depth")
        local warp_scale = ModSettingGet("raytraced_black_holes.warp_scale")
        local steps = ModSettingGet("raytraced_black_holes.raymarching_steps")
        local disk_opacity = ModSettingGet("raytraced_black_holes.disk_effect_opacity")
        local white_hole_bloom_intensity = ModSettingGet("raytraced_black_holes.white_hole_bloom_intensity")
        local invert_white_holes = ModSettingGet("raytraced_black_holes.invert_white_holes")
        local max_holes = ModSettingGet("raytraced_black_holes.max_holes")

        GameSetPostFxParameter("RBH_discs_enabled", discs_enabled and 1.0 or 0.0, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_disc_bloom_intensity", disc_bloom_intensity, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_depth", depth, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_warp_scale", warp_scale, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_steps", steps, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_disc_threshold", DISC_THRESHOLD_MIN, DISC_THRESHOLD_MAX, 0.0, 0.0)
        GameSetPostFxParameter("RBH_disk_opacity", disk_opacity, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_white_hole_bloom_intensity", white_hole_bloom_intensity, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_invert_white_holes", invert_white_holes and 1.0 or 0.0, 0.0, 0.0, 0.0)
        GameSetPostFxParameter("RBH_max", max_holes, 0.0, 0.0, 0.0)
end

normalize_vec3 = function(v)
        local len = math.sqrt(v[1] * v[1] + v[2] * v[2] + v[3] * v[3])
        return { v[1] / len, v[2] / len, v[3] / len }
end

getBlackHoleType = function(entityID)
        local force = 1
        local bhComp = EntityGetFirstComponent(entityID, "BlackHoleComponent")
        if bhComp ~= nil then
                force = ComponentGetValue2(bhComp, "particle_attractor_force")
        else
                local variableComp = EntityGetFirstComponent(entityID, "VariableStorageComponent")
                if variableComp ~= nil and ComponentGetValue2(variableComp, "name") == "projectile_file" then
                        local value = ComponentGetValue2(variableComp, "value_string")
                        if value == "data/entities/projectiles/deck/black_hole.xml" then
                                force = 1
                        elseif value == "data/entities/projectiles/deck/white_hole.xml" then
                                force = -1
                        else
                                -- Is this not a black hole?
                                return 0
                        end
                else
                        -- Is this not a black hole?
                        return 0
                end
        end

        if force < 0 then
                return -1.0
        else
                return 1.0
        end
end

blackHoleIsRegistered = function(black_hole)
        for k, v in ipairs(active_black_holes) do
                if v.id == black_hole then
                        return true
                end
        end
        return false
end

getBlackHoleSize = function(entityID)
        local bhComp = EntityGetFirstComponent(entityID, "BlackHoleComponent")
        local size = nil

        if bhComp ~= nil then
                size = ComponentGetValue2(bhComp, "radius")
        else
                local cellEaterComp = EntityGetFirstComponent(entityID, "CellEaterComponent")
                if cellEaterComp ~= nil then
                        size = ComponentGetValue2(cellEaterComp, "radius")
                else
                        -- Retrieve last known size from our active black holes list
                        if blackHoleIsRegistered(entityID) then
                                return getBlackHole(entityID).size
                        else
                                return DEFAULT_BLACK_HOLE_SIZE
                        end
                end
        end

        if SCALE_TO_SHADOW then
                size = size / 2.6
        end

        return (size / DEFAULT_BLACK_HOLE_SIZE) * SCALE_FACTOR
end

patchBlackHole = function(id)
        -- Remove all sprite components
        local sprites = EntityGetComponent(id, "SpriteComponent")
        if sprites ~= nil then
                for i, sprite in ipairs(sprites) do
                        EntityRemoveComponent(id, sprite)
                end
        end

        -- Remove all particle emitter components
        local emitters = EntityGetComponent(id, "ParticleEmitterComponent")
        if emitters ~= nil then
                for i, emitter in ipairs(emitters) do
                        EntityRemoveComponent(id, emitter)
                end
        end

        -- Remove black hole explosion sprite
        local projectileComp = EntityGetFirstComponent(id, "ProjectileComponent")
        if projectileComp ~= nil then
                ComponentObjectSetValue2(projectileComp, "config_explosion", "explosion_sprite", "")
        end
end

-- Get updated list of active black holes
findNewBlackHoles = function()
        local black_holes = EntityGetWithTag("black_hole")
        -- Check if black hole is not in our active_black_holes list
        for k, id in ipairs(black_holes) do
                if not blackHoleIsRegistered(id) then
                        -- Add it to the list
                        local type = getBlackHoleType(id)
                        if(type == 0) then
                                return
                        end
                        local x, y, rotation = EntityGetTransform(id)
                        local size = getBlackHoleSize(id) * type
                        local seed = math.random() * 15
                        table.insert(active_black_holes,
                                {
                                        id = id,
                                        x = x,
                                        y = y,
                                        rotation = rotation,
                                        time = 0,
                                        type = type,
                                        size = size,
                                        seed =
                                            seed
                                })
                        patchBlackHole(id)
                else
                        -- Update size of black hole
                        local black_hole = getBlackHole(id)
                        if(black_hole) then
                                black_hole.size = getBlackHoleSize(id) * black_hole.type
                        end
                end
        end
end

-- Update black hole list
updateBlackHoles = function()
        for i = #active_black_holes, 1, -1 do
                local black_hole = active_black_holes[i]
                black_hole.time = black_hole.time + 1

                -- Remove black hole from list if expired
                if black_hole.time == 0 then
                        table.remove(active_black_holes, i)
                else
                        if not EntityGetIsAlive(black_hole.id) and black_hole.time > 0 then
                                -- Start fizzle animation
                                black_hole.time = -10 -- Negatives used for fizzling
                        elseif black_hole.time > 0 then
                                black_hole.x, black_hole.y, black_hole.rotation = EntityGetTransform(black_hole.id)
                                -- black_hole.size = getBlackHoleSize(black_hole.id)
                        end
                end
        end
end

checkForPause = function()
        -- If the frame time is huge, the game was very likely paused. Good time to reload settings that may have changed
        if ThisFrameTime - LastFrameTime < 0.5 then
                return
        end

        SMALL_DISCS = ModSettingGet("raytraced_black_holes.accretion_disks_on_small_black_holes_enabled")
        local incomingBenchState = ModSettingGet("raytraced_black_holes.run_benchmark")

        if incomingBenchState and not Benchmarking then
                bench.startBenchmark()
        end
end

doDeltaTimeStuff = function()
        local frameTime = ThisFrameTime - LastFrameTime

        table.insert(FrameTimes, frameTime)
        if #FrameTimes > FRAME_ACC then
                table.remove(FrameTimes, 1)
        end

        local medianFrameTimes = {}
        for i = 1, #FrameTimes, 1 do
                table.insert(medianFrameTimes, FrameTimes[i])
        end

        table.sort(medianFrameTimes)

        -- Remove outliers
        table.remove(medianFrameTimes, 1)
        table.remove(medianFrameTimes, #medianFrameTimes)

        local averageFrameTime = 0
        for i = 1, #medianFrameTimes, 1 do
                averageFrameTime = averageFrameTime + medianFrameTimes[i]
        end
        FrameTime = averageFrameTime / #medianFrameTimes
end

processBlackHoles = function()
        local active_black_holes_scaled = {}
        local time = GameGetRealWorldTimeSinceStarted()

        for i = 1, #active_black_holes, 1 do
                local black_hole = active_black_holes[i]
                local size = black_hole.size * bhScale(black_hole.time)
                local x, y = worldToShaderPos(black_hole.x, black_hole.y)
                local data = {
                        id = black_hole.id,
                        x = x,
                        y = y,
                        rotation = black_hole.rotation,
                        time = black_hole.time,
                        type = black_hole.type,
                        mass = size,
                        disc = true,
                        seed = black_hole.seed,
                        discNormal = normalize_vec3 { math.sin(time), math.cos(time), math.tan(time) }
                }

                table.insert(active_black_holes_scaled, data)
        end

        return active_black_holes_scaled
end

pushToGPU = function(active_black_holes_scaled)
        local discs = {}

        for i = 1, math.min(#active_black_holes_scaled, HARDCAP), 1 do
                local black_hole = active_black_holes_scaled[i]
                GameSetPostFxParameter("RBH_" .. tostring(i - 1), black_hole.x, black_hole.y, black_hole.mass,
                        black_hole.type > 0 and 0.0 or 1.0)
                if black_hole.disc and (black_hole.mass > DISC_THRESHOLD_MIN or SMALL_DISCS) then
                        local disc = {
                                x = black_hole.x,
                                y = black_hole.y,
                                mass = black_hole.mass,
                                angle = black_hole
                                    .seed
                        }
                        table.insert(discs, disc)
                end
        end

        for i = 1, #discs, 1 do
                local disc = discs[i]
                GameSetPostFxParameter("RBH_DISC_" .. tostring(i - 1), disc.x, disc.y, disc.mass, disc.angle)
        end

        local disc_count = discs and #discs or 0

        GameSetPostFxParameter("RBH_count", #active_black_holes_scaled, 0, disc_count, #active_black_holes_scaled)
        local discThresholdMin = DISC_THRESHOLD_MIN
        local discThresholdMax = DISC_THRESHOLD_MAX
        if(SMALL_DISCS) then
                discThresholdMin = DISC_THRESHOLD_MIN_SMALL
                discThresholdMax = DISC_THRESHOLD_MAX_SMALL
        end
        GameSetPostFxParameter("RBH_disc_threshold", discThresholdMin, discThresholdMax, 0.0, 0.0)
end

run = function()
        GameSetPostFxParameter("RBH_live_editing", 0.0, 0.0, 0.0, 0.0)

        LastFrameTime = ThisFrameTime
        ThisFrameTime = GameGetRealWorldTimeSinceStarted() - WORLD_UPDATE_TIME

        doDeltaTimeStuff()
        findNewBlackHoles()
        updateBlackHoles()

        checkForPause()

        if(Benchmarking) then
                bench.run(FrameTime)
                return
        end

        local active_black_holes_scaled = processBlackHoles()

        pushToGPU(active_black_holes_scaled)
end


-- Define which scaling functions to use based on black hole lifetime
-- negative livetime denotes fizzle animation
bhScale = function(x)
        local return_val
        -- Fizzle
        if x <= -6 then
                return_val = -(((x + 5) / 20) + 1) ^ (math.pi * math.exp(1)) + 1
                -- Fizzle bounce
        elseif x <= 0 then
                return_val = -(1 / 3) * math.sin((math.pi * (x - 5)) / 5)
                -- Growing
        elseif x <= 23 then
                return_val = -(-x / 80 + 1) ^ (math.pi * math.exp(1)) + 1
                -- Stable
        else
                return_val = 1
        end

        -- Threshold to prevent floating point errors
        if math.abs(return_val) < 0.01 then
                return_val = 0
        end

        return return_val
end

getBlackHole = function(black_hole)
        for k, v in ipairs(active_black_holes) do
                if v.id == black_hole then
                        return v
                end
        end
        return nil
end

worldToShaderPos = function(x, y)
        local width, height = 427.0, 242.0
        width = width / VIEWPORT_SCALE
        height = height / VIEWPORT_SCALE
        local cam_x, cam_y = GameGetCameraPos()
        local sx = (x - cam_x + width / 2) / width
        local sy = (y - cam_y + height / 2) / height

        sy = 1 - sy

        -- Correct for aspect ratio
        local aspect_ratio = width / height
        sx = sx * aspect_ratio

        return sx, sy
end

return {
        onWorldInitialized = onWorldInitialized,
        injectShadercode = injectShadercode,
        run = run,
        frameDrawEnd = frameDrawEnd
}
