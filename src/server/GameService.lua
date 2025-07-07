--[[
    🎮 FASHION REVOLUTION - Game Service
    Service principal du jeu côté serveur
]]

local GameService = {}

function GameService.Initialize()
    print("🎮 Game Service initialized")
end

function GameService.StartGame()
    print("🚀 Game started!")
end

function GameService.EndGame()
    print("🏁 Game ended!")
end

return GameService