--[[
    🛠️ FASHION REVOLUTION - Utilities
    Fonctions utilitaires partagées
]]

local Utils = {}

-- 🎯 MATH UTILITIES
function Utils.Lerp(a, b, t)
    return a + (b - a) * t
end

function Utils.Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function Utils.Round(number, decimals)
    local mult = 10^(decimals or 0)
    return math.floor(number * mult + 0.5) / mult
end

-- 🎨 COLOR UTILITIES
function Utils.ColorFromHex(hex)
    hex = hex:gsub("#", "")
    return Color3.fromRGB(
        tonumber("0x" .. hex:sub(1, 2)),
        tonumber("0x" .. hex:sub(3, 4)),
        tonumber("0x" .. hex:sub(5, 6))
    )
end

function Utils.LerpColor(color1, color2, t)
    return Color3.fromRGB(
        Utils.Lerp(color1.R * 255, color2.R * 255, t),
        Utils.Lerp(color1.G * 255, color2.G * 255, t),
        Utils.Lerp(color1.B * 255, color2.B * 255, t)
    )
end

-- 📝 STRING UTILITIES
function Utils.FormatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", minutes, secs)
end

function Utils.FormatNumber(number)
    if number >= 1000000 then
        return string.format("%.1fM", number / 1000000)
    elseif number >= 1000 then
        return string.format("%.1fK", number / 1000)
    else
        return tostring(number)
    end
end

-- 🎯 TABLE UTILITIES
function Utils.DeepCopy(orig)
    local copy
    if type(orig) == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Utils.DeepCopy(orig_key)] = Utils.DeepCopy(orig_value)
        end
        setmetatable(copy, Utils.DeepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function Utils.Shuffle(list)
    for i = #list, 2, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
    end
    return list
end

-- 🎮 GAME UTILITIES
function Utils.GetRandomTheme(themes)
    return themes[math.random(1, #themes)]
end

function Utils.CalculateScore(votes, multiplier)
    multiplier = multiplier or 1
    return Utils.Round(votes * multiplier, 2)
end

return Utils