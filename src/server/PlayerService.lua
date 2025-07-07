--[[
    👥 FASHION REVOLUTION - Player Service
    Service de gestion des joueurs côté serveur
]]

local PlayerService = {}

function PlayerService.Initialize()
    print("👥 Player Service initialized")
end

function PlayerService.OnPlayerAdded(player)
    print("👤 Player joined:", player.Name)
end

function PlayerService.OnPlayerRemoving(player)
    print("👋 Player leaving:", player.Name)
end

return PlayerService