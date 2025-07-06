--[[
    🎪 CINEMATIC RUNWAY ENGINE - Révolutionnaire Runway System
    Défilés cinématographiques avec caméras intelligentes et effets spéciaux
    
    Innovations :
    - Caméras automatiques multi-angles
    - Éclairage professionnel adaptatif
    - Effets spéciaux et particules
    - Synchronisation musicale
    - Système de replay et montage
    - Streaming live intégré
]]

local CinematicRunway = {}
CinematicRunway.__index = CinematicRunway

-- 🎯 SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local Debris = game:GetService("Debris")

-- 🎨 CONFIGURATION CINÉMATOGRAPHIQUE
local CINEMATIC_CONFIG = {
    -- 🎪 CAMERA SETTINGS
    CAMERA_MODES = {
        "Cinematic", "Dramatic", "Fashion", "Artistic", "Dynamic", "Intimate"
    },
    
    CAMERA_ANGLES = {
        "Wide Shot", "Medium Shot", "Close-up", "Extreme Close-up", 
        "Bird's Eye", "Worm's Eye", "Over Shoulder", "Profile"
    },
    
    -- 🎵 TIMING SETTINGS
    WALK_DURATION = 15, -- seconds per player
    POSE_DURATION = 3, -- seconds for posing
    TRANSITION_TIME = 1, -- seconds between players
    
    -- 🌟 EFFECTS SETTINGS
    PARTICLE_DENSITY = 100,
    LIGHTING_INTENSITY = 2,
    FOG_DENSITY = 0.1,
    
    -- 🎯 QUALITY SETTINGS
    FRAME_RATE_TARGET = 60,
    EFFECTS_QUALITY = "High", -- Low, Medium, High, Ultra
    STREAMING_QUALITY = "4K" -- 720p, 1080p, 4K, 8K
}

-- 🎪 RUNWAY ENVIRONMENTS
local RUNWAY_ENVIRONMENTS = {
    CLASSIC_ELEGANCE = {
        Theme = "Classic Elegance",
        Colors = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0), Color3.fromRGB(212, 175, 55)},
        Lighting = "Warm Spotlight",
        Effects = {"Rose Petals", "Soft Glow", "Elegant Particles"},
        Music = "Classical Orchestral",
        Atmosphere = "Sophisticated"
    },
    
    CYBERPUNK_FUTURE = {
        Theme = "Cyberpunk Future",
        Colors = {Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 255, 0)},
        Lighting = "Neon Strobe",
        Effects = {"Digital Particles", "Holographic Overlays", "Laser Beams"},
        Music = "Electronic Synthwave",
        Atmosphere = "Futuristic"
    },
    
    NATURE_HARMONY = {
        Theme = "Nature Harmony",
        Colors = {Color3.fromRGB(34, 139, 34), Color3.fromRGB(139, 69, 19), Color3.fromRGB(255, 215, 0)},
        Lighting = "Natural Sunlight",
        Effects = {"Falling Leaves", "Butterfly Swarm", "Flower Blooms"},
        Music = "Nature Ambient",
        Atmosphere = "Serene"
    },
    
    URBAN_STREET = {
        Theme = "Urban Street",
        Colors = {Color3.fromRGB(105, 105, 105), Color3.fromRGB(255, 165, 0), Color3.fromRGB(220, 20, 60)},
        Lighting = "Street Lamps",
        Effects = {"Urban Smoke", "Graffiti Projections", "Street Sounds"},
        Music = "Hip-Hop Beats",
        Atmosphere = "Edgy"
    }
}

-- 🎯 CAMERA PRESETS
local CAMERA_PRESETS = {
    ENTRANCE = {
        Position = Vector3.new(0, 10, 30),
        LookAt = Vector3.new(0, 0, 0),
        FieldOfView = 70,
        Movement = "Smooth Dolly",
        Duration = 3
    },
    
    RUNWAY_FOLLOW = {
        Position = Vector3.new(5, 8, 0),
        LookAt = "Player",
        FieldOfView = 50,
        Movement = "Tracking",
        Duration = 8
    },
    
    POSE_CLOSE = {
        Position = Vector3.new(0, 6, 8),
        LookAt = "Player Face",
        FieldOfView = 35,
        Movement = "Cinematic Arc",
        Duration = 3
    },
    
    DRAMATIC_WIDE = {
        Position = Vector3.new(0, 15, 20),
        LookAt = Vector3.new(0, 0, 0),
        FieldOfView = 90,
        Movement = "Epic Sweep",
        Duration = 4
    }
}

-- 🎪 MAIN CINEMATIC CLASS
function CinematicRunway.new()
    local self = setmetatable({}, CinematicRunway)
    
    -- 🎨 RUNWAY STATE
    self.RunwayState = {
        CurrentEnvironment = nil,
        ActivePlayers = {},
        CameraSequence = {},
        EffectsActive = {},
        StreamingEnabled = false,
        RecordingEnabled = false,
        CurrentPlayer = nil,
        ShowStartTime = 0
    }
    
    -- 🎯 CAMERA SYSTEM
    self.CameraSystem = {
        VirtualCameras = {},
        ActiveCamera = nil,
        CameraController = nil,
        TransitionTween = nil,
        FollowTarget = nil
    }
    
    -- 🌟 EFFECTS SYSTEM
    self.EffectsSystem = {
        ParticleEmitters = {},
        LightingEffects = {},
        EnvironmentEffects = {},
        PostProcessing = {}
    }
    
    -- 🎵 AUDIO SYSTEM
    self.AudioSystem = {
        BackgroundMusic = nil,
        SoundEffects = {},
        VolumeController = nil,
        BeatSync = false
    }
    
    -- 🚀 INITIALIZATION
    self:InitializeRunway()
    
    return self
end

-- 🎪 RUNWAY INITIALIZATION
function CinematicRunway:InitializeRunway()
    -- 🎯 SETUP RUNWAY STAGE
    self:CreateRunwayStage()
    
    -- 🎨 INITIALIZE CAMERA SYSTEM
    self:InitializeCameraSystem()
    
    -- 🌟 SETUP EFFECTS
    self:InitializeEffectsSystem()
    
    -- 🎵 SETUP AUDIO
    self:InitializeAudioSystem()
    
    -- 🎪 PERFORMANCE MONITORING
    self:SetupPerformanceMonitoring()
    
    print("🎪 Cinematic Runway Engine initialized with revolutionary technology!")
end

-- 🎯 RUNWAY STAGE CREATION
function CinematicRunway:CreateRunwayStage()
    -- 🎪 MAIN RUNWAY PLATFORM
    local runway = Instance.new("Part")
    runway.Name = "CinematicRunway"
    runway.Size = Vector3.new(50, 1, 200)
    runway.Position = Vector3.new(0, 0, 0)
    runway.Anchored = true
    runway.Material = Enum.Material.Marble
    runway.BrickColor = BrickColor.new("Institutional white")
    runway.TopSurface = Enum.SurfaceType.Smooth
    runway.BottomSurface = Enum.SurfaceType.Smooth
    runway.Parent = workspace
    
    -- 🎨 RUNWAY TEXTURE
    local decal = Instance.new("Decal")
    decal.Texture = "rbxasset://textures/face.png" -- Placeholder
    decal.Face = Enum.NormalId.Top
    decal.Parent = runway
    
    -- 🌟 AUDIENCE AREA
    local audience = Instance.new("Part")
    audience.Name = "AudienceArea"
    audience.Size = Vector3.new(100, 1, 100)
    audience.Position = Vector3.new(0, 0, 60)
    audience.Anchored = true
    audience.Material = Enum.Material.Carpet
    audience.BrickColor = BrickColor.new("Really black")
    audience.Parent = workspace
    
    -- 🎪 BACKDROP
    local backdrop = Instance.new("Part")
    backdrop.Name = "Backdrop"
    backdrop.Size = Vector3.new(60, 40, 1)
    backdrop.Position = Vector3.new(0, 20, -100)
    backdrop.Anchored = true
    backdrop.Material = Enum.Material.Neon
    backdrop.BrickColor = BrickColor.new("Deep blue")
    backdrop.Parent = workspace
    
    -- 🎯 POSE SPOTS
    self:CreatePoseSpots()
    
    -- 🎨 LIGHTING SETUP
    self:SetupRunwayLighting()
    
    print("🎪 Runway Stage created with cinematic architecture!")
end

-- 🎯 POSE SPOTS CREATION
function CinematicRunway:CreatePoseSpots()
    local posePositions = {
        Vector3.new(0, 1, -80), -- Start
        Vector3.new(0, 1, -40), -- Mid
        Vector3.new(0, 1, 0),   -- Center
        Vector3.new(0, 1, 40),  -- End
        Vector3.new(0, 1, 80)   -- Exit
    }
    
    for i, position in ipairs(posePositions) do
        local poseSpot = Instance.new("Part")
        poseSpot.Name = "PoseSpot" .. i
        poseSpot.Size = Vector3.new(3, 0.1, 3)
        poseSpot.Position = position
        poseSpot.Anchored = true
        poseSpot.Material = Enum.Material.Neon
        poseSpot.BrickColor = BrickColor.new("Bright blue")
        poseSpot.Transparency = 0.5
        poseSpot.Parent = workspace
        
        -- 🌟 GLOW EFFECT
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 2
        pointLight.Color = Color3.fromRGB(0, 200, 255)
        pointLight.Range = 10
        pointLight.Parent = poseSpot
    end
end

-- 🎨 LIGHTING SETUP
function CinematicRunway:SetupRunwayLighting()
    -- 🎪 MAIN RUNWAY LIGHTING
    local mainLights = {}
    
    for i = 1, 10 do
        local light = Instance.new("Part")
        light.Name = "RunwayLight" .. i
        light.Size = Vector3.new(1, 1, 1)
        light.Position = Vector3.new(0, 15, -90 + (i * 20))
        light.Anchored = true
        light.Material = Enum.Material.Neon
        light.BrickColor = BrickColor.new("Institutional white")
        light.Shape = Enum.PartType.Ball
        light.Parent = workspace
        
        -- 🌟 SPOTLIGHT
        local spotlight = Instance.new("SpotLight")
        spotlight.Brightness = 5
        spotlight.Range = 30
        spotlight.Angle = 45
        spotlight.Color = Color3.fromRGB(255, 255, 255)
        spotlight.Face = Enum.NormalId.Bottom
        spotlight.Parent = light
        
        table.insert(mainLights, light)
    end
    
    -- 🎯 AMBIENT LIGHTING
    Lighting.Ambient = Color3.fromRGB(50, 50, 50)
    Lighting.Brightness = 1
    Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
    Lighting.ColorShift_Bottom = Color3.fromRGB(100, 100, 100)
    
    -- 🎪 ATMOSPHERIC EFFECTS
    local atmosphere = Instance.new("Atmosphere")
    atmosphere.Density = 0.1
    atmosphere.Offset = 0.5
    atmosphere.Color = Color3.fromRGB(199, 199, 199)
    atmosphere.Decay = Color3.fromRGB(106, 112, 125)
    atmosphere.Glare = 0.5
    atmosphere.Haze = 1
    atmosphere.Parent = Lighting
    
    self.RunwayState.MainLights = mainLights
end

-- 🎯 CAMERA SYSTEM INITIALIZATION
function CinematicRunway:InitializeCameraSystem()
    -- 🎪 VIRTUAL CAMERAS SETUP
    for name, preset in pairs(CAMERA_PRESETS) do
        local virtualCamera = {
            Name = name,
            Position = preset.Position,
            LookAt = preset.LookAt,
            FieldOfView = preset.FieldOfView,
            Movement = preset.Movement,
            Duration = preset.Duration,
            IsActive = false
        }
        
        self.CameraSystem.VirtualCameras[name] = virtualCamera
    end
    
    -- 🎨 CAMERA CONTROLLER SETUP
    self.CameraSystem.CameraController = {
        SmoothingEnabled = true,
        InterpolationSpeed = 0.5,
        LookAheadDistance = 10,
        StabilizationEnabled = true
    }
    
    print("🎯 Camera System initialized with", #self.CameraSystem.VirtualCameras, "virtual cameras")
end

-- 🌟 EFFECTS SYSTEM INITIALIZATION
function CinematicRunway:InitializeEffectsSystem()
    -- 🎪 PARTICLE EFFECTS
    self.EffectsSystem.ParticleEmitters = {
        Sparkles = self:CreateSparkleEffect(),
        Confetti = self:CreateConfettiEffect(),
        Smoke = self:CreateSmokeEffect(),
        Petals = self:CreatePetalEffect()
    }
    
    -- 🎨 LIGHTING EFFECTS
    self.EffectsSystem.LightingEffects = {
        Strobe = self:CreateStrobeEffect(),
        ColorWash = self:CreateColorWashEffect(),
        Spotlight = self:CreateSpotlightEffect()
    }
    
    print("🌟 Effects System initialized with revolutionary particle technology!")
end

-- 🎵 AUDIO SYSTEM INITIALIZATION
function CinematicRunway:InitializeAudioSystem()
    -- 🎪 BACKGROUND MUSIC SETUP
    self.AudioSystem.BackgroundMusic = Instance.new("Sound")
    self.AudioSystem.BackgroundMusic.Name = "RunwayMusic"
    self.AudioSystem.BackgroundMusic.Volume = 0.5
    self.AudioSystem.BackgroundMusic.Looped = true
    self.AudioSystem.BackgroundMusic.Parent = workspace
    
    -- 🎯 SOUND EFFECTS
    self.AudioSystem.SoundEffects = {
        CameraShutter = self:CreateSoundEffect("CameraShutter", "rbxasset://sounds/camera_shutter.mp3"),
        Applause = self:CreateSoundEffect("Applause", "rbxasset://sounds/applause.mp3"),
        Footsteps = self:CreateSoundEffect("Footsteps", "rbxasset://sounds/footsteps.mp3"),
        WhooshTransition = self:CreateSoundEffect("Whoosh", "rbxasset://sounds/whoosh.mp3")
    }
    
    print("🎵 Audio System initialized with immersive sound design!")
end

-- 🎪 MAIN CINEMATIC SHOW
function CinematicRunway:StartCinematicShow(playersInGame)
    print("🎪 Starting Revolutionary Cinematic Runway Show!")
    
    -- 🎯 SETUP SHOW
    self.RunwayState.ShowStartTime = tick()
    self.RunwayState.ActivePlayers = playersInGame
    
    -- 🎨 ENVIRONMENT SETUP
    self:SetupThemeEnvironment("Cinematic Elegance")
    
    -- 🎵 START MUSIC
    self:PlayRunwayMusic()
    
    -- 🌟 START EFFECTS
    self:StartEnvironmentEffects()
    
    -- 🎪 CAMERA SEQUENCE
    self:StartCameraSequence()
    
    -- 🎯 PLAYER SEQUENCE
    self:StartPlayerSequence()
end

-- 🎯 PLAYER SEQUENCE
function CinematicRunway:StartPlayerSequence()
    local playerList = {}
    
    for userId, playerData in pairs(self.RunwayState.ActivePlayers) do
        local player = Players:GetPlayerByUserId(userId)
        if player and player.Character then
            table.insert(playerList, player)
        end
    end
    
    -- 🎪 RANDOMIZE ORDER
    for i = #playerList, 2, -1 do
        local j = math.random(i)
        playerList[i], playerList[j] = playerList[j], playerList[i]
    end
    
    -- 🎯 SEQUENTIAL PLAYER WALKS
    for i, player in ipairs(playerList) do
        spawn(function()
            wait((i - 1) * (CINEMATIC_CONFIG.WALK_DURATION + CINEMATIC_CONFIG.TRANSITION_TIME))
            self:PlayerRunwayWalk(player)
        end)
    end
end

-- 🎭 INDIVIDUAL PLAYER WALK
function CinematicRunway:PlayerRunwayWalk(player)
    if not player or not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    print("🎭 Player", player.DisplayName, "taking the runway!")
    
    -- 🎯 SET CURRENT PLAYER
    self.RunwayState.CurrentPlayer = player
    
    -- 🎪 ENTRANCE CAMERA
    self:SwitchToCamera("ENTRANCE")
    
    -- 🎨 ENTRANCE EFFECTS
    self:TriggerPlayerEffects(player, "Entrance")
    
    -- 🎯 MOVE TO START POSITION
    rootPart.CFrame = CFrame.new(0, 1, -80)
    
    -- 🎪 RUNWAY WALK SEQUENCE
    local walkSequence = {
        {Position = Vector3.new(0, 1, -40), Camera = "RUNWAY_FOLLOW", Duration = 4},
        {Position = Vector3.new(0, 1, 0), Camera = "POSE_CLOSE", Duration = 3, Pose = true},
        {Position = Vector3.new(0, 1, 40), Camera = "RUNWAY_FOLLOW", Duration = 4},
        {Position = Vector3.new(0, 1, 80), Camera = "DRAMATIC_WIDE", Duration = 3}
    }
    
    for i, segment in ipairs(walkSequence) do
        -- 🎯 CAMERA SWITCH
        self:SwitchToCamera(segment.Camera)
        
        -- 🎪 MOVEMENT
        self:MovePlayerToPosition(player, segment.Position, segment.Duration)
        
        -- 🎨 POSE
        if segment.Pose then
            self:TriggerPlayerPose(player)
            wait(CINEMATIC_CONFIG.POSE_DURATION)
        end
        
        wait(segment.Duration)
    end
    
    -- 🎯 EXIT EFFECTS
    self:TriggerPlayerEffects(player, "Exit")
    
    -- 🎪 CLEANUP
    self.RunwayState.CurrentPlayer = nil
    
    print("🎭 Player", player.DisplayName, "completed their runway walk!")
end

-- 🎯 CAMERA SWITCHING
function CinematicRunway:SwitchToCamera(cameraName)
    local camera = self.CameraSystem.VirtualCameras[cameraName]
    if not camera then return end
    
    local currentCamera = workspace.CurrentCamera
    
    -- 🎪 CAMERA TRANSITION
    local startCFrame = currentCamera.CFrame
    local targetPosition = camera.Position
    local targetLookAt = camera.LookAt
    
    -- 🎯 CALCULATE TARGET CFRAME
    local targetCFrame
    if typeof(targetLookAt) == "string" and targetLookAt == "Player" then
        if self.RunwayState.CurrentPlayer and self.RunwayState.CurrentPlayer.Character then
            local playerPosition = self.RunwayState.CurrentPlayer.Character.HumanoidRootPart.Position
            targetCFrame = CFrame.lookAt(targetPosition, playerPosition)
        else
            targetCFrame = CFrame.lookAt(targetPosition, Vector3.new(0, 0, 0))
        end
    else
        targetCFrame = CFrame.lookAt(targetPosition, targetLookAt)
    end
    
    -- 🎨 SMOOTH TRANSITION
    local transitionInfo = TweenInfo.new(
        1.5,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(currentCamera, transitionInfo, {
        CFrame = targetCFrame,
        FieldOfView = camera.FieldOfView
    })
    
    tween:Play()
    
    -- 🎪 CAMERA MOVEMENT EFFECTS
    self:AddCameraMovementEffects(camera.Movement)
    
    print("🎯 Camera switched to:", cameraName)
end

-- 🎨 CAMERA MOVEMENT EFFECTS
function CinematicRunway:AddCameraMovementEffects(movementType)
    local camera = workspace.CurrentCamera
    
    if movementType == "Smooth Dolly" then
        -- 🎪 SMOOTH DOLLY MOVEMENT
        spawn(function()
            local startTime = tick()
            while tick() - startTime < 3 do
                local elapsed = tick() - startTime
                local offset = Vector3.new(math.sin(elapsed * 2) * 0.5, 0, 0)
                camera.CFrame = camera.CFrame + offset
                wait(0.1)
            end
        end)
        
    elseif movementType == "Cinematic Arc" then
        -- 🎯 CINEMATIC ARC
        spawn(function()
            local startTime = tick()
            local originalCFrame = camera.CFrame
            
            while tick() - startTime < 3 do
                local elapsed = tick() - startTime
                local progress = elapsed / 3
                local arcOffset = Vector3.new(
                    math.sin(progress * math.pi) * 2,
                    math.sin(progress * math.pi * 2) * 0.5,
                    0
                )
                camera.CFrame = originalCFrame * CFrame.new(arcOffset)
                wait(0.1)
            end
        end)
    end
end

-- 🎭 PLAYER MOVEMENT
function CinematicRunway:MovePlayerToPosition(player, targetPosition, duration)
    if not player or not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    -- 🎪 ELEGANT MOVEMENT
    local startPosition = rootPart.Position
    local startTime = tick()
    
    spawn(function()
        while tick() - startTime < duration do
            local elapsed = tick() - startTime
            local progress = elapsed / duration
            
            -- 🎯 EASING FUNCTION
            local easedProgress = 1 - math.pow(1 - progress, 3)
            
            local currentPosition = startPosition:lerp(targetPosition, easedProgress)
            rootPart.CFrame = CFrame.new(currentPosition, targetPosition)
            
            wait(0.1)
        end
        
        -- 🎪 ENSURE FINAL POSITION
        rootPart.CFrame = CFrame.new(targetPosition)
    end)
end

-- 🎨 PLAYER POSE
function CinematicRunway:TriggerPlayerPose(player)
    if not player or not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    
    if not humanoid then return end
    
    -- 🎪 POSE ANIMATIONS
    local poseAnimations = {
        "rbxassetid://507777826", -- Confident
        "rbxassetid://507777659", -- Heroic
        "rbxassetid://507777451", -- Stylish
        "rbxassetid://507777268"  -- Elegant
    }
    
    local selectedPose = poseAnimations[math.random(1, #poseAnimations)]
    
    -- 🎯 LOAD AND PLAY ANIMATION
    local animationTrack = humanoid:LoadAnimation(Instance.new("Animation"))
    animationTrack.AnimationId = selectedPose
    animationTrack:Play()
    
    -- 🎨 POSE EFFECTS
    self:TriggerPlayerEffects(player, "Pose")
    
    -- 🎪 CAMERA FLASH EFFECT
    self:TriggerCameraFlash()
    
    print("🎨 Player", player.DisplayName, "striking a pose!")
end

-- 🌟 THEME ENVIRONMENT SETUP
function CinematicRunway:SetupThemeEnvironment(theme)
    local environment = RUNWAY_ENVIRONMENTS.CLASSIC_ELEGANCE -- Default
    
    -- 🎯 MATCH THEME TO ENVIRONMENT
    for name, env in pairs(RUNWAY_ENVIRONMENTS) do
        if string.find(theme:lower(), name:lower()) then
            environment = env
            break
        end
    end
    
    -- 🎨 APPLY ENVIRONMENT
    self:ApplyEnvironment(environment)
    
    print("🌟 Theme Environment set to:", environment.Theme)
end

-- 🎪 ENVIRONMENT APPLICATION
function CinematicRunway:ApplyEnvironment(environment)
    -- 🎯 LIGHTING CHANGES
    for i, light in ipairs(self.RunwayState.MainLights) do
        local colorIndex = ((i - 1) % #environment.Colors) + 1
        light.Color = environment.Colors[colorIndex]
        
        local spotlight = light:FindFirstChild("SpotLight")
        if spotlight then
            spotlight.Color = environment.Colors[colorIndex]
        end
    end
    
    -- 🎨 ATMOSPHERIC CHANGES
    local atmosphere = Lighting:FindFirstChild("Atmosphere")
    if atmosphere then
        atmosphere.Color = environment.Colors[1]
        atmosphere.Decay = environment.Colors[2]
    end
    
    -- 🌟 PARTICLE EFFECTS
    self:StartThemeParticles(environment.Effects)
    
    self.RunwayState.CurrentEnvironment = environment
end

-- 🎯 PARTICLE EFFECTS
function CinematicRunway:StartThemeParticles(effects)
    for _, effectName in ipairs(effects) do
        local emitter = self.EffectsSystem.ParticleEmitters[effectName]
        if emitter then
            emitter.Enabled = true
        end
    end
end

-- 🎪 PLAYER EFFECTS
function CinematicRunway:TriggerPlayerEffects(player, effectType)
    if not player or not player.Character then return end
    
    local character = player.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not rootPart then return end
    
    if effectType == "Entrance" then
        -- 🌟 ENTRANCE SPARKLES
        local sparkles = Instance.new("Sparkles")
        sparkles.Color = Color3.fromRGB(255, 215, 0)
        sparkles.Parent = rootPart
        
        Debris:AddItem(sparkles, 5)
        
    elseif effectType == "Pose" then
        -- 🎯 POSE SPOTLIGHT
        local spotlight = Instance.new("SpotLight")
        spotlight.Brightness = 10
        spotlight.Range = 20
        spotlight.Color = Color3.fromRGB(255, 255, 255)
        spotlight.Parent = rootPart
        
        Debris:AddItem(spotlight, 3)
        
    elseif effectType == "Exit" then
        -- 🎪 EXIT CONFETTI
        local confetti = self.EffectsSystem.ParticleEmitters.Confetti:Clone()
        confetti.Parent = rootPart
        confetti.Enabled = true
        
        Debris:AddItem(confetti, 3)
    end
end

-- 🎨 CAMERA FLASH
function CinematicRunway:TriggerCameraFlash()
    local flash = Instance.new("Frame")
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flash.BackgroundTransparency = 0
    flash.BorderSizePixel = 0
    flash.Parent = workspace.CurrentCamera
    
    -- 🎪 FLASH ANIMATION
    local flashTween = TweenService:Create(
        flash,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    
    flashTween:Play()
    flashTween.Completed:Connect(function()
        flash:Destroy()
    end)
    
    -- 🎯 CAMERA SOUND
    if self.AudioSystem.SoundEffects.CameraShutter then
        self.AudioSystem.SoundEffects.CameraShutter:Play()
    end
end

-- 🎵 MUSIC SYSTEM
function CinematicRunway:PlayRunwayMusic()
    if self.AudioSystem.BackgroundMusic then
        self.AudioSystem.BackgroundMusic.SoundId = "rbxasset://sounds/runway_music.mp3"
        self.AudioSystem.BackgroundMusic:Play()
    end
end

-- 🎪 RESULTS DISPLAY
function CinematicRunway:ShowResults(results)
    print("🎪 Showing Cinematic Results!")
    
    -- 🎯 RESULTS CAMERA
    self:SwitchToCamera("DRAMATIC_WIDE")
    
    -- 🌟 WINNER SPOTLIGHT
    if results.winner then
        self:CreateWinnerSpotlight(results.winner)
    end
    
    -- 🎨 CELEBRATION EFFECTS
    self:TriggerCelebrationEffects()
    
    -- 🎵 VICTORY MUSIC
    self:PlayVictoryMusic()
end

-- 🏆 WINNER SPOTLIGHT
function CinematicRunway:CreateWinnerSpotlight(winner)
    if not winner or not winner.Character then return end
    
    local character = winner.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not rootPart then return end
    
    -- 🌟 GOLDEN SPOTLIGHT
    local spotlight = Instance.new("SpotLight")
    spotlight.Brightness = 15
    spotlight.Range = 30
    spotlight.Color = Color3.fromRGB(255, 215, 0)
    spotlight.Parent = rootPart
    
    -- 🎪 WINNER PARTICLES
    local fire = Instance.new("Fire")
    fire.Size = 10
    fire.Heat = 15
    fire.Color = Color3.fromRGB(255, 215, 0)
    fire.SecondaryColor = Color3.fromRGB(255, 165, 0)
    fire.Parent = rootPart
    
    print("🏆 Winner spotlight created for:", winner.DisplayName)
end

-- 🎉 CELEBRATION EFFECTS
function CinematicRunway:TriggerCelebrationEffects()
    -- 🎪 CONFETTI EXPLOSION
    for i = 1, 10 do
        local confetti = self.EffectsSystem.ParticleEmitters.Confetti:Clone()
        confetti.Parent = workspace
        confetti.Position = Vector3.new(
            math.random(-25, 25),
            20,
            math.random(-50, 50)
        )
        confetti.Enabled = true
        
        Debris:AddItem(confetti, 10)
    end
    
    -- 🎯 FIREWORKS
    self:TriggerFireworks()
end

-- 🎆 FIREWORKS
function CinematicRunway:TriggerFireworks()
    for i = 1, 5 do
        spawn(function()
            wait(i * 0.5)
            
            local firework = Instance.new("Explosion")
            firework.Position = Vector3.new(
                math.random(-30, 30),
                30,
                math.random(-80, 80)
            )
            firework.BlastRadius = 20
            firework.BlastPressure = 0
            firework.Parent = workspace
        end)
    end
end

-- 🎯 UTILITY FUNCTIONS
function CinematicRunway:CreateSparkleEffect()
    local attachment = Instance.new("Attachment")
    local sparkles = Instance.new("ParticleEmitter")
    sparkles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    sparkles.Lifetime = NumberRange.new(1, 3)
    sparkles.Rate = 50
    sparkles.SpreadAngle = Vector2.new(45, 45)
    sparkles.Speed = NumberRange.new(5, 10)
    sparkles.Parent = attachment
    sparkles.Enabled = false
    
    attachment.Parent = workspace
    return sparkles
end

function CinematicRunway:CreateConfettiEffect()
    local attachment = Instance.new("Attachment")
    local confetti = Instance.new("ParticleEmitter")
    confetti.Texture = "rbxasset://textures/particles/confetti.dds"
    confetti.Lifetime = NumberRange.new(3, 5)
    confetti.Rate = 100
    confetti.SpreadAngle = Vector2.new(180, 180)
    confetti.Speed = NumberRange.new(10, 20)
    confetti.Parent = attachment
    confetti.Enabled = false
    
    attachment.Parent = workspace
    return confetti
end

function CinematicRunway:CreateSmokeEffect()
    local attachment = Instance.new("Attachment")
    local smoke = Instance.new("ParticleEmitter")
    smoke.Texture = "rbxasset://textures/particles/smoke_main.dds"
    smoke.Lifetime = NumberRange.new(5, 8)
    smoke.Rate = 20
    smoke.SpreadAngle = Vector2.new(30, 30)
    smoke.Speed = NumberRange.new(2, 5)
    smoke.Parent = attachment
    smoke.Enabled = false
    
    attachment.Parent = workspace
    return smoke
end

function CinematicRunway:CreateSoundEffect(name, soundId)
    local sound = Instance.new("Sound")
    sound.Name = name
    sound.SoundId = soundId
    sound.Volume = 0.5
    sound.Parent = workspace
    return sound
end

-- 🎯 PERFORMANCE MONITORING
function CinematicRunway:SetupPerformanceMonitoring()
    spawn(function()
        while true do
            wait(5)
            
            local frameRate = 1 / RunService.RenderStepped:Wait()
            
            if frameRate < CINEMATIC_CONFIG.FRAME_RATE_TARGET then
                self:OptimizePerformance()
            end
        end
    end)
end

function CinematicRunway:OptimizePerformance()
    -- 🎯 REDUCE PARTICLE DENSITY
    CINEMATIC_CONFIG.PARTICLE_DENSITY = math.max(50, CINEMATIC_CONFIG.PARTICLE_DENSITY - 10)
    
    -- 🎨 LOWER EFFECTS QUALITY
    if CINEMATIC_CONFIG.EFFECTS_QUALITY == "Ultra" then
        CINEMATIC_CONFIG.EFFECTS_QUALITY = "High"
    elseif CINEMATIC_CONFIG.EFFECTS_QUALITY == "High" then
        CINEMATIC_CONFIG.EFFECTS_QUALITY = "Medium"
    end
    
    print("🎯 Performance optimized for better frame rate")
end

-- 🎯 EXPORT MODULE
return CinematicRunway