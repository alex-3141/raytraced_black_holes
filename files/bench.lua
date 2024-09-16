---@diagnostic disable: undefined-global

OVERLAY_WIDTH = 427 * 2
OVERLAY_HEIGHT = 242 * 2
BUFFER = OVERLAY_HEIGHT / 6
BENCH_FRAME = -60
BENCH_DURATION = 30 * 60
LastX = BUFFER
LastY = OVERLAY_HEIGHT - BUFFER
OVERLAY = 0

local maxFpsAvg = {}
local positions = {}
local gui = nil
local showResults = false

local run
local drawLine
local drawGraph
local createOverlay
local clearOverlay
local initOverlay
local grid
local startBenchmark
local runBenchmark
local endBenchmark
local abortBenchmark
local stopBenchmarkButton
local hilbertCurve

local glyphs = {
        ['0'] = {
                { 1, 1, 1 },
                { 1, 0, 1 },
                { 1, 0, 1 },
                { 1, 0, 1 },
                { 1, 1, 1 },
        },
        ['1'] = {
                { 0, 1, 0 },
                { 1, 1, 0 },
                { 0, 1, 0 },
                { 0, 1, 0 },
                { 1, 1, 1 },
        },
        ['2'] = {
                { 1, 1, 1 },
                { 0, 0, 1 },
                { 1, 1, 1 },
                { 1, 0, 0 },
                { 1, 1, 1 },
        },
        ['3'] = {
                { 1, 1, 1 },
                { 0, 0, 1 },
                { 1, 1, 1 },
                { 0, 0, 1 },
                { 1, 1, 1 },
        },
        ['4'] = {
                { 1, 0, 1 },
                { 1, 0, 1 },
                { 1, 1, 1 },
                { 0, 0, 1 },
                { 0, 0, 1 },
        },
        ['5'] = {
                { 1, 1, 1 },
                { 1, 0, 0 },
                { 1, 1, 1 },
                { 0, 0, 1 },
                { 1, 1, 1 },
        },
        ['6'] = {
                { 1, 1, 1 },
                { 1, 0, 0 },
                { 1, 1, 1 },
                { 1, 0, 1 },
                { 1, 1, 1 },
        },
        ['7'] = {
                { 1, 1, 1 },
                { 0, 0, 1 },
                { 0, 1, 0 },
                { 1, 0, 0 },
                { 1, 0, 0 },
        },
        ['8'] = {
                { 1, 1, 1 },
                { 1, 0, 1 },
                { 1, 1, 1 },
                { 1, 0, 1 },
                { 1, 1, 1 },
        },
        ['9'] = {
                { 1, 1, 1 },
                { 1, 0, 1 },
                { 1, 1, 1 },
                { 0, 0, 1 },
                { 1, 1, 1 },
        },
        [' '] = {
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
        },
        ['.'] = {
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 1, 0 },
        }
}

local function button(text)
        gui = gui or GuiCreate()
        GuiStartFrame(gui)
        GuiLayoutBeginVertical(gui, 47, 90)

        local buttonId = GuiButton(gui, 12648430, 0, 0, text)
        GuiLayoutEnd(gui)

        return buttonId
end

local function drawGlyph(image, glyph, x, y, scale, color)
    local glyphHeight = #glyph
    for i = 1, glyphHeight do
        for j = 1, #glyph[i] do
            if glyph[i][j] == 1 then
                for dx = 0, scale - 1 do
                    for dy = 0, scale - 1 do
                        ModImageSetPixel(image, x + (j - 1) * scale + dx, y + (glyphHeight - i) * scale + dy, color)
                    end
                end
            end
        end
    end
end

local function drawText(image, text, x, y, scale, color)
        local offsetX = 0
        for i = 1, #text do
                local char = text:sub(i, i)
                local glyph = glyphs[char]
                if glyph then
                        -- Clear the glyph area first by writing zeroes
                        for dx = 0, (#glyph[1] + 1) * scale - 1 do
                                for dy = 0, (#glyph + 1) * scale - 1 do
                                        ModImageSetPixel(image, x + offsetX + dx, y + dy, 0x00000000)
                                end
                        end
                        drawGlyph(image, glyph, x + offsetX, y, scale, color)
                        offsetX = offsetX + (#glyph[1] + 1) * scale -- Move to the next character position
                end
        end
end

clearOverlay = function()
        for x = 0, OVERLAY_WIDTH - 1, 1 do
                for y = 0, OVERLAY_HEIGHT - 1, 1 do
                        ModImageSetPixel(OVERLAY, x, y, 0x00000000)
                end
        end
        LastX = BUFFER
        LastY = OVERLAY_HEIGHT - BUFFER
        GameSetPostFxTextureParameter("RBH_tex_overlay", "rbh_overlay.png", 2, 0, true)
end

createOverlay = function()
        OVERLAY = ModImageMakeEditable("rbh_overlay.png", OVERLAY_WIDTH, OVERLAY_HEIGHT)
end

initOverlay = function()
        clearOverlay()

        -- Guide lines
        for i = 0, 6, 1 do
                local y = BUFFER + (OVERLAY_HEIGHT - BUFFER * 2) / 6 * i
                drawLine(OVERLAY, BUFFER, y, OVERLAY_WIDTH - BUFFER, y, 0x3FFFFFFF)
                -- labels
                drawText(OVERLAY, tostring(i * 10), BUFFER - 20, y - 5, 2, 0x3FFFFFFF)
        end

        -- Border
        drawLine(OVERLAY, BUFFER, BUFFER, OVERLAY_WIDTH - BUFFER, BUFFER, 0xFFFFFFFF)
        drawLine(OVERLAY, BUFFER, BUFFER, BUFFER, OVERLAY_HEIGHT - BUFFER, 0xFFFFFFFF)
        drawLine(OVERLAY, OVERLAY_WIDTH - BUFFER, BUFFER, OVERLAY_WIDTH - BUFFER, OVERLAY_HEIGHT - BUFFER, 0xFFFFFFFF)

        GameSetPostFxTextureParameter("RBH_tex_overlay", "rbh_overlay.png", 2, 0, true)
end

drawLine = function(overlay, x0, y0, x1, y1, color)
        x0 = math.floor(x0)
        y0 = math.floor(y0)
        x1 = math.floor(x1)
        y1 = math.floor(y1)
        if x0 == x1 and y0 == y1 then
                ModImageSetPixel(overlay, x0, y0, color)
                return
        end
        local dx = math.abs(x1 - x0)
        local dy = math.abs(y1 - y0)
        local sx = x0 < x1 and 1 or -1
        local sy = y0 < y1 and 1 or -1
        local err = dx - dy

        while true do
                ModImageSetPixel(overlay, x0, y0, color)
                if x0 == x1 and y0 == y1 then break end
                local e2 = 2 * err
                if e2 > -dy then
                        err = err - dy
                        x0 = x0 + sx
                end
                if e2 < dx then
                        err = err + dx
                        y0 = y0 + sy
                end
        end
end

hilbertCurve = function(d, order)
        local n = 2 ^ order
        local maxIndex = n * n - 1
        local index = d * maxIndex

        local intIndex = math.floor(index)
        local fracIndex = index - intIndex

        local function rot(s, x, y, rx, ry)
                if ry == 0 then
                        if rx == 1 then
                                x = s - 1 - x
                                y = s - 1 - y
                        end

                        return y, x
                end
                return x, y
        end

        local function indexToXY(i)
                local x, y = 0, 0
                local s = 1

                while s < n do
                        local rx = bit.band(1, bit.rshift(i, 1))
                        local ry = bit.band(1, bit.bxor(i, rx))

                        x, y = rot(s, x, y, rx, ry)

                        x = x + s * rx
                        y = y + s * ry
                        i = bit.rshift(i, 2)
                        s = s * 2
                end

                return x, y
        end

        local x1, y1 = indexToXY(intIndex)
        local x2, y2 = indexToXY(math.min(intIndex + 1, maxIndex))

        local x = x1 + (x2 - x1) * fracIndex
        local y = y1 + (y2 - y1) * fracIndex

        x = x / (n - 1)
        y = y / (n - 1)

        return x, y
end

drawGraph = function(frameTime)

        local normalizedDuration = BENCH_FRAME / BENCH_DURATION

        local fps = 1 / frameTime
        local normalizedFps = math.min(fps / 60, 1)

        local x = BUFFER + (normalizedDuration * (OVERLAY_WIDTH - BUFFER * 2))
        local y = BUFFER + (normalizedFps * (OVERLAY_HEIGHT - BUFFER * 2))
        -- FPS
        drawLine(OVERLAY, LastX, LastY, x, y, 0xFF0024FF)
        drawText(OVERLAY, tostring(  math.floor(math.min(fps, 60) + 0.5)  ), OVERLAY_WIDTH / 2 - 9, OVERLAY_HEIGHT - BUFFER + 10, 3, 0xFFFFFFFF)

        LastX = x
        LastY = y

        GameSetPostFxTextureParameter("RBH_tex_overlay", "rbh_overlay.png", 2, 0, true)
end

local drawResult = function(maxBlackHoles)
        local x = BUFFER + ((maxBlackHoles / HARDCAP) * (OVERLAY_WIDTH - BUFFER * 2))
        local y1 = BUFFER
        local y2 = OVERLAY_HEIGHT - BUFFER
        drawLine(OVERLAY, x, y1, x, y2, 0xFFFFF97D)
        drawLine(OVERLAY, x + 1, y1, x + 1, y2, 0xFFFFF97D)
        drawText(OVERLAY, tostring(maxBlackHoles), x - 9, BUFFER - 20, 3, 0xFFFFF97D)
end

local placeBlackHoles = function()
        local normalizedDuration = BENCH_FRAME / BENCH_DURATION
        local blackHoles = math.ceil(HARDCAP * normalizedDuration)
        local size = 0.018
        local discs = SMALL_DISCS and blackHoles or 0
        GameSetPostFxParameter("RBH_count", blackHoles, blackHoles, discs, blackHoles)
        for i = 0, blackHoles - 1, 1 do
                local curvePos = (positions[i + 1] + normalizedDuration) % 1
                local x, y = hilbertCurve(curvePos, 3)
                x = ((x - 0.5) / 1.2) + 0.5
                y = ((y - 0.5) / 1.2) + 0.5
                x = x * 1.78
                GameSetPostFxParameter("RBH_" .. tostring(i), x, y, size, 0.0)
                GameSetPostFxParameter("RBH_DISC_" .. tostring(i), x, y, size, i)
        end
        return blackHoles
end

startBenchmark = function()
        GameSetPostFxParameter("RBH_max", HARDCAP, 0, 0, 0)
        initOverlay()
        BENCH_FRAME = -60
        Benchmarking = true

        -- Generate positions
        local points = {}
        for i = 0, HARDCAP - 1 do
                points[i + 1] = i / (HARDCAP)
        end

        -- Scramble
        math.randomseed(0)
        for i = HARDCAP, 2, -1 do
                local j = math.random(1, i)
                points[i], points[j] = points[j], points[i]
        end

        positions = points
end

runBenchmark = function(frameTime)
        local buttonText = GameTextGetTranslatedOrNot('$rbh_stop_bench') or "Stop Benchmark"
        if(button(buttonText)) then
                stopBenchmarkButton()
                return
        end

        drawGraph(frameTime)

        local count = placeBlackHoles()
        if maxFpsAvg[count] == nil then
                maxFpsAvg[count] = {}
        end
        table.insert(maxFpsAvg[count], 1 / frameTime)

        -- Early abort if under 30 fps
        if #maxFpsAvg[count] > 10 and 1 / frameTime < 30 then
                abortBenchmark()
        end
end

stopBenchmarkButton = function()
        GamePrint(GameTextGetTranslatedOrNot("$rbh_bench_cancel") or "Benchmark stopped.")
        endBenchmark()
end

abortBenchmark = function()
        GamePrint(GameTextGetTranslatedOrNot("$rbh_bench_abort") or "FPS dropped under 30, benchmark aborted!")
        endBenchmark()
end

endBenchmark = function()
        GamePrint("Ending Benchmark")
        showResults = true
        GameSetPostFxParameter("RBH_count", 0, 0, 0, 0)

        local averagedFPS = {}
        for k, v in pairs(maxFpsAvg) do
                local sum = 0
                for i = 1, #v, 1 do
                        sum = sum + v[i]
                end
                averagedFPS[k] = sum / #v
        end
        -- Find highest black hole count with average fps over 59
        local maxBlackHoles = 0
        for k, v in pairs(averagedFPS) do
                if v > 59 and k > maxBlackHoles then
                        maxBlackHoles = k
                end
        end

        maxBlackHoles = math.floor(math.min(maxBlackHoles, HARDCAP))
        drawResult(maxBlackHoles)

        local finishMessage = GameTextGetTranslatedOrNot('$rbh_max_set') or "Max black holes set to %s"
        finishMessage = finishMessage:format(tostring(maxBlackHoles))
        GamePrint(finishMessage)

        ModSettingSet('raytraced_black_holes.max_holes', maxBlackHoles)
        ModSettingSetNextValue('raytraced_black_holes.max_holes', maxBlackHoles, false)
        ModSettingSet('raytraced_black_holes.run_benchmark', false)
        ModSettingSetNextValue('raytraced_black_holes.run_benchmark', false, false)
end


run = function(frameTime)
        if(showResults) then
                local buttonText = GameTextGetTranslatedOrNot('$rbh_close') or "Close"
                if(button(buttonText)) then
                        clearOverlay()
                        Benchmarking = false
                        showResults = false
                end
        else
                if (BENCH_FRAME >= 0 and BENCH_FRAME < BENCH_DURATION) then
                        runBenchmark(frameTime)
                elseif (BENCH_FRAME >= BENCH_DURATION) then
                        endBenchmark()
                end
                BENCH_FRAME = BENCH_FRAME + 1
        end
end

return {
        run = run,
        startBenchmark = startBenchmark,
        createOverlay = createOverlay,
        clearOverlay = clearOverlay,
}
