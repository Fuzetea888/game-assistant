--[[
    🎮 FASHION REVOLUTION - Game Configuration
    Configuration partagée entre client et serveur
]]

local GameConfig = {}

-- 🎯 GAME MODES
GameConfig.GAME_MODES = {
    CLASSIC_ENHANCED = {
        Name = "Classic Enhanced",
        Duration = 360, -- 6 minutes
        MaxPlayers = 20,
        Rounds = 3,
        Features = {"AI_SUGGESTIONS", "CINEMATIC_CAMERA", "ENHANCED_VOTING"}
    },
    BATTLE_ROYALE = {
        Name = "Fashion Battle Royale",
        Duration = 900, -- 15 minutes
        MaxPlayers = 100,
        Rounds = 5,
        Features = {"ELIMINATION", "POWER_UPS", "TEAM_CHALLENGES"}
    },
    COLLABORATIVE = {
        Name = "Collaborative Creation",
        Duration = 600, -- 10 minutes
        MaxPlayers = 40,
        Teams = 8,
        Features = {"TEAM_VOTING", "SHARED_RESOURCES", "GROUP_THEMES"}
    }
}

-- 🎨 REVOLUTIONARY THEMES
GameConfig.THEMES = {
    "Cyberpunk Runway 2085",
    "Underwater Fashion Week",
    "Zero Gravity Couture",
    "Prehistoric Chic",
    "Quantum Fashion",
    "Steampunk Elegance",
    "Neon Dreams",
    "Crystal Palace Ball",
    "Robo-Fashion Show",
    "Mystical Forest Gala"
}

-- 🏆 TARGETS
GameConfig.TARGETS = {
    CONCURRENT_PLAYERS = 2000000,
    SESSION_DURATION = 75,
    RETENTION_30_DAY = 0.45,
    PREMIUM_CONVERSION = 0.30,
    CREATOR_REVENUE_SHARE = 0.70
}

-- 🎨 UI COLORS
GameConfig.COLORS = {
    PRIMARY = Color3.fromRGB(138, 43, 226),
    SECONDARY = Color3.fromRGB(255, 20, 147),
    ACCENT = Color3.fromRGB(0, 191, 255),
    SUCCESS = Color3.fromRGB(46, 204, 113),
    WARNING = Color3.fromRGB(241, 196, 15),
    ERROR = Color3.fromRGB(231, 76, 60)
}

return GameConfig