--[[
    📋 FASHION REVOLUTION - Constants
    Constantes partagées du jeu
]]

local Constants = {}

-- 🎮 GAME CONSTANTS
Constants.GAME_VERSION = "1.0.0"
Constants.GAME_NAME = "Fashion Revolution"
Constants.DEFAULT_ROUND_DURATION = 360 -- 6 minutes
Constants.VOTING_DURATION = 60 -- 1 minute
Constants.MAX_PLAYERS_PER_SERVER = 100

-- 🎯 SCORING CONSTANTS
Constants.SCORING = {
    MAX_VOTE_VALUE = 5,
    MIN_VOTE_VALUE = 1,
    CREATIVITY_BONUS_MAX = 20,
    TIME_BONUS_MAX = 10,
    THEME_ACCURACY_MAX = 15
}

-- 🎨 UI CONSTANTS
Constants.UI = {
    ANIMATION_DURATION = 0.4,
    GLASS_TRANSPARENCY = 0.3,
    CORNER_RADIUS = 15,
    MOBILE_BREAKPOINT = 768,
    TABLET_BREAKPOINT = 1024
}

-- 🎪 RUNWAY CONSTANTS
Constants.RUNWAY = {
    LENGTH = 200,
    WIDTH = 20,
    HEIGHT = 1,
    POSE_SPOTS = 5,
    CAMERA_ANGLES = 8
}

-- 💰 ECONOMY CONSTANTS
Constants.ECONOMY = {
    CREATOR_REVENUE_SHARE = 0.70,
    PLATFORM_FEE = 0.20,
    PROCESSING_FEE = 0.10,
    MIN_PAYOUT = 100, -- Robux
    MAX_ASSET_PRICE = 10000 -- Robux
}

-- ✨ EFFECTS CONSTANTS
Constants.EFFECTS = {
    PARTICLE_BUDGET = 2000,
    MAX_EMITTERS = 50,
    PARTICLE_LIFETIME = 10,
    MAX_LIGHTS = 100
}

-- 🤖 AI CONSTANTS
Constants.AI = {
    NEURAL_NETWORK_LAYERS = 3,
    INPUT_NODES = 50,
    HIDDEN_NODES = 30,
    OUTPUT_NODES = 10,
    LEARNING_RATE = 0.01
}

-- 📊 ANALYTICS CONSTANTS
Constants.ANALYTICS = {
    SESSION_TIMEOUT = 1800, -- 30 minutes
    BATCH_SIZE = 100,
    UPLOAD_INTERVAL = 300, -- 5 minutes
    MAX_EVENTS_CACHE = 1000
}

return Constants