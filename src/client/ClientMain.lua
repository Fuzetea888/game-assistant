--[[
    🎮 FASHION REVOLUTION - Client Main
    Point d'entrée principal côté client
]]

-- 🎯 SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- 🎨 WAIT FOR MODULES
local Modules = ReplicatedStorage:WaitForChild("FashionRevolutionModules")
local UI = Modules:WaitForChild("UI")
local Shared = Modules:WaitForChild("Shared")

-- 📦 IMPORT MODULES
local UIDesignSystem = require(UI.UIDesignSystem)
local GameConfig = require(Shared.GameConfig)
local Constants = require(Shared.Constants)
local Utils = require(Shared.Utils)

-- 🎮 CLIENT CONTROLLER
local ClientMain = {}
ClientMain.__index = ClientMain

function ClientMain.new()
    local self = setmetatable({}, ClientMain)
    
    -- 🎯 CLIENT STATE
    self.Player = Players.LocalPlayer
    self.UISystem = nil
    self.InputController = nil
    self.CameraController = nil
    self.NetworkManager = nil
    
    -- 🎨 CLIENT DATA
    self.GameState = {
        IsInGame = false,
        CurrentTheme = nil,
        PlayerOutfit = {},
        VotingActive = false
    }
    
    -- 🚀 INITIALIZATION
    self:Initialize()
    
    return self
end

-- 🎨 CLIENT INITIALIZATION
function ClientMain:Initialize()
    print("🎮 Initializing Fashion Revolution Client for", self.Player.Name)
    
    -- ⏳ WAIT FOR CHARACTER
    if not self.Player.Character then
        self.Player.CharacterAdded:Wait()
    end
    
    -- 🎨 INITIALIZE UI SYSTEM
    self:InitializeUI()
    
    -- 🎯 SETUP INPUT HANDLING
    self:SetupInputHandling()
    
    -- 🌐 SETUP NETWORKING
    self:SetupNetworking()
    
    -- 📊 SETUP ANALYTICS
    self:SetupAnalytics()
    
    -- 🎪 SHOW WELCOME SCREEN
    self:ShowWelcomeScreen()
    
    print("✅ Fashion Revolution Client initialized successfully!")
end

-- 🎨 UI SYSTEM INITIALIZATION
function ClientMain:InitializeUI()
    print("🎨 Initializing client UI system...")
    
    -- 🎯 CREATE UI DESIGN SYSTEM
    self.UISystem = UIDesignSystem.new(self.Player)
    
    -- 🎪 CREATE MAIN INTERFACE
    self:CreateMainInterface()
    
    print("✅ Client UI system ready!")
end

-- 🎪 MAIN INTERFACE CREATION
function ClientMain:CreateMainInterface()
    -- 🎯 MAIN NAVIGATION
    local navbar = self.UISystem:CreateNavigationBar({
        Name = "MainNavigation",
        Items = {
            {Name = "Home", Text = "🏠 Home", Callback = function() self:ShowHomeScreen() end},
            {Name = "Create", Text = "🎨 Create", Callback = function() self:ShowCreationScreen() end},
            {Name = "Compete", Text = "🏆 Compete", Callback = function() self:ShowCompetitionScreen() end},
            {Name = "Shop", Text = "🛍️ Shop", Callback = function() self:ShowShopScreen() end},
            {Name = "Profile", Text = "👤 Profile", Callback = function() self:ShowProfileScreen() end}
        }
    })
    
    -- 🎨 GAME STATUS DISPLAY
    local statusCard = self.UISystem:CreateGlassCard({
        Name = "GameStatus",
        Size = UDim2.new(0, 300, 0, 100),
        Position = UDim2.new(1, -320, 0, 20)
    })
    
    -- ⏱️ TIMER DISPLAY
    local timerCard = self.UISystem:CreateGlassCard({
        Name = "GameTimer",
        Size = UDim2.new(0, 200, 0, 80),
        Position = UDim2.new(0.5, -100, 0, 20)
    })
end

-- 🎯 INPUT HANDLING SETUP
function ClientMain:SetupInputHandling()
    print("🎯 Setting up input handling...")
    
    -- 🖱️ MOUSE INPUT
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:OnMouseClick(input)
        elseif input.KeyCode == Enum.KeyCode.Escape then
            self:OnEscapePressed()
        elseif input.KeyCode == Enum.KeyCode.Tab then
            self:OnTabPressed()
        end
    end)
    
    -- 📱 TOUCH INPUT (Mobile)
    if UserInputService.TouchEnabled then
        self:SetupTouchInput()
    end
    
    print("✅ Input handling configured!")
end

-- 🌐 NETWORKING SETUP
function ClientMain:SetupNetworking()
    print("🌐 Setting up client networking...")
    
    -- 📡 REMOTE EVENTS
    local remoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
    
    -- 🎮 GAME EVENTS
    local gameEvents = remoteEvents:WaitForChild("GameEvents")
    gameEvents.OnClientEvent:Connect(function(eventType, data)
        self:HandleGameEvent(eventType, data)
    end)
    
    -- 👥 PLAYER EVENTS
    local playerEvents = remoteEvents:WaitForChild("PlayerEvents")
    playerEvents.OnClientEvent:Connect(function(eventType, data)
        self:HandlePlayerEvent(eventType, data)
    end)
    
    -- 🎨 UI EVENTS
    local uiEvents = remoteEvents:WaitForChild("UIEvents")
    uiEvents.OnClientEvent:Connect(function(eventType, data)
        self:HandleUIEvent(eventType, data)
    end)
    
    print("✅ Client networking configured!")
end

-- 📊 ANALYTICS SETUP
function ClientMain:SetupAnalytics()
    print("📊 Setting up client analytics...")
    
    -- 📈 TRACK CLIENT INITIALIZATION
    self:TrackEvent("ClientInitialized", {
        PlayerId = self.Player.UserId,
        PlayerName = self.Player.Name,
        DeviceType = self:DetectDeviceType(),
        Timestamp = tick()
    })
    
    -- ⏱️ SESSION TRACKING
    spawn(function()
        while true do
            wait(60) -- Every minute
            self:TrackSessionHeartbeat()
        end
    end)
    
    print("✅ Client analytics configured!")
end

-- 🌟 WELCOME SCREEN
function ClientMain:ShowWelcomeScreen()
    print("🌟 Showing welcome screen...")
    
    -- 🎉 WELCOME MODAL
    local welcomeModal, backdrop = self.UISystem:CreateModalDialog({
        Name = "WelcomeModal",
        Size = UDim2.new(0, 600, 0, 400)
    })
    
    -- 🎨 WELCOME CONTENT
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(1, -40, 0.6, 0)
    welcomeText.Position = UDim2.new(0, 20, 0, 20)
    welcomeText.BackgroundTransparency = 1
    welcomeText.Text = "🎉 Welcome to Fashion Revolution!\n\n" ..
                      "The ultimate fashion game successor!\n\n" ..
                      "🎨 AI-powered creation\n" ..
                      "🎬 Cinematic runways\n" ..
                      "👥 Social competition\n" ..
                      "💰 Creator economy"
    welcomeText.TextColor3 = GameConfig.COLORS.PRIMARY
    welcomeText.TextScaled = true
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Parent = welcomeModal
    
    -- 🎯 START BUTTON
    local startButton = self.UISystem:CreatePrimaryButton({
        Name = "StartButton",
        Text = "🚀 START PLAYING",
        Size = UDim2.new(0, 200, 0, 50),
        Position = UDim2.new(0.5, -100, 0.8, -25),
        Parent = welcomeModal
    })
    
    startButton.MouseButton1Click:Connect(function()
        self:StartGame()
        backdrop:Destroy()
    end)
end

-- 🎮 START GAME
function ClientMain:StartGame()
    print("🎮 Starting game for", self.Player.Name)
    
    -- 🎯 HIDE WELCOME SCREEN
    self:HideWelcomeScreen()
    
    -- 🎨 SHOW MAIN GAME UI
    self:ShowMainGameUI()
    
    -- 🌐 REQUEST GAME JOIN
    local remoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
    local gameEvents = remoteEvents:WaitForChild("GameEvents")
    gameEvents:FireServer("JoinGame", {})
    
    -- 📊 TRACK GAME START
    self:TrackEvent("GameStarted", {
        PlayerId = self.Player.UserId,
        Timestamp = tick()
    })
end

-- 🎨 MAIN GAME UI
function ClientMain:ShowMainGameUI()
    -- 🎪 CREATION INTERFACE
    self:ShowCreationInterface()
    
    -- 🏆 VOTING INTERFACE (Hidden initially)
    self:CreateVotingInterface()
    
    -- 📊 SCOREBOARD
    self:CreateScoreboard()
end

-- 🎨 CREATION INTERFACE
function ClientMain:ShowCreationInterface()
    local creationPanel = self.UISystem:CreateGlassCard({
        Name = "CreationPanel",
        Size = UDim2.new(0, 400, 0, 600),
        Position = UDim2.new(0, 20, 0.1, 0)
    })
    
    -- 🤖 AI ASSISTANT BUTTON
    local aiButton = self.UISystem:CreatePrimaryButton({
        Name = "AIAssistant",
        Text = "🤖 AI Assistant",
        Size = UDim2.new(0, 150, 0, 40),
        Position = UDim2.new(0, 20, 0, 20),
        Parent = creationPanel
    })
    
    aiButton.MouseButton1Click:Connect(function()
        self:ShowAIAssistant()
    end)
end

-- 🏆 VOTING INTERFACE
function ClientMain:CreateVotingInterface()
    local votingPanel = self.UISystem:CreateGlassCard({
        Name = "VotingPanel",
        Size = UDim2.new(0.8, 0, 0.7, 0),
        Position = UDim2.new(0.1, 0, 0.15, 0)
    })
    
    -- Initially hidden
    votingPanel.Visible = false
    self.VotingPanel = votingPanel
end

-- 📊 SCOREBOARD
function ClientMain:CreateScoreboard()
    local scoreboard = self.UISystem:CreateGlassCard({
        Name = "Scoreboard",
        Size = UDim2.new(0, 250, 0, 400),
        Position = UDim2.new(1, -270, 0.15, 0)
    })
    
    self.Scoreboard = scoreboard
end

-- 🎯 EVENT HANDLERS

-- 🎮 GAME EVENT HANDLER
function ClientMain:HandleGameEvent(eventType, data)
    if eventType == "ThemeRevealed" then
        self:OnThemeRevealed(data.theme)
    elseif eventType == "VotingStarted" then
        self:OnVotingStarted(data)
    elseif eventType == "GameEnded" then
        self:OnGameEnded(data)
    elseif eventType == "RoundStarted" then
        self:OnRoundStarted(data)
    end
end

-- 👥 PLAYER EVENT HANDLER
function ClientMain:HandlePlayerEvent(eventType, data)
    if eventType == "PlayerJoined" then
        self:OnPlayerJoined(data.player)
    elseif eventType == "PlayerLeft" then
        self:OnPlayerLeft(data.player)
    elseif eventType == "OutfitUpdated" then
        self:OnOutfitUpdated(data)
    end
end

-- 🎨 UI EVENT HANDLER
function ClientMain:HandleUIEvent(eventType, data)
    if eventType == "ShowNotification" then
        self:ShowNotification(data.message, data.type)
    elseif eventType == "UpdateTimer" then
        self:UpdateTimer(data.remaining)
    elseif eventType == "UpdateScores" then
        self:UpdateScoreboard(data.scores)
    end
end

-- 🎨 THEME REVEALED
function ClientMain:OnThemeRevealed(theme)
    print("🎨 Theme revealed:", theme)
    self.GameState.CurrentTheme = theme
    
    -- 🎪 SHOW THEME NOTIFICATION
    self:ShowNotification("Theme: " .. theme, "info")
    
    -- 🎯 UPDATE UI
    self:UpdateThemeDisplay(theme)
end

-- 🏆 VOTING STARTED
function ClientMain:OnVotingStarted(data)
    print("🏆 Voting started!")
    self.GameState.VotingActive = true
    
    -- 🎨 SHOW VOTING INTERFACE
    if self.VotingPanel then
        self.VotingPanel.Visible = true
    end
    
    -- 🎪 POPULATE OUTFITS
    self:PopulateVotingOutfits(data.outfits)
end

-- 🎉 GAME ENDED
function ClientMain:OnGameEnded(data)
    print("🎉 Game ended! Winner:", data.winner and data.winner.Name or "None")
    
    -- 🏆 SHOW RESULTS
    self:ShowGameResults(data)
    
    -- 📊 TRACK GAME END
    self:TrackEvent("GameEnded", {
        PlayerId = self.Player.UserId,
        Winner = data.winner and data.winner.Name or "None",
        Score = data.playerScore or 0,
        Timestamp = tick()
    })
end

-- 🛠️ UTILITY FUNCTIONS

-- 📱 DEVICE TYPE DETECTION
function ClientMain:DetectDeviceType()
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        return "Mobile"
    elseif UserInputService.GamepadEnabled then
        return "Console"
    else
        return "PC"
    end
end

-- 🎨 NOTIFICATION SYSTEM
function ClientMain:ShowNotification(message, notificationType)
    local backgroundColor = GameConfig.COLORS.SUCCESS
    local icon = "✅"
    
    if notificationType == "warning" then
        backgroundColor = GameConfig.COLORS.WARNING
        icon = "⚠️"
    elseif notificationType == "error" then
        backgroundColor = GameConfig.COLORS.ERROR
        icon = "❌"
    elseif notificationType == "info" then
        backgroundColor = GameConfig.COLORS.ACCENT
        icon = "ℹ️"
    end
    
    local toast = self.UISystem:CreateToastNotification({
        Message = message,
        Icon = icon,
        BackgroundColor = backgroundColor
    })
end

-- 📊 ANALYTICS TRACKING
function ClientMain:TrackEvent(eventName, eventData)
    -- In a real implementation, this would send to analytics service
    print("📊 Analytics:", eventName, eventData)
end

function ClientMain:TrackSessionHeartbeat()
    self:TrackEvent("SessionHeartbeat", {
        PlayerId = self.Player.UserId,
        SessionDuration = tick() - (self.SessionStartTime or tick()),
        IsInGame = self.GameState.IsInGame,
        Timestamp = tick()
    })
end

-- 🎯 PLACEHOLDER FUNCTIONS (to be implemented)
function ClientMain:HideWelcomeScreen() end
function ClientMain:ShowHomeScreen() end
function ClientMain:ShowCreationScreen() end
function ClientMain:ShowCompetitionScreen() end
function ClientMain:ShowShopScreen() end
function ClientMain:ShowProfileScreen() end
function ClientMain:ShowAIAssistant() end
function ClientMain:OnMouseClick() end
function ClientMain:OnEscapePressed() end
function ClientMain:OnTabPressed() end
function ClientMain:SetupTouchInput() end
function ClientMain:OnPlayerJoined() end
function ClientMain:OnPlayerLeft() end
function ClientMain:OnOutfitUpdated() end
function ClientMain:OnRoundStarted() end
function ClientMain:UpdateTimer() end
function ClientMain:UpdateScoreboard() end
function ClientMain:UpdateThemeDisplay() end
function ClientMain:PopulateVotingOutfits() end
function ClientMain:ShowGameResults() end

-- 🚀 AUTO-START
local client = ClientMain.new()

return ClientMain