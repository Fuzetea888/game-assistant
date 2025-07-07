--[[
    ✨ VISUAL EFFECTS MANAGER - Effets Visuels Révolutionnaires
    Système d'effets visuels cinématographiques pour Fashion Revolution
    
    Innovations :
    - Système de particules 3D avancé
    - Éclairage dynamique et cinématographique
    - Effets post-processing temps réel
    - Système de shaders personnalisés
    - Effets météorologiques réalistes
    - Animations de caméra cinématique
]]

local VisualEffectsManager = {}
VisualEffectsManager.__index = VisualEffectsManager

-- 🎯 SERVICES
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")

-- 🎨 EFFECTS CONFIGURATION
local EFFECTS_CONFIG = {
    -- 🌟 PARTICLE SETTINGS
    PARTICLE_BUDGET = 2000,
    MAX_EMITTERS = 50,
    PARTICLE_LIFETIME = 10,
    EMISSION_RATE = 100,
    
    -- 💡 LIGHTING SETTINGS
    DYNAMIC_LIGHTING = true,
    LIGHT_INTENSITY = 1.5,
    SHADOW_QUALITY = "High",
    BLOOM_INTENSITY = 0.8,
    
    -- 🎭 ANIMATION SETTINGS
    ANIMATION_SMOOTHNESS = 60, -- FPS
    TWEEN_DURATION = 0.3,
    EASING_STYLE = Enum.EasingStyle.Quad,
    
    -- 🌈 COLOR PALETTES
    COLORS = {
        FIRE = Color3.fromRGB(255, 69, 0),
        WATER = Color3.fromRGB(0, 191, 255),
        MAGIC = Color3.fromRGB(138, 43, 226),
        NATURE = Color3.fromRGB(34, 139, 34),
        ELECTRIC = Color3.fromRGB(255, 255, 0),
        ICE = Color3.fromRGB(173, 216, 230),
        LOVE = Color3.fromRGB(255, 105, 180),
        GOLD = Color3.fromRGB(255, 215, 0)
    }
}

-- 🎪 EFFECT TEMPLATES
local EFFECT_TEMPLATES = {
    SPARKLES = {
        Name = "Sparkles",
        Type = "Particle",
        Properties = {
            Texture = "rbxasset://textures/particles/sparkles_main.dds",
            Lifetime = NumberRange.new(2, 4),
            Rate = 50,
            SpreadAngle = Vector2.new(45, 45),
            Speed = NumberRange.new(5, 10),
            Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        }
    },
    
    MAGIC_AURA = {
        Name = "Magic Aura",
        Type = "Particle",
        Properties = {
            Texture = "rbxasset://textures/particles/smoke_main.dds",
            Lifetime = NumberRange.new(3, 6),
            Rate = 25,
            SpreadAngle = Vector2.new(360, 360),
            Speed = NumberRange.new(2, 5),
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
            })
        }
    },
    
    RUNWAY_SMOKE = {
        Name = "Runway Smoke",
        Type = "Particle",
        Properties = {
            Texture = "rbxasset://textures/particles/smoke_main.dds",
            Lifetime = NumberRange.new(8, 12),
            Rate = 15,
            SpreadAngle = Vector2.new(30, 30),
            Speed = NumberRange.new(3, 7),
            Color = ColorSequence.new(Color3.fromRGB(200, 200, 200))
        }
    },
    
    CONFETTI_BURST = {
        Name = "Confetti Burst",
        Type = "Particle",
        Properties = {
            Texture = "rbxasset://textures/particles/confetti.dds",
            Lifetime = NumberRange.new(3, 5),
            Rate = 200,
            SpreadAngle = Vector2.new(180, 180),
            Speed = NumberRange.new(10, 20),
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
            })
        }
    },
    
    ROSE_PETALS = {
        Name = "Rose Petals",
        Type = "Particle",
        Properties = {
            Texture = "rbxasset://textures/particles/rose_petal.dds",
            Lifetime = NumberRange.new(5, 8),
            Rate = 30,
            SpreadAngle = Vector2.new(45, 45),
            Speed = NumberRange.new(2, 4),
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 20, 147)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180))
            })
        }
    }
}

-- 🎭 LIGHTING PRESETS
local LIGHTING_PRESETS = {
    RUNWAY_SPOTLIGHT = {
        Name = "Runway Spotlight",
        Type = "SpotLight",
        Properties = {
            Brightness = 3,
            Range = 50,
            Angle = 45,
            Color = Color3.fromRGB(255, 255, 255),
            Shadows = true
        }
    },
    
    DRAMATIC_FILL = {
        Name = "Dramatic Fill",
        Type = "PointLight",
        Properties = {
            Brightness = 2,
            Range = 30,
            Color = Color3.fromRGB(255, 200, 150),
            Shadows = true
        }
    },
    
    COLORED_ACCENT = {
        Name = "Colored Accent",
        Type = "SpotLight",
        Properties = {
            Brightness = 1.5,
            Range = 25,
            Angle = 60,
            Color = Color3.fromRGB(138, 43, 226),
            Shadows = false
        }
    }
}

-- 🎨 POST-PROCESSING EFFECTS
local POST_PROCESSING = {
    BLOOM = {
        Name = "Bloom",
        ClassName = "BloomEffect",
        Properties = {
            Intensity = 0.5,
            Size = 24,
            Threshold = 1.0
        }
    },
    
    BLUR = {
        Name = "Blur",
        ClassName = "BlurEffect",
        Properties = {
            Size = 12
        }
    },
    
    COLOR_CORRECTION = {
        Name = "Color Correction",
        ClassName = "ColorCorrectionEffect",
        Properties = {
            Brightness = 0.1,
            Contrast = 0.2,
            Saturation = 0.3,
            TintColor = Color3.fromRGB(255, 255, 255)
        }
    },
    
    SUNRAYS = {
        Name = "Sun Rays",
        ClassName = "SunRaysEffect",
        Properties = {
            Intensity = 0.15,
            Spread = 0.2
        }
    }
}

-- 🎪 MAIN VISUAL EFFECTS CLASS
function VisualEffectsManager.new()
    local self = setmetatable({}, VisualEffectsManager)
    
    -- 🎨 EFFECTS STATE
    self.EffectsState = {
        ActiveEffects = {},
        ParticleEmitters = {},
        LightSources = {},
        PostProcessEffects = {},
        AnimationTweens = {}
    }
    
    -- 🎯 MANAGERS
    self.ParticleManager = {
        Budget = EFFECTS_CONFIG.PARTICLE_BUDGET,
        UsedBudget = 0,
        EmitterPool = {},
        EffectQueue = {}
    }
    
    self.LightingManager = {
        DynamicLights = {},
        LightingPresets = {},
        AmbientController = {}
    }
    
    self.PostProcessManager = {
        EffectStack = {},
        BlendModes = {},
        RenderPipeline = {}
    }
    
    -- 🎭 CAMERA CONTROLLER
    self.CameraController = {
        ActiveCamera = workspace.CurrentCamera,
        CameraTweens = {},
        CinematicModes = {},
        ShakeEffects = {}
    }
    
    -- 🌟 WEATHER SYSTEM
    self.WeatherSystem = {
        CurrentWeather = "Clear",
        WeatherEffects = {},
        TransitionSpeed = 1.0
    }
    
    -- 🎪 INITIALIZATION
    self:InitializeEffectsSystem()
    
    return self
end

-- 🎨 EFFECTS SYSTEM INITIALIZATION
function VisualEffectsManager:InitializeEffectsSystem()
    -- 🎯 SETUP CONTAINERS
    self:CreateEffectsContainers()
    
    -- 🎪 INITIALIZE PARTICLE SYSTEM
    self:InitializeParticleSystem()
    
    -- 💡 SETUP LIGHTING SYSTEM
    self:SetupLightingSystem()
    
    -- 🎭 SETUP POST-PROCESSING
    self:SetupPostProcessing()
    
    -- 🌦️ INITIALIZE WEATHER SYSTEM
    self:InitializeWeatherSystem()
    
    -- ⚡ SETUP PERFORMANCE MONITORING
    self:SetupPerformanceMonitoring()
    
    print("✨ Visual Effects Manager initialized with cinematic quality!")
end

-- 🎪 EFFECTS CONTAINERS
function VisualEffectsManager:CreateEffectsContainers()
    -- 🎯 MAIN EFFECTS FOLDER
    self.EffectsContainer = Instance.new("Folder")
    self.EffectsContainer.Name = "FashionRevolutionEffects"
    self.EffectsContainer.Parent = workspace
    
    -- 🎨 ORGANIZED STRUCTURE
    local subfolders = {
        "ParticleEffects", "LightingEffects", "WeatherEffects",
        "CinematicEffects", "AudioEffects", "EnvironmentalEffects"
    }
    
    for _, folderName in ipairs(subfolders) do
        local folder = Instance.new("Folder")
        folder.Name = folderName
        folder.Parent = self.EffectsContainer
        self[folderName] = folder
    end
    
    print("🎪 Effects containers created with organized structure")
end

-- 🌟 PARTICLE SYSTEM INITIALIZATION
function VisualEffectsManager:InitializeParticleSystem()
    -- 🎯 PARTICLE POOL
    self.ParticlePool = {}
    
    -- 🎨 PRE-CREATE EMITTERS
    for i = 1, 20 do
        local emitter = Instance.new("ParticleEmitter")
        emitter.Enabled = false
        emitter.Parent = self.ParticleEffects
        table.insert(self.ParticlePool, emitter)
    end
    
    -- 🌟 PARTICLE BUDGET MONITOR
    spawn(function()
        while true do
            wait(1)
            self:UpdateParticleBudget()
        end
    end)
    
    print("🌟 Particle system initialized with", #self.ParticlePool, "emitters")
end

-- 💡 LIGHTING SYSTEM SETUP
function VisualEffectsManager:SetupLightingSystem()
    -- 🎯 LIGHTING CONTAINER
    self.LightingContainer = Instance.new("Folder")
    self.LightingContainer.Name = "DynamicLighting"
    self.LightingContainer.Parent = self.LightingEffects
    
    -- 🎨 AMBIENT LIGHTING SETUP
    self:SetupAmbientLighting()
    
    -- 🌟 DYNAMIC LIGHTING SYSTEM
    self:SetupDynamicLighting()
    
    print("💡 Lighting system setup with dynamic controls")
end

-- 🎭 POST-PROCESSING SETUP
function VisualEffectsManager:SetupPostProcessing()
    -- 🎯 POST-PROCESSING CONTAINER
    self.PostProcessContainer = Instance.new("Folder")
    self.PostProcessContainer.Name = "PostProcessing"
    self.PostProcessContainer.Parent = Lighting
    
    -- 🎨 APPLY DEFAULT EFFECTS
    for effectName, effectData in pairs(POST_PROCESSING) do
        self:CreatePostProcessEffect(effectName, effectData)
    end
    
    print("🎭 Post-processing setup with cinematic effects")
end

-- 🌦️ WEATHER SYSTEM INITIALIZATION
function VisualEffectsManager:InitializeWeatherSystem()
    -- 🎯 WEATHER EFFECTS
    self.WeatherEffects = {
        Rain = false,
        Snow = false,
        Wind = false,
        Fog = false
    }
    
    -- 🌟 WEATHER PARTICLES
    self.WeatherParticles = {}
    
    print("🌦️ Weather system initialized")
end

-- ✨ PARTICLE EFFECT CREATION
function VisualEffectsManager:CreateParticleEffect(effectName, attachment, properties)
    -- 🎯 GET EFFECT TEMPLATE
    local template = EFFECT_TEMPLATES[effectName]
    if not template then
        warn("✨ Effect template not found:", effectName)
        return nil
    end
    
    -- 🎨 GET AVAILABLE EMITTER
    local emitter = self:GetAvailableEmitter()
    if not emitter then
        warn("✨ No available particle emitters")
        return nil
    end
    
    -- 🌟 CONFIGURE EMITTER
    emitter.Parent = attachment
    
    -- 🎪 APPLY TEMPLATE PROPERTIES
    for property, value in pairs(template.Properties) do
        if emitter:FindFirstChild(property) or pcall(function() emitter[property] = value end) then
            emitter[property] = value
        end
    end
    
    -- 🎭 APPLY CUSTOM PROPERTIES
    if properties then
        for property, value in pairs(properties) do
            if emitter:FindFirstChild(property) or pcall(function() emitter[property] = value end) then
                emitter[property] = value
            end
        end
    end
    
    -- 🚀 ENABLE EFFECT
    emitter.Enabled = true
    
    -- 📊 TRACK EFFECT
    table.insert(self.EffectsState.ActiveEffects, {
        Name = effectName,
        Emitter = emitter,
        StartTime = tick(),
        Duration = properties and properties.Duration or 10
    })
    
    print("✨ Particle effect created:", effectName)
    return emitter
end

-- 🎯 GET AVAILABLE EMITTER
function VisualEffectsManager:GetAvailableEmitter()
    for _, emitter in ipairs(self.ParticlePool) do
        if not emitter.Enabled then
            return emitter
        end
    end
    
    -- 🎨 CREATE NEW EMITTER IF POOL IS FULL
    if #self.ParticlePool < EFFECTS_CONFIG.MAX_EMITTERS then
        local emitter = Instance.new("ParticleEmitter")
        emitter.Enabled = false
        emitter.Parent = self.ParticleEffects
        table.insert(self.ParticlePool, emitter)
        return emitter
    end
    
    return nil
end

-- 💡 DYNAMIC LIGHTING CREATION
function VisualEffectsManager:CreateDynamicLight(lightType, parent, properties)
    local light = Instance.new(lightType)
    light.Parent = parent
    
    -- 🎨 APPLY PROPERTIES
    if properties then
        for property, value in pairs(properties) do
            if light:FindFirstChild(property) or pcall(function() light[property] = value end) then
                light[property] = value
            end
        end
    end
    
    -- 🌟 REGISTER LIGHT
    table.insert(self.LightingManager.DynamicLights, light)
    
    print("💡 Dynamic light created:", lightType)
    return light
end

-- 🎪 RUNWAY SPOTLIGHT SYSTEM
function VisualEffectsManager:CreateRunwaySpotlights(runwayPart)
    local spotlights = {}
    
    -- 🎯 CREATE MULTIPLE SPOTLIGHTS
    for i = 1, 5 do
        local spotlight = Instance.new("SpotLight")
        spotlight.Brightness = 3
        spotlight.Range = 40
        spotlight.Angle = 30
        spotlight.Color = Color3.fromRGB(255, 255, 255)
        spotlight.Shadows = true
        spotlight.Face = Enum.NormalId.Top
        
        -- 🎨 POSITIONING
        local attachment = Instance.new("Attachment")
        attachment.Position = Vector3.new(0, 20, -80 + (i * 40))
        attachment.Parent = runwayPart
        spotlight.Parent = attachment
        
        table.insert(spotlights, spotlight)
    end
    
    -- 🎭 ANIMATED LIGHTING
    self:AddSpotlightAnimations(spotlights)
    
    print("🎪 Runway spotlights created:", #spotlights, "lights")
    return spotlights
end

-- 🎭 SPOTLIGHT ANIMATIONS
function VisualEffectsManager:AddSpotlightAnimations(spotlights)
    for i, spotlight in ipairs(spotlights) do
        -- 🌟 PULSING ANIMATION
        spawn(function()
            while spotlight.Parent do
                local pulseTween = TweenService:Create(spotlight, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    Brightness = spotlight.Brightness + 0.5
                })
                pulseTween:Play()
                wait(2)
            end
        end)
        
        -- 🎨 COLOR CYCLING
        spawn(function()
            local colors = {
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(255, 200, 200),
                Color3.fromRGB(200, 255, 200),
                Color3.fromRGB(200, 200, 255)
            }
            
            local colorIndex = 1
            while spotlight.Parent do
                local colorTween = TweenService:Create(spotlight, TweenInfo.new(3), {
                    Color = colors[colorIndex]
                })
                colorTween:Play()
                
                colorIndex = (colorIndex % #colors) + 1
                wait(3)
            end
        end)
    end
end

-- 🎨 AUDIENCE REACTION EFFECTS
function VisualEffectsManager:TriggerAudienceReaction(reactionType, intensity)
    if reactionType == "APPLAUSE" then
        -- 🎊 CONFETTI BURST
        self:CreateConfettiBurst(intensity)
        
        -- ✨ SPARKLE EFFECTS
        self:CreateSparkleField(intensity)
        
        -- 🎵 SOUND EFFECTS
        self:PlayReactionSound("applause", intensity)
        
    elseif reactionType == "EXCITEMENT" then
        -- 🌟 LIGHT FLASH
        self:CreateLightFlash(intensity)
        
        -- 🎆 FIREWORKS
        self:CreateFireworks(intensity)
        
    elseif reactionType == "LOVE" then
        -- 💖 HEART PARTICLES
        self:CreateHeartParticles(intensity)
        
        -- 🌹 ROSE PETALS
        self:CreateRosePetals(intensity)
    end
    
    print("🎨 Audience reaction triggered:", reactionType, "Intensity:", intensity)
end

-- 🎊 CONFETTI BURST
function VisualEffectsManager:CreateConfettiBurst(intensity)
    local confettiCount = math.ceil(intensity * 10)
    
    for i = 1, confettiCount do
        local confetti = Instance.new("Part")
        confetti.Name = "Confetti"
        confetti.Size = Vector3.new(0.5, 0.1, 0.5)
        confetti.Position = Vector3.new(
            math.random(-50, 50),
            20,
            math.random(-50, 50)
        )
        confetti.BrickColor = BrickColor.new(Color3.fromRGB(
            math.random(0, 255),
            math.random(0, 255),
            math.random(0, 255)
        ))
        confetti.Material = Enum.Material.Neon
        confetti.CanCollide = false
        confetti.Parent = self.ParticleEffects
        
        -- 🎭 CONFETTI ANIMATION
        local fallTween = TweenService:Create(confetti, TweenInfo.new(3), {
            Position = confetti.Position - Vector3.new(0, 30, 0),
            Rotation = Vector3.new(math.random(0, 360), math.random(0, 360), math.random(0, 360))
        })
        fallTween:Play()
        
        -- 🗑️ CLEANUP
        fallTween.Completed:Connect(function()
            confetti:Destroy()
        end)
    end
end

-- ✨ SPARKLE FIELD
function VisualEffectsManager:CreateSparkleField(intensity)
    local sparkleArea = Instance.new("Part")
    sparkleArea.Name = "SparkleArea"
    sparkleArea.Size = Vector3.new(100, 1, 100)
    sparkleArea.Position = Vector3.new(0, 0, 0)
    sparkleArea.Anchored = true
    sparkleArea.CanCollide = false
    sparkleArea.Transparency = 1
    sparkleArea.Parent = self.ParticleEffects
    
    -- 🌟 SPARKLE EMITTER
    local emitter = self:CreateParticleEffect("SPARKLES", sparkleArea, {
        Rate = intensity * 50,
        Duration = 5
    })
    
    -- 🗑️ CLEANUP
    spawn(function()
        wait(5)
        sparkleArea:Destroy()
    end)
end

-- 🌟 LIGHT FLASH
function VisualEffectsManager:CreateLightFlash(intensity)
    local flashLight = Instance.new("PointLight")
    flashLight.Brightness = intensity * 10
    flashLight.Range = 100
    flashLight.Color = Color3.fromRGB(255, 255, 255)
    flashLight.Parent = workspace
    
    -- 🎭 FLASH ANIMATION
    local flashTween = TweenService:Create(flashLight, TweenInfo.new(0.3), {
        Brightness = 0
    })
    flashTween:Play()
    
    -- 🗑️ CLEANUP
    flashTween.Completed:Connect(function()
        flashLight:Destroy()
    end)
end

-- 🎆 FIREWORKS
function VisualEffectsManager:CreateFireworks(intensity)
    local fireworksCount = math.ceil(intensity * 3)
    
    for i = 1, fireworksCount do
        local firework = Instance.new("Part")
        firework.Name = "Firework"
        firework.Size = Vector3.new(1, 1, 1)
        firework.Position = Vector3.new(
            math.random(-30, 30),
            30,
            math.random(-30, 30)
        )
        firework.BrickColor = BrickColor.new(Color3.fromRGB(
            math.random(100, 255),
            math.random(100, 255),
            math.random(100, 255)
        ))
        firework.Material = Enum.Material.Neon
        firework.CanCollide = false
        firework.Parent = self.ParticleEffects
        
        -- 🎆 EXPLOSION EFFECT
        local explosion = Instance.new("Explosion")
        explosion.Position = firework.Position
        explosion.BlastRadius = 20
        explosion.BlastPressure = 0
        explosion.Parent = workspace
        
        -- 🗑️ CLEANUP
        spawn(function()
            wait(1)
            firework:Destroy()
        end)
    end
end

-- 💖 HEART PARTICLES
function VisualEffectsManager:CreateHeartParticles(intensity)
    local heartArea = Instance.new("Part")
    heartArea.Name = "HeartArea"
    heartArea.Size = Vector3.new(50, 1, 50)
    heartArea.Position = Vector3.new(0, 10, 0)
    heartArea.Anchored = true
    heartArea.CanCollide = false
    heartArea.Transparency = 1
    heartArea.Parent = self.ParticleEffects
    
    -- 💖 HEART EMITTER
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxasset://textures/particles/heart.png"
    emitter.Lifetime = NumberRange.new(3, 5)
    emitter.Rate = intensity * 30
    emitter.SpreadAngle = Vector2.new(45, 45)
    emitter.Speed = NumberRange.new(3, 8)
    emitter.Color = ColorSequence.new(EFFECTS_CONFIG.COLORS.LOVE)
    emitter.Parent = heartArea
    
    -- 🗑️ CLEANUP
    spawn(function()
        wait(5)
        heartArea:Destroy()
    end)
end

-- 🌹 ROSE PETALS
function VisualEffectsManager:CreateRosePetals(intensity)
    local petalArea = Instance.new("Part")
    petalArea.Name = "PetalArea"
    petalArea.Size = Vector3.new(80, 1, 80)
    petalArea.Position = Vector3.new(0, 15, 0)
    petalArea.Anchored = true
    petalArea.CanCollide = false
    petalArea.Transparency = 1
    petalArea.Parent = self.ParticleEffects
    
    -- 🌹 PETAL EMITTER
    local emitter = self:CreateParticleEffect("ROSE_PETALS", petalArea, {
        Rate = intensity * 20,
        Duration = 8
    })
    
    -- 🗑️ CLEANUP
    spawn(function()
        wait(8)
        petalArea:Destroy()
    end)
end

-- 🎵 WEATHER EFFECTS

-- 🌧️ RAIN EFFECT
function VisualEffectsManager:CreateRainEffect(intensity)
    if self.WeatherEffects.Rain then
        self:StopRainEffect()
    end
    
    local rainArea = Instance.new("Part")
    rainArea.Name = "RainArea"
    rainArea.Size = Vector3.new(200, 1, 200)
    rainArea.Position = Vector3.new(0, 50, 0)
    rainArea.Anchored = true
    rainArea.CanCollide = false
    rainArea.Transparency = 1
    rainArea.Parent = self.WeatherEffects
    
    -- 🌧️ RAIN EMITTER
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxasset://textures/particles/rain.png"
    emitter.Lifetime = NumberRange.new(2, 3)
    emitter.Rate = intensity * 100
    emitter.SpreadAngle = Vector2.new(5, 5)
    emitter.Speed = NumberRange.new(20, 30)
    emitter.Color = ColorSequence.new(EFFECTS_CONFIG.COLORS.WATER)
    emitter.Parent = rainArea
    
    self.WeatherEffects.Rain = rainArea
    
    -- 🎵 RAIN SOUND
    local rainSound = Instance.new("Sound")
    rainSound.SoundId = "rbxasset://sounds/rain_ambient.mp3"
    rainSound.Volume = intensity * 0.5
    rainSound.Looped = true
    rainSound.Parent = rainArea
    rainSound:Play()
    
    print("🌧️ Rain effect created with intensity:", intensity)
end

-- ❄️ SNOW EFFECT
function VisualEffectsManager:CreateSnowEffect(intensity)
    if self.WeatherEffects.Snow then
        self:StopSnowEffect()
    end
    
    local snowArea = Instance.new("Part")
    snowArea.Name = "SnowArea"
    snowArea.Size = Vector3.new(200, 1, 200)
    snowArea.Position = Vector3.new(0, 50, 0)
    snowArea.Anchored = true
    snowArea.CanCollide = false
    snowArea.Transparency = 1
    snowArea.Parent = self.WeatherEffects
    
    -- ❄️ SNOW EMITTER
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxasset://textures/particles/snow.png"
    emitter.Lifetime = NumberRange.new(5, 8)
    emitter.Rate = intensity * 50
    emitter.SpreadAngle = Vector2.new(30, 30)
    emitter.Speed = NumberRange.new(2, 5)
    emitter.Color = ColorSequence.new(EFFECTS_CONFIG.COLORS.ICE)
    emitter.Parent = snowArea
    
    self.WeatherEffects.Snow = snowArea
    
    print("❄️ Snow effect created with intensity:", intensity)
end

-- 🌊 AMBIENT LIGHTING SETUP
function VisualEffectsManager:SetupAmbientLighting()
    -- 🎨 AMBIENT SETTINGS
    Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    Lighting.Brightness = 1.5
    Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
    Lighting.ColorShift_Bottom = Color3.fromRGB(100, 100, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
    
    -- 🌟 ATMOSPHERIC EFFECTS
    local atmosphere = Instance.new("Atmosphere")
    atmosphere.Density = 0.3
    atmosphere.Offset = 0.25
    atmosphere.Color = Color3.fromRGB(199, 199, 199)
    atmosphere.Decay = Color3.fromRGB(106, 112, 125)
    atmosphere.Glare = 0.2
    atmosphere.Haze = 1.7
    atmosphere.Parent = Lighting
    
    print("🌊 Ambient lighting configured")
end

-- 🎭 DYNAMIC LIGHTING SETUP
function VisualEffectsManager:SetupDynamicLighting()
    -- 🎯 LIGHTING CONTROLLER
    spawn(function()
        while true do
            wait(0.1) -- Update lighting 10 times per second
            
            -- 🌟 UPDATE DYNAMIC LIGHTS
            for _, light in ipairs(self.LightingManager.DynamicLights) do
                if light.Parent then
                    -- 🎨 PERFORMANCE-BASED ADJUSTMENTS
                    local players = #game.Players:GetPlayers()
                    if players > 20 then
                        light.Shadows = false
                    else
                        light.Shadows = true
                    end
                end
            end
        end
    end)
end

-- 🎨 POST-PROCESSING EFFECT CREATION
function VisualEffectsManager:CreatePostProcessEffect(effectName, effectData)
    local effect = Instance.new(effectData.ClassName)
    effect.Name = effectName
    
    -- 🎯 APPLY PROPERTIES
    for property, value in pairs(effectData.Properties) do
        if effect:FindFirstChild(property) or pcall(function() effect[property] = value end) then
            effect[property] = value
        end
    end
    
    effect.Parent = self.PostProcessContainer
    
    -- 📊 REGISTER EFFECT
    self.PostProcessManager.EffectStack[effectName] = effect
    
    print("🎨 Post-processing effect created:", effectName)
    return effect
end

-- 🎪 CINEMATIC CAMERA EFFECTS
function VisualEffectsManager:CreateCinematicShake(intensity, duration)
    local camera = workspace.CurrentCamera
    local originalCFrame = camera.CFrame
    
    local shakeConnection
    shakeConnection = RunService.Heartbeat:Connect(function()
        local shakeX = math.random(-intensity, intensity) / 10
        local shakeY = math.random(-intensity, intensity) / 10
        local shakeZ = math.random(-intensity, intensity) / 10
        
        camera.CFrame = originalCFrame * CFrame.new(shakeX, shakeY, shakeZ)
    end)
    
    -- 🎭 STOP SHAKE AFTER DURATION
    spawn(function()
        wait(duration)
        if shakeConnection then
            shakeConnection:Disconnect()
        end
        
        -- 🎯 SMOOTH RETURN TO ORIGINAL
        local returnTween = TweenService:Create(camera, TweenInfo.new(0.5), {
            CFrame = originalCFrame
        })
        returnTween:Play()
    end)
    
    print("🎪 Cinematic shake created - Intensity:", intensity, "Duration:", duration)
end

-- ⚡ PERFORMANCE MONITORING
function VisualEffectsManager:SetupPerformanceMonitoring()
    spawn(function()
        while true do
            wait(5) -- Check every 5 seconds
            
            -- 🎯 PARTICLE BUDGET MANAGEMENT
            local activeParticles = 0
            for _, effect in ipairs(self.EffectsState.ActiveEffects) do
                if effect.Emitter and effect.Emitter.Parent then
                    activeParticles = activeParticles + (effect.Emitter.Rate or 0)
                end
            end
            
            -- 🎨 PERFORMANCE ADJUSTMENTS
            if activeParticles > EFFECTS_CONFIG.PARTICLE_BUDGET * 0.8 then
                self:OptimizeParticlePerformance()
            end
            
            -- 📊 CLEANUP EXPIRED EFFECTS
            self:CleanupExpiredEffects()
        end
    end)
end

-- 🎯 PARTICLE BUDGET UPDATE
function VisualEffectsManager:UpdateParticleBudget()
    self.ParticleManager.UsedBudget = 0
    
    for _, effect in ipairs(self.EffectsState.ActiveEffects) do
        if effect.Emitter and effect.Emitter.Parent then
            self.ParticleManager.UsedBudget = self.ParticleManager.UsedBudget + (effect.Emitter.Rate or 0)
        end
    end
    
    -- 🎨 BUDGET WARNING
    if self.ParticleManager.UsedBudget > EFFECTS_CONFIG.PARTICLE_BUDGET * 0.9 then
        warn("⚡ Particle budget near limit:", self.ParticleManager.UsedBudget, "/", EFFECTS_CONFIG.PARTICLE_BUDGET)
    end
end

-- 🎨 OPTIMIZE PARTICLE PERFORMANCE
function VisualEffectsManager:OptimizeParticlePerformance()
    -- 🎯 REDUCE PARTICLE RATES
    for _, effect in ipairs(self.EffectsState.ActiveEffects) do
        if effect.Emitter and effect.Emitter.Parent then
            effect.Emitter.Rate = math.max(1, effect.Emitter.Rate * 0.7)
        end
    end
    
    print("🎨 Particle performance optimized")
end

-- 🧹 CLEANUP EXPIRED EFFECTS
function VisualEffectsManager:CleanupExpiredEffects()
    local currentTime = tick()
    
    for i = #self.EffectsState.ActiveEffects, 1, -1 do
        local effect = self.EffectsState.ActiveEffects[i]
        
        if currentTime - effect.StartTime > effect.Duration then
            -- 🎯 DISABLE EMITTER
            if effect.Emitter and effect.Emitter.Parent then
                effect.Emitter.Enabled = false
            end
            
            -- 🗑️ REMOVE FROM ACTIVE LIST
            table.remove(self.EffectsState.ActiveEffects, i)
        end
    end
end

-- 🎵 SOUND EFFECTS
function VisualEffectsManager:PlayReactionSound(soundType, intensity)
    local sound = Instance.new("Sound")
    sound.Volume = math.min(1, intensity * 0.5)
    sound.Parent = workspace
    
    if soundType == "applause" then
        sound.SoundId = "rbxasset://sounds/applause.mp3"
    elseif soundType == "cheer" then
        sound.SoundId = "rbxasset://sounds/cheer.mp3"
    elseif soundType == "gasp" then
        sound.SoundId = "rbxasset://sounds/gasp.mp3"
    end
    
    sound:Play()
    
    -- 🗑️ CLEANUP
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- 🎨 THEME-BASED EFFECTS
function VisualEffectsManager:ApplyThemeEffects(theme)
    if theme == "CYBERPUNK_FUTURE" then
        self:CreateCyberpunkEffects()
    elseif theme == "ELEGANT_CLASSICAL" then
        self:CreateClassicalEffects()
    elseif theme == "URBAN_STREET" then
        self:CreateUrbanEffects()
    elseif theme == "NATURE_HARMONY" then
        self:CreateNatureEffects()
    elseif theme == "FANTASY_MAGICAL" then
        self:CreateMagicalEffects()
    end
    
    print("🎨 Theme effects applied:", theme)
end

-- 🌐 CYBERPUNK EFFECTS
function VisualEffectsManager:CreateCyberpunkEffects()
    -- 🎯 HOLOGRAPHIC GRID
    local gridEffect = Instance.new("Part")
    gridEffect.Name = "HolographicGrid"
    gridEffect.Size = Vector3.new(200, 0.1, 200)
    gridEffect.Position = Vector3.new(0, 0, 0)
    gridEffect.Anchored = true
    gridEffect.Material = Enum.Material.Neon
    gridEffect.BrickColor = BrickColor.new(Color3.fromRGB(0, 255, 255))
    gridEffect.Transparency = 0.5
    gridEffect.Parent = self.EnvironmentalEffects
    
    -- ⚡ ELECTRIC PARTICLES
    local electricArea = Instance.new("Part")
    electricArea.Name = "ElectricArea"
    electricArea.Size = Vector3.new(100, 1, 100)
    electricArea.Position = Vector3.new(0, 10, 0)
    electricArea.Anchored = true
    electricArea.CanCollide = false
    electricArea.Transparency = 1
    electricArea.Parent = self.EnvironmentalEffects
    
    local electricEmitter = Instance.new("ParticleEmitter")
    electricEmitter.Texture = "rbxasset://textures/particles/electric.png"
    electricEmitter.Lifetime = NumberRange.new(1, 3)
    electricEmitter.Rate = 50
    electricEmitter.SpreadAngle = Vector2.new(180, 180)
    electricEmitter.Speed = NumberRange.new(5, 15)
    electricEmitter.Color = ColorSequence.new(EFFECTS_CONFIG.COLORS.ELECTRIC)
    electricEmitter.Parent = electricArea
end

-- 🏛️ CLASSICAL EFFECTS
function VisualEffectsManager:CreateClassicalEffects()
    -- ✨ GOLDEN SPARKLES
    local sparkleArea = Instance.new("Part")
    sparkleArea.Name = "GoldenSparkles"
    sparkleArea.Size = Vector3.new(80, 1, 80)
    sparkleArea.Position = Vector3.new(0, 5, 0)
    sparkleArea.Anchored = true
    sparkleArea.CanCollide = false
    sparkleArea.Transparency = 1
    sparkleArea.Parent = self.EnvironmentalEffects
    
    local sparkleEmitter = Instance.new("ParticleEmitter")
    sparkleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    sparkleEmitter.Lifetime = NumberRange.new(3, 5)
    sparkleEmitter.Rate = 30
    sparkleEmitter.SpreadAngle = Vector2.new(45, 45)
    sparkleEmitter.Speed = NumberRange.new(2, 6)
    sparkleEmitter.Color = ColorSequence.new(EFFECTS_CONFIG.COLORS.GOLD)
    sparkleEmitter.Parent = sparkleArea
end

-- 🌟 MAGICAL EFFECTS
function VisualEffectsManager:CreateMagicalEffects()
    -- 🎭 MAGIC AURA
    local auraArea = Instance.new("Part")
    auraArea.Name = "MagicAura"
    auraArea.Size = Vector3.new(60, 1, 60)
    auraArea.Position = Vector3.new(0, 8, 0)
    auraArea.Anchored = true
    auraArea.CanCollide = false
    auraArea.Transparency = 1
    auraArea.Parent = self.EnvironmentalEffects
    
    local auraEmitter = self:CreateParticleEffect("MAGIC_AURA", auraArea, {
        Rate = 40,
        Duration = 999
    })
    
    -- 🌟 FLOATING ORBS
    for i = 1, 5 do
        local orb = Instance.new("Part")
        orb.Name = "MagicOrb"
        orb.Size = Vector3.new(2, 2, 2)
        orb.Position = Vector3.new(
            math.random(-20, 20),
            math.random(5, 15),
            math.random(-20, 20)
        )
        orb.Shape = Enum.PartType.Ball
        orb.Material = Enum.Material.Neon
        orb.BrickColor = BrickColor.new(EFFECTS_CONFIG.COLORS.MAGIC)
        orb.Anchored = true
        orb.CanCollide = false
        orb.Parent = self.EnvironmentalEffects
        
        -- 🎭 FLOATING ANIMATION
        local floatTween = TweenService:Create(orb, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Position = orb.Position + Vector3.new(0, 5, 0)
        })
        floatTween:Play()
    end
end

-- 🎯 CLEANUP
function VisualEffectsManager:Cleanup()
    -- 🎭 STOP ALL EFFECTS
    for _, effect in ipairs(self.EffectsState.ActiveEffects) do
        if effect.Emitter and effect.Emitter.Parent then
            effect.Emitter.Enabled = false
        end
    end
    
    -- 🗑️ DESTROY CONTAINERS
    if self.EffectsContainer then
        self.EffectsContainer:Destroy()
    end
    
    if self.PostProcessContainer then
        self.PostProcessContainer:Destroy()
    end
    
    print("✨ Visual Effects Manager cleaned up")
end

-- 🎯 EXPORT MODULE
return VisualEffectsManager