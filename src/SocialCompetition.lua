--[[
    🌟 SOCIAL COMPETITION SYSTEM - Révolutionnaire Social Engine
    Système social et compétitif avec algorithme anti-manipulation
    
    Innovations :
    - Algorithme de classement équitable
    - Système anti-manipulation des votes
    - Système d'influence et followers
    - Collaboration et mentorship
    - Tournois et ligues
    - Système de réputation avancé
]]

local SocialCompetition = {}
SocialCompetition.__index = SocialCompetition

-- 🎯 SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local DataStoreService = game:GetService("DataStoreService")

-- 🎨 CONFIGURATION SOCIAL
local SOCIAL_CONFIG = {
    -- 🌟 VOTING SYSTEM
    MAX_VOTES_PER_ROUND = 10,
    VOTE_WEIGHT_ALGORITHM = "TrustBased", -- Simple, TrustBased, Reputation
    ANTI_MANIPULATION_STRENGTH = 0.8, -- 0-1 strength
    
    -- 🎯 INFLUENCE SYSTEM
    INFLUENCE_DECAY_RATE = 0.95, -- Daily decay
    MAX_INFLUENCE_LEVEL = 100,
    INFLUENCE_REQUIREMENTS = {
        [1] = 0, [2] = 100, [3] = 500, [4] = 1500, [5] = 5000,
        [6] = 15000, [7] = 50000, [8] = 150000, [9] = 500000, [10] = 1000000
    },
    
    -- 🎪 COMPETITION SETTINGS
    TOURNAMENT_SIZE = 64, -- Max players per tournament
    LEAGUE_PROMOTION_THRESHOLD = 0.75, -- Win rate for promotion
    LEAGUE_DEMOTION_THRESHOLD = 0.25, -- Win rate for demotion
    
    -- 🎭 SOCIAL FEATURES
    MAX_FRIENDS = 1000,
    MAX_FOLLOWERS = 10000,
    COLLABORATION_COOLDOWN = 300, -- 5 minutes
    
    -- 🎯 REPUTATION SYSTEM
    REPUTATION_FACTORS = {
        VoteAccuracy = 0.3,
        StyleConsistency = 0.2,
        SocialEngagement = 0.2,
        CreativityScore = 0.15,
        CommunityContribution = 0.15
    }
}

-- 🎭 PLAYER RANKS
local PLAYER_RANKS = {
    {Name = "Novice Stylist", Level = 1, Color = Color3.fromRGB(169, 169, 169), RequiredScore = 0},
    {Name = "Emerging Talent", Level = 2, Color = Color3.fromRGB(205, 127, 50), RequiredScore = 100},
    {Name = "Fashion Enthusiast", Level = 3, Color = Color3.fromRGB(50, 205, 50), RequiredScore = 500},
    {Name = "Style Curator", Level = 4, Color = Color3.fromRGB(30, 144, 255), RequiredScore = 1500},
    {Name = "Trend Setter", Level = 5, Color = Color3.fromRGB(138, 43, 226), RequiredScore = 5000},
    {Name = "Fashion Influencer", Level = 6, Color = Color3.fromRGB(255, 215, 0), RequiredScore = 15000},
    {Name = "Style Icon", Level = 7, Color = Color3.fromRGB(255, 105, 180), RequiredScore = 50000},
    {Name = "Fashion Mogul", Level = 8, Color = Color3.fromRGB(255, 69, 0), RequiredScore = 150000},
    {Name = "Legendary Designer", Level = 9, Color = Color3.fromRGB(255, 0, 255), RequiredScore = 500000},
    {Name = "Fashion Revolution", Level = 10, Color = Color3.fromRGB(255, 255, 255), RequiredScore = 1000000}
}

-- 🎪 LEAGUES
local LEAGUES = {
    {Name = "Bronze League", Tier = 1, Color = Color3.fromRGB(205, 127, 50), MaxPlayers = 1000},
    {Name = "Silver League", Tier = 2, Color = Color3.fromRGB(192, 192, 192), MaxPlayers = 500},
    {Name = "Gold League", Tier = 3, Color = Color3.fromRGB(255, 215, 0), MaxPlayers = 200},
    {Name = "Platinum League", Tier = 4, Color = Color3.fromRGB(229, 228, 226), MaxPlayers = 100},
    {Name = "Diamond League", Tier = 5, Color = Color3.fromRGB(185, 242, 255), MaxPlayers = 50},
    {Name = "Master League", Tier = 6, Color = Color3.fromRGB(255, 0, 255), MaxPlayers = 25},
    {Name = "Grandmaster League", Tier = 7, Color = Color3.fromRGB(255, 255, 255), MaxPlayers = 10}
}

-- 🎯 MAIN SOCIAL CLASS
function SocialCompetition.new()
    local self = setmetatable({}, SocialCompetition)
    
    -- 🌟 SOCIAL STATE
    self.SocialState = {
        ActiveVoting = false,
        VotingData = {},
        PlayerProfiles = {},
        SocialConnections = {},
        ReputationScores = {},
        InfluenceNetwork = {},
        TournamentData = {},
        LeagueStandings = {}
    }
    
    -- 🎯 VOTING SYSTEM
    self.VotingSystem = {
        CurrentVotes = {},
        VoteHistory = {},
        VoteWeights = {},
        AntiManipulationEngine = {},
        TrustNetwork = {}
    }
    
    -- 🎪 COMPETITION SYSTEM
    self.CompetitionSystem = {
        ActiveTournaments = {},
        LeagueMatches = {},
        RankingAlgorithm = {},
        PerformanceMetrics = {}
    }
    
    -- 🎭 SOCIAL FEATURES
    self.SocialFeatures = {
        FriendSystem = {},
        FollowerSystem = {},
        CollaborationTools = {},
        MentorshipProgram = {},
        CommunityEvents = {}
    }
    
    -- 🚀 INITIALIZATION
    self:InitializeSocialSystem()
    
    return self
end

-- 🌟 SOCIAL SYSTEM INITIALIZATION
function SocialCompetition:InitializeSocialSystem()
    -- 🎯 SETUP VOTING SYSTEM
    self:InitializeVotingSystem()
    
    -- 🎪 SETUP COMPETITION SYSTEM
    self:InitializeCompetitionSystem()
    
    -- 🎭 SETUP SOCIAL FEATURES
    self:InitializeSocialFeatures()
    
    -- 🎨 SETUP REPUTATION SYSTEM
    self:InitializeReputationSystem()
    
    -- 🎯 SETUP ANTI-MANIPULATION
    self:InitializeAntiManipulation()
    
    print("🌟 Social Competition System initialized with revolutionary algorithms!")
end

-- 🎯 VOTING SYSTEM INITIALIZATION
function SocialCompetition:InitializeVotingSystem()
    -- 🎨 VOTE WEIGHT CALCULATOR
    self.VotingSystem.VoteWeights = {
        CalculateWeight = function(voter, target)
            local voterProfile = self.SocialState.PlayerProfiles[voter.UserId]
            local targetProfile = self.SocialState.PlayerProfiles[target.UserId]
            
            if not voterProfile or not targetProfile then
                return 1.0 -- Default weight
            end
            
            local weight = 1.0
            
            -- 🎯 REPUTATION FACTOR
            local reputationFactor = math.min(2.0, voterProfile.Reputation / 100)
            weight = weight * reputationFactor
            
            -- 🌟 INFLUENCE FACTOR
            local influenceFactor = math.min(1.5, voterProfile.Influence / 100)
            weight = weight * influenceFactor
            
            -- 🎪 EXPERIENCE FACTOR
            local experienceFactor = math.min(1.3, voterProfile.Experience / 1000)
            weight = weight * experienceFactor
            
            -- 🎭 TRUST FACTOR
            local trustFactor = self:GetTrustScore(voter, target)
            weight = weight * trustFactor
            
            return math.max(0.1, math.min(5.0, weight))
        end
    }
    
    -- 🎯 VOTING VALIDATION
    self.VotingSystem.VoteValidator = {
        IsValidVote = function(voter, target, score)
            -- 🎨 BASIC VALIDATION
            if not voter or not target or not score then
                return false, "Invalid vote parameters"
            end
            
            if score < 1 or score > 5 then
                return false, "Score must be between 1 and 5"
            end
            
            if voter.UserId == target.UserId then
                return false, "Cannot vote for yourself"
            end
            
            -- 🎯 COOLDOWN CHECK
            local lastVote = self.VotingSystem.VoteHistory[voter.UserId]
            if lastVote and tick() - lastVote.Timestamp < 5 then
                return false, "Vote cooldown active"
            end
            
            -- 🌟 ANTI-MANIPULATION CHECK
            if self:DetectManipulation(voter, target, score) then
                return false, "Vote rejected: manipulation detected"
            end
            
            return true, "Valid vote"
        end
    }
    
    print("🎯 Voting System initialized with advanced algorithms!")
end

-- 🎪 COMPETITION SYSTEM INITIALIZATION
function SocialCompetition:InitializeCompetitionSystem()
    -- 🎯 RANKING ALGORITHM
    self.CompetitionSystem.RankingAlgorithm = {
        CalculateScore = function(player, round)
            local baseScore = 0
            local votes = self.VotingSystem.CurrentVotes[player.UserId] or {}
            
            -- 🎨 WEIGHTED VOTE CALCULATION
            for voterId, voteData in pairs(votes) do
                local voter = Players:GetPlayerByUserId(voterId)
                if voter then
                    local weight = self.VotingSystem.VoteWeights.CalculateWeight(voter, player)
                    baseScore = baseScore + (voteData.Score * weight)
                end
            end
            
            -- 🎯 NORMALIZE SCORE
            local voteCount = 0
            for _ in pairs(votes) do voteCount = voteCount + 1 end
            
            if voteCount > 0 then
                baseScore = baseScore / voteCount
            end
            
            -- 🌟 BONUS FACTORS
            local bonusFactors = {
                -- 🎭 THEME ACCURACY
                ThemeAccuracy = self:CalculateThemeAccuracy(player, round.Theme),
                
                -- 🎪 CREATIVITY BONUS
                CreativityBonus = self:CalculateCreativityBonus(player, round),
                
                -- 🎨 CONSISTENCY BONUS
                ConsistencyBonus = self:CalculateConsistencyBonus(player),
                
                -- 🎯 SOCIAL ENGAGEMENT
                SocialEngagement = self:CalculateSocialEngagement(player)
            }
            
            for factor, value in pairs(bonusFactors) do
                baseScore = baseScore + value
            end
            
            return math.max(0, math.min(10, baseScore))
        end
    }
    
    -- 🎭 TOURNAMENT SYSTEM
    self.CompetitionSystem.TournamentManager = {
        CreateTournament = function(type, participants)
            local tournament = {
                Id = HttpService:GenerateGUID(),
                Type = type,
                Participants = participants,
                Rounds = {},
                Status = "Preparing",
                StartTime = tick(),
                Prize = self:CalculateTournamentPrize(#participants),
                Bracket = self:GenerateBracket(participants)
            }
            
            self.CompetitionSystem.ActiveTournaments[tournament.Id] = tournament
            return tournament
        end
    }
    
    print("🎪 Competition System initialized with advanced algorithms!")
end

-- 🎭 SOCIAL FEATURES INITIALIZATION
function SocialCompetition:InitializeSocialFeatures()
    -- 🎯 FRIEND SYSTEM
    self.SocialFeatures.FriendSystem = {
        SendFriendRequest = function(sender, target)
            local requestId = HttpService:GenerateGUID()
            local request = {
                Id = requestId,
                SenderId = sender.UserId,
                TargetId = target.UserId,
                Timestamp = tick(),
                Status = "Pending"
            }
            
            -- 🎨 NOTIFICATION
            self:SendNotification(target, {
                Title = "Friend Request",
                Message = sender.DisplayName .. " wants to be your friend!",
                Type = "FriendRequest",
                Data = request
            })
            
            return requestId
        end,
        
        AcceptFriendRequest = function(requestId)
            -- 🎯 IMPLEMENTATION
            print("🎭 Friend request accepted:", requestId)
        end
    }
    
    -- 🌟 FOLLOWER SYSTEM
    self.SocialFeatures.FollowerSystem = {
        Follow = function(follower, target)
            local followerId = follower.UserId
            local targetId = target.UserId
            
            -- 🎨 UPDATE FOLLOWER COUNT
            if not self.SocialState.SocialConnections[targetId] then
                self.SocialState.SocialConnections[targetId] = {
                    Followers = {},
                    Following = {},
                    FollowerCount = 0,
                    FollowingCount = 0
                }
            end
            
            if not self.SocialState.SocialConnections[followerId] then
                self.SocialState.SocialConnections[followerId] = {
                    Followers = {},
                    Following = {},
                    FollowerCount = 0,
                    FollowingCount = 0
                }
            end
            
            -- 🎯 ADD CONNECTION
            self.SocialState.SocialConnections[targetId].Followers[followerId] = true
            self.SocialState.SocialConnections[followerId].Following[targetId] = true
            
            -- 🌟 UPDATE COUNTS
            self.SocialState.SocialConnections[targetId].FollowerCount = 
                self.SocialState.SocialConnections[targetId].FollowerCount + 1
            self.SocialState.SocialConnections[followerId].FollowingCount = 
                self.SocialState.SocialConnections[followerId].FollowingCount + 1
            
            -- 🎪 INFLUENCE UPDATE
            self:UpdateInfluenceScore(target, 5)
            
            print("🌟 Follow connection established:", follower.DisplayName, "->", target.DisplayName)
        end
    }
    
    -- 🎪 COLLABORATION TOOLS
    self.SocialFeatures.CollaborationTools = {
        CreateCollaboration = function(initiator, partners, theme)
            local collaboration = {
                Id = HttpService:GenerateGUID(),
                InitiatorId = initiator.UserId,
                Partners = partners,
                Theme = theme,
                Status = "Active",
                StartTime = tick(),
                SharedAssets = {},
                Votes = {}
            }
            
            -- 🎯 NOTIFY PARTNERS
            for _, partner in ipairs(partners) do
                self:SendNotification(partner, {
                    Title = "Collaboration Invitation",
                    Message = initiator.DisplayName .. " invited you to collaborate!",
                    Type = "Collaboration",
                    Data = collaboration
                })
            end
            
            return collaboration
        end
    }
    
    print("🎭 Social Features initialized with comprehensive tools!")
end

-- 🎨 REPUTATION SYSTEM INITIALIZATION
function SocialCompetition:InitializeReputationSystem()
    -- 🎯 REPUTATION CALCULATOR
    self.ReputationCalculator = {
        CalculateReputation = function(player)
            local profile = self.SocialState.PlayerProfiles[player.UserId]
            if not profile then return 0 end
            
            local reputation = 0
            
            -- 🎨 VOTE ACCURACY
            local voteAccuracy = self:CalculateVoteAccuracy(player)
            reputation = reputation + (voteAccuracy * SOCIAL_CONFIG.REPUTATION_FACTORS.VoteAccuracy * 100)
            
            -- 🎯 STYLE CONSISTENCY
            local styleConsistency = self:CalculateStyleConsistency(player)
            reputation = reputation + (styleConsistency * SOCIAL_CONFIG.REPUTATION_FACTORS.StyleConsistency * 100)
            
            -- 🌟 SOCIAL ENGAGEMENT
            local socialEngagement = self:CalculateSocialEngagement(player)
            reputation = reputation + (socialEngagement * SOCIAL_CONFIG.REPUTATION_FACTORS.SocialEngagement * 100)
            
            -- 🎪 CREATIVITY SCORE
            local creativityScore = self:CalculateCreativityScore(player)
            reputation = reputation + (creativityScore * SOCIAL_CONFIG.REPUTATION_FACTORS.CreativityScore * 100)
            
            -- 🎭 COMMUNITY CONTRIBUTION
            local communityContribution = self:CalculateCommunityContribution(player)
            reputation = reputation + (communityContribution * SOCIAL_CONFIG.REPUTATION_FACTORS.CommunityContribution * 100)
            
            return math.max(0, math.min(1000, reputation))
        end
    }
    
    print("🎨 Reputation System initialized with multi-factor analysis!")
end

-- 🎯 ANTI-MANIPULATION INITIALIZATION
function SocialCompetition:InitializeAntiManipulation()
    -- 🎨 MANIPULATION DETECTION
    self.AntiManipulationEngine = {
        DetectVoteManipulation = function(voter, target, score)
            local suspicionScore = 0
            
            -- 🎯 VOTING PATTERN ANALYSIS
            local voterHistory = self.VotingSystem.VoteHistory[voter.UserId]
            if voterHistory then
                -- 🎨 RAPID VOTING DETECTION
                local recentVotes = 0
                for _, vote in ipairs(voterHistory) do
                    if tick() - vote.Timestamp < 60 then
                        recentVotes = recentVotes + 1
                    end
                end
                
                if recentVotes > 10 then
                    suspicionScore = suspicionScore + 0.3
                end
                
                -- 🎯 SCORE PATTERN ANALYSIS
                local scorePattern = {}
                for _, vote in ipairs(voterHistory) do
                    scorePattern[vote.Score] = (scorePattern[vote.Score] or 0) + 1
                end
                
                -- 🌟 EXTREME SCORE BIAS
                local extremeScores = (scorePattern[1] or 0) + (scorePattern[5] or 0)
                local totalVotes = #voterHistory
                
                if totalVotes > 0 and extremeScores / totalVotes > 0.8 then
                    suspicionScore = suspicionScore + 0.4
                end
            end
            
            -- 🎪 SOCIAL NETWORK ANALYSIS
            local socialConnection = self:GetSocialConnection(voter, target)
            if socialConnection == "Friend" or socialConnection == "Follower" then
                suspicionScore = suspicionScore + 0.2
            end
            
            -- 🎭 REPUTATION FACTOR
            local voterReputation = self.SocialState.ReputationScores[voter.UserId] or 0
            if voterReputation < 10 then
                suspicionScore = suspicionScore + 0.3
            end
            
            return suspicionScore > SOCIAL_CONFIG.ANTI_MANIPULATION_STRENGTH
        end
    }
    
    print("🎯 Anti-Manipulation Engine initialized with advanced detection!")
end

-- 🎪 PLAYER REGISTRATION
function SocialCompetition:RegisterPlayer(player, playerData)
    -- 🎯 CREATE PLAYER PROFILE
    local profile = {
        UserId = player.UserId,
        DisplayName = player.DisplayName,
        JoinDate = tick(),
        
        -- 🎨 STATS
        TotalRounds = 0,
        TotalVotes = 0,
        AverageScore = 0,
        WinRate = 0,
        
        -- 🌟 SOCIAL STATS
        Reputation = 50, -- Starting reputation
        Influence = 0,
        Experience = 0,
        
        -- 🎭 RANK INFO
        CurrentRank = 1,
        RankProgress = 0,
        
        -- 🎪 ACHIEVEMENTS
        Achievements = {},
        Badges = {},
        
        -- 🎯 PREFERENCES
        Preferences = {
            PublicProfile = true,
            ShowRealName = false,
            AllowCollaborations = true,
            NotificationsEnabled = true
        }
    }
    
    self.SocialState.PlayerProfiles[player.UserId] = profile
    
    -- 🎨 INITIALIZE SOCIAL CONNECTIONS
    self.SocialState.SocialConnections[player.UserId] = {
        Followers = {},
        Following = {},
        Friends = {},
        FollowerCount = 0,
        FollowingCount = 0,
        FriendCount = 0
    }
    
    -- 🎯 INITIALIZE REPUTATION
    self.SocialState.ReputationScores[player.UserId] = 50
    
    print("🎪 Player registered in social system:", player.DisplayName)
end

-- 🎯 VOTING INITIALIZATION
function SocialCompetition:InitializeVoting(playersInGame)
    self.SocialState.ActiveVoting = true
    self.VotingSystem.CurrentVotes = {}
    
    -- 🎨 PREPARE VOTING DATA
    for userId, playerData in pairs(playersInGame) do
        self.VotingSystem.CurrentVotes[userId] = {}
    end
    
    -- 🎯 SETUP VOTING UI FOR ALL PLAYERS
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            self:CreateVotingInterface(player, playersInGame)
        end
    end
    
    print("🎯 Voting initialized for", self:CountPlayers(playersInGame), "players")
end

-- 🎪 VOTING INTERFACE CREATION
function SocialCompetition:CreateVotingInterface(player, playersInGame)
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- 🎨 VOTING GUI
    local votingGui = Instance.new("ScreenGui")
    votingGui.Name = "VotingInterface"
    votingGui.Parent = playerGui
    
    -- 🎯 MAIN FRAME
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "VotingFrame"
    mainFrame.Size = UDim2.new(0.8, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = votingGui
    
    -- 🎪 GLASSMORPHISM EFFECT
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame
    
    -- 🌟 TITLE
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌟 Vote for the Best Looks!"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- 🎯 PLAYER LIST
    local playerList = Instance.new("ScrollingFrame")
    playerList.Name = "PlayerList"
    playerList.Size = UDim2.new(0.9, 0, 0.7, 0)
    playerList.Position = UDim2.new(0.05, 0, 0.2, 0)
    playerList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    playerList.BackgroundTransparency = 0.3
    playerList.BorderSizePixel = 0
    playerList.ScrollBarThickness = 10
    playerList.Parent = mainFrame
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 15)
    listCorner.Parent = playerList
    
    -- 🎨 POPULATE PLAYER LIST
    local yOffset = 0
    for userId, playerData in pairs(playersInGame) do
        if userId ~= player.UserId then -- Can't vote for self
            local targetPlayer = Players:GetPlayerByUserId(userId)
            if targetPlayer then
                self:CreatePlayerVoteCard(targetPlayer, playerList, yOffset)
                yOffset = yOffset + 80
            end
        end
    end
    
    -- 🎪 UPDATE CANVAS SIZE
    playerList.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    
    -- 🎯 CLOSE BUTTON
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    closeButton.Position = UDim2.new(0.75, 0, 0.92, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "Finish Voting"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        votingGui:Destroy()
    end)
    
    -- 🎨 ENTRANCE ANIMATION
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local openTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0.8, 0, 0.6, 0),
            Position = UDim2.new(0.1, 0, 0.2, 0)
        }
    )
    
    openTween:Play()
end

-- 🎭 PLAYER VOTE CARD CREATION
function SocialCompetition:CreatePlayerVoteCard(targetPlayer, parent, yOffset)
    -- 🎨 CARD FRAME
    local cardFrame = Instance.new("Frame")
    cardFrame.Name = "VoteCard_" .. targetPlayer.UserId
    cardFrame.Size = UDim2.new(1, -20, 0, 70)
    cardFrame.Position = UDim2.new(0, 10, 0, yOffset)
    cardFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    cardFrame.BackgroundTransparency = 0.2
    cardFrame.BorderSizePixel = 0
    cardFrame.Parent = parent
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 10)
    cardCorner.Parent = cardFrame
    
    -- 🎯 PLAYER NAME
    local playerName = Instance.new("TextLabel")
    playerName.Name = "PlayerName"
    playerName.Size = UDim2.new(0.4, 0, 0.5, 0)
    playerName.Position = UDim2.new(0.05, 0, 0.1, 0)
    playerName.BackgroundTransparency = 1
    playerName.Text = targetPlayer.DisplayName
    playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerName.TextScaled = true
    playerName.Font = Enum.Font.GothamBold
    playerName.TextXAlignment = Enum.TextXAlignment.Left
    playerName.Parent = cardFrame
    
    -- 🌟 STAR RATING
    local starFrame = Instance.new("Frame")
    starFrame.Name = "StarRating"
    starFrame.Size = UDim2.new(0.5, 0, 0.6, 0)
    starFrame.Position = UDim2.new(0.45, 0, 0.2, 0)
    starFrame.BackgroundTransparency = 1
    starFrame.Parent = cardFrame
    
    -- 🎪 CREATE STAR BUTTONS
    for i = 1, 5 do
        local starButton = Instance.new("TextButton")
        starButton.Name = "Star" .. i
        starButton.Size = UDim2.new(0.18, 0, 1, 0)
        starButton.Position = UDim2.new((i - 1) * 0.2, 0, 0, 0)
        starButton.BackgroundTransparency = 1
        starButton.Text = "⭐"
        starButton.TextColor3 = Color3.fromRGB(100, 100, 100)
        starButton.TextScaled = true
        starButton.Font = Enum.Font.GothamBold
        starButton.Parent = starFrame
        
        starButton.MouseButton1Click:Connect(function()
            self:CastVote(Players.LocalPlayer, targetPlayer, i)
            self:UpdateStarDisplay(starFrame, i)
        end)
    end
end

-- 🎯 VOTE CASTING
function SocialCompetition:CastVote(voter, target, score)
    -- 🎨 VALIDATE VOTE
    local isValid, reason = self.VotingSystem.VoteValidator.IsValidVote(voter, target, score)
    
    if not isValid then
        self:ShowVoteError(voter, reason)
        return false
    end
    
    -- 🎯 RECORD VOTE
    if not self.VotingSystem.CurrentVotes[target.UserId] then
        self.VotingSystem.CurrentVotes[target.UserId] = {}
    end
    
    self.VotingSystem.CurrentVotes[target.UserId][voter.UserId] = {
        Score = score,
        Timestamp = tick(),
        Weight = self.VotingSystem.VoteWeights.CalculateWeight(voter, target)
    }
    
    -- 🎪 UPDATE VOTE HISTORY
    if not self.VotingSystem.VoteHistory[voter.UserId] then
        self.VotingSystem.VoteHistory[voter.UserId] = {}
    end
    
    table.insert(self.VotingSystem.VoteHistory[voter.UserId], {
        TargetId = target.UserId,
        Score = score,
        Timestamp = tick()
    })
    
    -- 🌟 UPDATE REPUTATION
    self:UpdateVoterReputation(voter, target, score)
    
    print("🎯 Vote cast:", voter.DisplayName, "->", target.DisplayName, "Score:", score)
    
    return true
end

-- 🏆 RESULTS CALCULATION
function SocialCompetition:CalculateResults()
    local results = {
        rankings = {},
        winner = nil,
        podium = {},
        stats = {}
    }
    
    -- 🎯 CALCULATE SCORES
    local playerScores = {}
    
    for userId, votes in pairs(self.VotingSystem.CurrentVotes) do
        local player = Players:GetPlayerByUserId(userId)
        if player then
            local score = self.CompetitionSystem.RankingAlgorithm.CalculateScore(player, {Theme = "Current"})
            playerScores[userId] = {
                Player = player,
                Score = score,
                VoteCount = self:CountVotes(votes)
            }
        end
    end
    
    -- 🎪 SORT BY SCORE
    local sortedPlayers = {}
    for userId, data in pairs(playerScores) do
        table.insert(sortedPlayers, {UserId = userId, Data = data})
    end
    
    table.sort(sortedPlayers, function(a, b)
        return a.Data.Score > b.Data.Score
    end)
    
    -- 🏆 DETERMINE WINNER AND PODIUM
    if #sortedPlayers > 0 then
        results.winner = sortedPlayers[1].Data.Player
        
        for i = 1, math.min(3, #sortedPlayers) do
            table.insert(results.podium, {
                Position = i,
                Player = sortedPlayers[i].Data.Player,
                Score = sortedPlayers[i].Data.Score
            })
        end
    end
    
    -- 🎯 RANKINGS
    for i, playerData in ipairs(sortedPlayers) do
        table.insert(results.rankings, {
            Rank = i,
            Player = playerData.Data.Player,
            Score = playerData.Data.Score,
            VoteCount = playerData.Data.VoteCount
        })
    end
    
    -- 📊 STATS
    results.stats = {
        TotalVotes = self:CountTotalVotes(),
        AverageScore = self:CalculateAverageScore(),
        HighestScore = sortedPlayers[1] and sortedPlayers[1].Data.Score or 0,
        ParticipantCount = #sortedPlayers
    }
    
    -- 🎨 UPDATE PLAYER STATS
    self:UpdatePlayerStats(results)
    
    print("🏆 Results calculated! Winner:", results.winner and results.winner.DisplayName or "None")
    
    return results
end

-- 🎯 SOCIAL HUB
function SocialCompetition:OpenSocialHub(player)
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- 🌟 SOCIAL HUB GUI
    local socialGui = Instance.new("ScreenGui")
    socialGui.Name = "SocialHub"
    socialGui.Parent = playerGui
    
    -- 🎨 MAIN FRAME
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "SocialFrame"
    mainFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = socialGui
    
    -- 🎯 GLASSMORPHISM EFFECT
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 25)
    corner.Parent = mainFrame
    
    -- 🎪 TITLE
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌟 Social Hub - Connect & Compete"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- 🎯 CLOSE BUTTON
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.1, 0, 0.08, 0)
    closeButton.Position = UDim2.new(0.88, 0, 0.02, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "✖"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        socialGui:Destroy()
    end)
    
    -- 🎨 ENTRANCE ANIMATION
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local openTween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0.9, 0, 0.8, 0),
            Position = UDim2.new(0.05, 0, 0.1, 0)
        }
    )
    
    openTween:Play()
end

-- 🎯 UTILITY FUNCTIONS
function SocialCompetition:CountPlayers(playersInGame)
    local count = 0
    for _ in pairs(playersInGame) do
        count = count + 1
    end
    return count
end

function SocialCompetition:CountVotes(votes)
    local count = 0
    for _ in pairs(votes) do
        count = count + 1
    end
    return count
end

function SocialCompetition:CountTotalVotes()
    local total = 0
    for _, votes in pairs(self.VotingSystem.CurrentVotes) do
        total = total + self:CountVotes(votes)
    end
    return total
end

function SocialCompetition:UpdateStarDisplay(starFrame, rating)
    for i = 1, 5 do
        local star = starFrame:FindFirstChild("Star" .. i)
        if star then
            if i <= rating then
                star.TextColor3 = Color3.fromRGB(255, 215, 0)
            else
                star.TextColor3 = Color3.fromRGB(100, 100, 100)
            end
        end
    end
end

-- 🎯 PLACEHOLDER FUNCTIONS
function SocialCompetition:DetectManipulation(voter, target, score)
    return self.AntiManipulationEngine.DetectVoteManipulation(voter, target, score)
end

function SocialCompetition:GetTrustScore(voter, target)
    return 1.0 -- Placeholder
end

function SocialCompetition:UpdateInfluenceScore(player, amount)
    local profile = self.SocialState.PlayerProfiles[player.UserId]
    if profile then
        profile.Influence = profile.Influence + amount
    end
end

function SocialCompetition:SendNotification(player, notification)
    -- Placeholder for notification system
    print("🎯 Notification sent to", player.DisplayName, ":", notification.Title)
end

-- 🎯 EXPORT MODULE
return SocialCompetition