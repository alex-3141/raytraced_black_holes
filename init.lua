---@diagnostic disable: undefined-global

HARDCAP = math.floor(ModSettingGet("raytraced_black_holes.hard_cap") + 0.5)
RBH_VERSION = "1.0.2"

local RBH = dofile_once("mods/raytraced_black_holes/files/rbh.lua")
local translations = dofile_once("mods/raytraced_black_holes/files/translations.lua")

Benchmarking = false
ModSettingSet("raytraced_black_holes.run_benchmark", false)
BENCH_WAS_RUN = false
SMALL_DISCS = ModSettingGet("raytraced_black_holes.accretion_disks_on_small_black_holes_enabled")
WORLD_UPDATE_TIME = 0

local worldStartTime = 0

function OnWorldInitialized()
  RBH.onWorldInitialized()
end

function OnModInit()
  ModSettingSet('raytraced_black_holes.run_benchmark', false)
  ModSettingSetNextValue('raytraced_black_holes.run_benchmark', false, false)
  translations.apply()
  RBH.injectShadercode()
  print("Raytraced Black Holes v" .. RBH_VERSION .. " initialized")
end

function OnWorldPostUpdate()
  WORLD_UPDATE_TIME = GameGetRealWorldTimeSinceStarted() - worldStartTime
  RBH.run()
end

function OnWorldPreUpdate()
  worldStartTime = GameGetRealWorldTimeSinceStarted()
end