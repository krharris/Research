-- Stuart Carnie, manomio | in retro we trust
-- These easing functions were derived from Sparrow / http://www.sparrow-framework.org (simplified BSD license)

--[[
local easingx  = require("easing")
 
transition.from(someObject, {
                time = 500,
                x = display.contentWidth,
                y = display.contentHeight,
                transition = easingx.easeInOutElastic })
--]]

local M = {}
 
local pow = math.pow
local sin = math.sin
local pi = math.pi
 
local easeIn, easeOut, easeInOut, easeOutIn
local easeInBack, easeOutBack, easeInOutBack, easeOutInBack
local easeInElastic, easeOutElastic, easeInOutElastic, easeOutInElastic
local easeInBounce, easeOutBounce, easeInOutBounce, easeOutInBounce
 
-- module exports
 
function M.easeIn(t, tMax, start, delta)
    return start + (delta * easeIn(t / tMax))
end
 
function M.easeOut(t, tMax, start, delta)
    return start + (delta * easeOut(t / tMax))
end
 
function M.easeInOut(t, tMax, start, delta)
    return start + (delta * easeInOut(t / tMax))
end
 
function M.easeOutIn(t, tMax, start, delta)
    return start + (delta * easeOutIn(t / tMax))
end
 
function M.easeInBack(t, tMax, start, delta)
    return start + (delta * easeInBack(t / tMax))
end
 
function M.easeOutBack(t, tMax, start, delta)
    return start + (delta * easeOutBack(t / tMax))
end
 
function M.easeInOutBack(t, tMax, start, delta)
    return start + (delta * easeInOutBack(t / tMax))
end
 
function M.easeOutInBack(t, tMax, start, delta)
    return start + (delta * easeOutInBack(t / tMax))
end
 
function M.easeInElastic(t, tMax, start, delta)
    return start + (delta * easeInElastic(t / tMax))
end
 
function M.easeOutElastic(t, tMax, start, delta)
    return start + (delta * easeOutElastic(t / tMax))
end
 
function M.easeInOutElastic(t, tMax, start, delta)
    return start + (delta * easeInOutElastic(t / tMax))
end
 
function M.easeOutInElastic(t, tMax, start, delta)
    return start + (delta * easeOutInElastic(t / tMax))
end
 
function M.easeInBounce(t, tMax, start, delta)
    return start + (delta * easeInBounce(t / tMax))
end
 
function M.easeOutBounce(t, tMax, start, delta)
    return start + (delta * easeOutBounce(t / tMax))
end
 
function M.easeInOutBounce(t, tMax, start, delta)
    return start + (delta * easeInOutBounce(t / tMax))
end
 
function M.easeOutInBounce(t, tMax, start, delta)
    return start + (delta * easeOutInBounce(t / tMax))
end
 
-- local easing functions
 
easeInBounce = function(ratio)
    return 1.0 - easeOutBounce(1.0 - ratio)
end
 
easeOutBounce = function(ratio)
    local s = 7.5625
    local p = 2.75
    local l
    if ratio < (1.0 / p) then
        l = s * pow(ratio, 2.0)
    else
        if ratio < (2.0 / p) then
            ratio = ratio - (1.5 / p)
            l = s * pow(ratio, 2.0) + 0.75
        else
            if ratio < (2.5 / p) then
                ratio = ratio - (2.25 / p)
                l = s * pow(ratio, 2.0) + 0.9375
            else
                ratio = ratio - (2.65 / p)
                l = s * pow(ratio, 2.0) + 0.984375
            end
        end
    end
    return l
end
 
easeInOutBounce = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeInBounce(ratio * 2.0)
    else
        return 0.5 * easeOutBounce((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutInBounce = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOutBounce(ratio * 2.0)
    else
        return 0.5 * easeInBounce((ratio - 0.5) * 2.0) + 0.5
    end
end
 
 
easeInElastic = function(ratio)
    if ratio == 0 or ratio == 1.0 then return ratio end
 
    local p = 0.3
    local s = p / 4.0
    local invRatio = ratio - 1.0
    return -1 * pow(2.0, 10.0 * invRatio) * sin((invRatio - s) * 2 * pi / p)
end
 
easeOutElastic = function(ratio)
    if ratio == 0 or ratio == 1.0 then return ratio end
 
    local p = 0.3
    local s = p / 4.0
    return -1 * pow(2.0, -10.0 * ratio) * sin((ratio + s) * 2 * pi / p) + 1.0
end
 
easeInOutElastic = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeInElastic(ratio * 2.0)
    else
        return 0.5 * easeOutElastic((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutInElastic = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOutElastic(ratio * 2.0)
    else
        return 0.5 * easeInElastic((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeIn = function(ratio)
    return ratio * ratio * ratio
end
 
easeOut = function(ratio)
    local invRatio = ratio - 1.0
    return (invRatio * invRatio * invRatio) + 1.0
end
 
easeInOut = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeIn(ratio * 2.0)
    else
        return 0.5 * easeOut((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutIn = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOut(ratio * 2.0)
    else
        return 0.5 * easeIn((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeInBack = function(ratio)
    local s = 1.70158
    return pow(ratio, 2.0) * ((s + 1.0) * ratio - s)
end
 
easeOutBack = function(ratio)
    local invRatio = ratio - 1.0
    local s = 1.70158
    return pow(invRatio, 2.0) * ((s + 1.0) * invRatio + s) + 1.0
end
 
easeInOutBack = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeInBack(ratio * 2.0)
    else
        return 0.5 * easeOutBack((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutInBack = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOutBack(ratio * 2.0)
    else
        return 0.5 * easeInBack((ratio - 0.5) * 2.0) + 0.5
    end
end
 
return M