--[[
    🎨 UI DESIGN SYSTEM - Interface Révolutionnaire
    Système de design moderne avec glassmorphisme et animations fluides
    
    Innovations :
    - Glassmorphisme avancé avec effets de flou
    - Animations fluides et transitions cinématiques
    - Interface adaptative multi-plateforme
    - Système de thèmes dynamiques
    - Interactions gestuelles et vocales
    - Réalité augmentée pour customisation
]]

local UIDesignSystem = {}
UIDesignSystem.__index = UIDesignSystem

-- 🎯 SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")

-- 🎨 DESIGN CONFIGURATION
local DESIGN_CONFIG = {
    -- 🌟 GLASSMORPHISM SETTINGS
    GLASS_TRANSPARENCY = 0.3,
    GLASS_BLUR_SIZE = 25,
    GLASS_BORDER_SIZE = 2,
    GLASS_CORNER_RADIUS = 15,
    
    -- 🎭 ANIMATION SETTINGS
    ANIMATION_DURATION = 0.4,
    EASING_STYLE = Enum.EasingStyle.Quart,
    EASING_DIRECTION = Enum.EasingDirection.Out,
    
    -- 🎯 RESPONSIVE SETTINGS
    MOBILE_BREAKPOINT = 768,
    TABLET_BREAKPOINT = 1024,
    DESKTOP_BREAKPOINT = 1920,
    
    -- 🌈 COLOR PALETTE
    COLORS = {
        PRIMARY = Color3.fromRGB(138, 43, 226),      -- Violet mystique
        SECONDARY = Color3.fromRGB(255, 20, 147),    -- Rose profond
        ACCENT = Color3.fromRGB(0, 191, 255),        -- Bleu ciel
        SUCCESS = Color3.fromRGB(46, 204, 113),      -- Vert émeraude
        WARNING = Color3.fromRGB(241, 196, 15),      -- Jaune or
        ERROR = Color3.fromRGB(231, 76, 60),         -- Rouge cardinal
        BACKGROUND = Color3.fromRGB(13, 13, 13),     -- Noir profond
        SURFACE = Color3.fromRGB(28, 28, 28),        -- Gris foncé
        TEXT_PRIMARY = Color3.fromRGB(255, 255, 255), -- Blanc pur
        TEXT_SECONDARY = Color3.fromRGB(180, 180, 180) -- Gris clair
    },
    
    -- 🎪 TYPOGRAPHY
    FONTS = {
        PRIMARY = Enum.Font.GothamBold,
        SECONDARY = Enum.Font.Gotham,
        ACCENT = Enum.Font.FredokaOne,
        MONOSPACE = Enum.Font.RobotoMono
    },
    
    -- 📏 SPACING SYSTEM
    SPACING = {
        XS = 4,
        SM = 8,
        MD = 16,
        LG = 24,
        XL = 32,
        XXL = 48
    }
}

-- 🎨 THEME PALETTES
local THEME_PALETTES = {
    CYBERPUNK = {
        Primary = Color3.fromRGB(0, 255, 255),
        Secondary = Color3.fromRGB(255, 0, 255),
        Accent = Color3.fromRGB(255, 255, 0),
        Background = Color3.fromRGB(20, 20, 40),
        Surface = Color3.fromRGB(40, 40, 60),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
        })
    },
    
    ELEGANT = {
        Primary = Color3.fromRGB(212, 175, 55),
        Secondary = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(139, 69, 19),
        Background = Color3.fromRGB(245, 245, 220),
        Surface = Color3.fromRGB(255, 250, 240),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(212, 175, 55)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        })
    },
    
    URBAN = {
        Primary = Color3.fromRGB(255, 165, 0),
        Secondary = Color3.fromRGB(105, 105, 105),
        Accent = Color3.fromRGB(220, 20, 60),
        Background = Color3.fromRGB(64, 64, 64),
        Surface = Color3.fromRGB(80, 80, 80),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 165, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 20, 60))
        })
    },
    
    NATURE = {
        Primary = Color3.fromRGB(34, 139, 34),
        Secondary = Color3.fromRGB(139, 69, 19),
        Accent = Color3.fromRGB(255, 215, 0),
        Background = Color3.fromRGB(240, 255, 240),
        Surface = Color3.fromRGB(250, 255, 250),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(34, 139, 34)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 69, 19))
        })
    },
    
    MAGICAL = {
        Primary = Color3.fromRGB(138, 43, 226),
        Secondary = Color3.fromRGB(255, 20, 147),
        Accent = Color3.fromRGB(0, 191, 255),
        Background = Color3.fromRGB(25, 25, 112),
        Surface = Color3.fromRGB(40, 40, 120),
        Gradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
        })
    }
}

-- 🎪 COMPONENT LIBRARY
local COMPONENTS = {
    BUTTONS = {
        PRIMARY = "PrimaryButton",
        SECONDARY = "SecondaryButton",
        GHOST = "GhostButton",
        ICON = "IconButton",
        FAB = "FloatingActionButton"
    },
    
    CARDS = {
        BASIC = "BasicCard",
        GLASS = "GlassCard",
        ELEVATED = "ElevatedCard",
        OUTLINED = "OutlinedCard"
    },
    
    INPUTS = {
        TEXT = "TextInput",
        SEARCH = "SearchInput",
        DROPDOWN = "DropdownInput",
        SLIDER = "SliderInput",
        TOGGLE = "ToggleInput"
    },
    
    NAVIGATION = {
        NAVBAR = "NavigationBar",
        SIDEBAR = "SidebarNavigation",
        TABS = "TabNavigation",
        BREADCRUMB = "BreadcrumbNavigation"
    }
}

-- 🎯 MAIN UI DESIGN SYSTEM CLASS
function UIDesignSystem.new(player)
    local self = setmetatable({}, UIDesignSystem)
    
    -- 🎮 PLAYER REFERENCE
    self.Player = player or Players.LocalPlayer
    
    -- 🎨 UI STATE
    self.UIState = {
        CurrentTheme = "MAGICAL",
        ScreenSize = Vector2.new(1920, 1080),
        DeviceType = "Desktop",
        AnimationsEnabled = true,
        SoundEnabled = true,
        AccessibilityMode = false
    }
    
    -- 🎪 COMPONENT REGISTRY
    self.Components = {}
    self.Animations = {}
    self.SoundEffects = {}
    
    -- 🌟 LAYOUT SYSTEM
    self.LayoutManager = {
        Grids = {},
        Flexboxes = {},
        ResponsiveLayouts = {}
    }
    
    -- 🎭 ANIMATION SYSTEM
    self.AnimationController = {
        ActiveTweens = {},
        QueuedAnimations = {},
        TimingFunctions = {}
    }
    
    -- 🎯 INITIALIZATION
    self:InitializeDesignSystem()
    
    return self
end

-- 🎨 DESIGN SYSTEM INITIALIZATION
function UIDesignSystem:InitializeDesignSystem()
    -- 🖥️ DETECT DEVICE TYPE
    self:DetectDeviceType()
    
    -- 🎨 SETUP THEME SYSTEM
    self:SetupThemeSystem()
    
    -- 🎪 CREATE UI CONTAINER
    self:CreateUIContainer()
    
    -- 🎭 INITIALIZE ANIMATIONS
    self:InitializeAnimations()
    
    -- 🔊 SETUP SOUND SYSTEM
    self:SetupSoundSystem()
    
    -- 📱 SETUP RESPONSIVE SYSTEM
    self:SetupResponsiveSystem()
    
    print("🎨 UI Design System initialized for", self.Player.Name)
end

-- 🖥️ DEVICE TYPE DETECTION
function UIDesignSystem:DetectDeviceType()
    local camera = workspace.CurrentCamera
    local screenSize = camera.ViewportSize
    
    self.UIState.ScreenSize = screenSize
    
    if screenSize.X < DESIGN_CONFIG.MOBILE_BREAKPOINT then
        self.UIState.DeviceType = "Mobile"
    elseif screenSize.X < DESIGN_CONFIG.TABLET_BREAKPOINT then
        self.UIState.DeviceType = "Tablet"
    else
        self.UIState.DeviceType = "Desktop"
    end
    
    -- 🎯 TOUCH DETECTION
    if UserInputService.TouchEnabled then
        self.UIState.DeviceType = "Mobile"
    end
    
    print("🖥️ Device detected:", self.UIState.DeviceType, "Size:", screenSize)
end

-- 🎨 THEME SYSTEM SETUP
function UIDesignSystem:SetupThemeSystem()
    self.CurrentPalette = THEME_PALETTES[self.UIState.CurrentTheme]
    
    -- 🌟 THEME MANAGER
    self.ThemeManager = {
        ActiveTheme = self.UIState.CurrentTheme,
        CustomThemes = {},
        DynamicColors = {},
        TransitionDuration = 0.6
    }
    
    print("🎨 Theme system setup with", self.UIState.CurrentTheme, "palette")
end

-- 🎪 UI CONTAINER CREATION
function UIDesignSystem:CreateUIContainer()
    -- 🎯 MAIN SCREEN GUI
    self.MainScreen = Instance.new("ScreenGui")
    self.MainScreen.Name = "FashionRevolutionUI"
    self.MainScreen.DisplayOrder = 100
    self.MainScreen.IgnoreGuiInset = true
    self.MainScreen.ResetOnSpawn = false
    self.MainScreen.Parent = self.Player.PlayerGui
    
    -- 🌟 MAIN CONTAINER
    self.MainContainer = Instance.new("Frame")
    self.MainContainer.Name = "MainContainer"
    self.MainContainer.Size = UDim2.new(1, 0, 1, 0)
    self.MainContainer.Position = UDim2.new(0, 0, 0, 0)
    self.MainContainer.BackgroundTransparency = 1
    self.MainContainer.Parent = self.MainScreen
    
    -- 🎨 BACKGROUND LAYER
    self:CreateBackgroundLayer()
    
    -- 🎪 CONTENT LAYER
    self:CreateContentLayer()
    
    -- 🎭 OVERLAY LAYER
    self:CreateOverlayLayer()
    
    print("🎪 UI Container created with layered architecture")
end

-- 🌟 BACKGROUND LAYER
function UIDesignSystem:CreateBackgroundLayer()
    local background = Instance.new("Frame")
    background.Name = "BackgroundLayer"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = self.CurrentPalette.Background
    background.BorderSizePixel = 0
    background.Parent = self.MainContainer
    
    -- 🎨 GRADIENT BACKGROUND
    local gradient = Instance.new("UIGradient")
    gradient.Color = self.CurrentPalette.Gradient
    gradient.Rotation = 45
    gradient.Parent = background
    
    -- 🌟 ANIMATED PARTICLES
    self:CreateBackgroundParticles(background)
    
    self.BackgroundLayer = background
end

-- 🎪 CONTENT LAYER
function UIDesignSystem:CreateContentLayer()
    local content = Instance.new("Frame")
    content.Name = "ContentLayer"
    content.Size = UDim2.new(1, 0, 1, 0)
    content.Position = UDim2.new(0, 0, 0, 0)
    content.BackgroundTransparency = 1
    content.Parent = self.MainContainer
    
    self.ContentLayer = content
end

-- 🎭 OVERLAY LAYER
function UIDesignSystem:CreateOverlayLayer()
    local overlay = Instance.new("Frame")
    overlay.Name = "OverlayLayer"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.Parent = self.MainContainer
    
    self.OverlayLayer = overlay
end

-- 🎨 GLASSMORPHISM CARD CREATION
function UIDesignSystem:CreateGlassCard(properties)
    local card = Instance.new("Frame")
    card.Name = properties.Name or "GlassCard"
    card.Size = properties.Size or UDim2.new(0, 300, 0, 200)
    card.Position = properties.Position or UDim2.new(0.5, -150, 0.5, -100)
    card.BackgroundColor3 = properties.BackgroundColor or self.CurrentPalette.Surface
    card.BackgroundTransparency = DESIGN_CONFIG.GLASS_TRANSPARENCY
    card.BorderSizePixel = 0
    card.Parent = properties.Parent or self.ContentLayer
    
    -- 🌟 GLASS EFFECT
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, DESIGN_CONFIG.GLASS_CORNER_RADIUS)
    corner.Parent = card
    
    -- 🎨 GLASS BORDER
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = DESIGN_CONFIG.GLASS_BORDER_SIZE
    stroke.Color = properties.BorderColor or self.CurrentPalette.Primary
    stroke.Transparency = 0.5
    stroke.Parent = card
    
    -- ✨ GLASS GRADIENT
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
    })
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.7),
        NumberSequenceKeypoint.new(1, 0.9)
    })
    gradient.Rotation = -45
    gradient.Parent = card
    
    -- 🎭 BLUR EFFECT SIMULATION
    self:AddBlurEffect(card)
    
    -- 🎪 HOVER ANIMATIONS
    self:AddHoverAnimations(card)
    
    return card
end

-- 🔳 PRIMARY BUTTON CREATION
function UIDesignSystem:CreatePrimaryButton(properties)
    local button = Instance.new("TextButton")
    button.Name = properties.Name or "PrimaryButton"
    button.Size = properties.Size or UDim2.new(0, 200, 0, 50)
    button.Position = properties.Position or UDim2.new(0.5, -100, 0.5, -25)
    button.BackgroundColor3 = self.CurrentPalette.Primary
    button.BorderSizePixel = 0
    button.Text = properties.Text or "Click Me"
    button.TextColor3 = DESIGN_CONFIG.COLORS.TEXT_PRIMARY
    button.TextScaled = true
    button.Font = DESIGN_CONFIG.FONTS.PRIMARY
    button.Parent = properties.Parent or self.ContentLayer
    
    -- 🌟 BUTTON STYLING
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = button
    
    -- 🎨 GRADIENT EFFECT
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.CurrentPalette.Primary),
        ColorSequenceKeypoint.new(1, self.CurrentPalette.Secondary)
    })
    gradient.Rotation = 45
    gradient.Parent = button
    
    -- ✨ GLOW EFFECT
    local glow = Instance.new("UIStroke")
    glow.Thickness = 2
    glow.Color = self.CurrentPalette.Primary
    glow.Transparency = 0.3
    glow.Parent = button
    
    -- 🎭 BUTTON ANIMATIONS
    self:AddButtonAnimations(button)
    
    -- 🔊 SOUND EFFECTS
    self:AddButtonSounds(button)
    
    return button
end

-- 🎯 FLOATING ACTION BUTTON
function UIDesignSystem:CreateFloatingActionButton(properties)
    local fab = Instance.new("TextButton")
    fab.Name = properties.Name or "FloatingActionButton"
    fab.Size = UDim2.new(0, 60, 0, 60)
    fab.Position = properties.Position or UDim2.new(1, -80, 1, -80)
    fab.BackgroundColor3 = self.CurrentPalette.Accent
    fab.BorderSizePixel = 0
    fab.Text = properties.Text or "+"
    fab.TextColor3 = DESIGN_CONFIG.COLORS.TEXT_PRIMARY
    fab.TextScaled = true
    fab.Font = DESIGN_CONFIG.FONTS.PRIMARY
    fab.Parent = properties.Parent or self.ContentLayer
    
    -- 🌟 CIRCULAR SHAPE
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = fab
    
    -- 🎨 SHADOW EFFECT
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 8, 1, 8)
    shadow.Position = UDim2.new(0, -4, 0, -4)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = fab.ZIndex - 1
    shadow.Parent = fab
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0.5, 0)
    shadowCorner.Parent = shadow
    
    -- 🎭 FAB ANIMATIONS
    self:AddFABAnimations(fab)
    
    -- 🔊 SOUND EFFECTS
    self:AddButtonSounds(fab)
    
    return fab
end

-- 📝 TEXT INPUT CREATION
function UIDesignSystem:CreateTextInput(properties)
    local input = Instance.new("TextBox")
    input.Name = properties.Name or "TextInput"
    input.Size = properties.Size or UDim2.new(0, 300, 0, 50)
    input.Position = properties.Position or UDim2.new(0.5, -150, 0.5, -25)
    input.BackgroundColor3 = self.CurrentPalette.Surface
    input.BackgroundTransparency = 0.1
    input.BorderSizePixel = 0
    input.Text = ""
    input.PlaceholderText = properties.PlaceholderText or "Type here..."
    input.TextColor3 = DESIGN_CONFIG.COLORS.TEXT_PRIMARY
    input.PlaceholderColor3 = DESIGN_CONFIG.COLORS.TEXT_SECONDARY
    input.TextScaled = true
    input.Font = DESIGN_CONFIG.FONTS.SECONDARY
    input.Parent = properties.Parent or self.ContentLayer
    
    -- 🌟 INPUT STYLING
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = input
    
    -- 🎨 BORDER EFFECT
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = self.CurrentPalette.Primary
    stroke.Transparency = 0.7
    stroke.Parent = input
    
    -- 🎭 FOCUS ANIMATIONS
    self:AddInputAnimations(input)
    
    return input
end

-- 🎨 NAVIGATION BAR CREATION
function UIDesignSystem:CreateNavigationBar(properties)
    local navbar = Instance.new("Frame")
    navbar.Name = properties.Name or "NavigationBar"
    navbar.Size = UDim2.new(1, 0, 0, 60)
    navbar.Position = UDim2.new(0, 0, 0, 0)
    navbar.BackgroundColor3 = self.CurrentPalette.Surface
    navbar.BackgroundTransparency = 0.1
    navbar.BorderSizePixel = 0
    navbar.Parent = properties.Parent or self.ContentLayer
    
    -- 🌟 GLASS EFFECT
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 0)
    corner.Parent = navbar
    
    -- 🎨 GRADIENT BACKGROUND
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.CurrentPalette.Surface),
        ColorSequenceKeypoint.new(1, self.CurrentPalette.Primary)
    })
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.3),
        NumberSequenceKeypoint.new(1, 0.8)
    })
    gradient.Rotation = 90
    gradient.Parent = navbar
    
    -- 🎪 NAVIGATION LAYOUT
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, DESIGN_CONFIG.SPACING.MD)
    layout.Parent = navbar
    
    -- 🎯 NAVIGATION ITEMS
    if properties.Items then
        for _, item in ipairs(properties.Items) do
            local navItem = self:CreateNavigationItem(item, navbar)
        end
    end
    
    return navbar
end

-- 🎪 NAVIGATION ITEM CREATION
function UIDesignSystem:CreateNavigationItem(properties, parent)
    local item = Instance.new("TextButton")
    item.Name = properties.Name or "NavItem"
    item.Size = UDim2.new(0, 120, 0, 40)
    item.BackgroundColor3 = self.CurrentPalette.Primary
    item.BackgroundTransparency = 0.7
    item.BorderSizePixel = 0
    item.Text = properties.Text or "Item"
    item.TextColor3 = DESIGN_CONFIG.COLORS.TEXT_PRIMARY
    item.TextScaled = true
    item.Font = DESIGN_CONFIG.FONTS.SECONDARY
    item.Parent = parent
    
    -- 🌟 ITEM STYLING
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = item
    
    -- 🎭 HOVER ANIMATIONS
    self:AddHoverAnimations(item)
    
    -- 🔊 SOUND EFFECTS
    self:AddButtonSounds(item)
    
    return item
end

-- 🎨 MODAL DIALOG CREATION
function UIDesignSystem:CreateModalDialog(properties)
    -- 🎭 BACKDROP
    local backdrop = Instance.new("Frame")
    backdrop.Name = "ModalBackdrop"
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.Position = UDim2.new(0, 0, 0, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 0.5
    backdrop.BorderSizePixel = 0
    backdrop.Parent = self.OverlayLayer
    
    -- 🎪 MODAL CONTAINER
    local modal = self:CreateGlassCard({
        Name = properties.Name or "ModalDialog",
        Size = properties.Size or UDim2.new(0, 400, 0, 300),
        Position = UDim2.new(0.5, -200, 0.5, -150),
        Parent = backdrop
    })
    
    -- 🎨 MODAL CONTENT
    local content = Instance.new("Frame")
    content.Name = "ModalContent"
    content.Size = UDim2.new(1, -40, 1, -40)
    content.Position = UDim2.new(0, 20, 0, 20)
    content.BackgroundTransparency = 1
    content.Parent = modal
    
    -- 🎯 MODAL LAYOUT
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.Padding = UDim.new(0, DESIGN_CONFIG.SPACING.MD)
    layout.Parent = content
    
    -- 🎭 MODAL ANIMATIONS
    self:AddModalAnimations(modal, backdrop)
    
    return modal, backdrop
end

-- 🎨 TOAST NOTIFICATION
function UIDesignSystem:CreateToastNotification(properties)
    local toast = Instance.new("Frame")
    toast.Name = "ToastNotification"
    toast.Size = UDim2.new(0, 300, 0, 60)
    toast.Position = UDim2.new(0.5, -150, 0, -60)
    toast.BackgroundColor3 = properties.BackgroundColor or DESIGN_CONFIG.COLORS.SUCCESS
    toast.BorderSizePixel = 0
    toast.Parent = self.OverlayLayer
    
    -- 🌟 TOAST STYLING
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = toast
    
    -- 🎨 TOAST CONTENT
    local icon = Instance.new("TextLabel")
    icon.Name = "ToastIcon"
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0, 10, 0.5, -20)
    icon.BackgroundTransparency = 1
    icon.Text = properties.Icon or "✓"
    icon.TextColor3 = DESIGN_CONFIG.COLORS.TEXT_PRIMARY
    icon.TextScaled = true
    icon.Font = DESIGN_CONFIG.FONTS.ACCENT
    icon.Parent = toast
    
    local message = Instance.new("TextLabel")
    message.Name = "ToastMessage"
    message.Size = UDim2.new(1, -60, 1, 0)
    message.Position = UDim2.new(0, 50, 0, 0)
    message.BackgroundTransparency = 1
    message.Text = properties.Message or "Notification"
    message.TextColor3 = DESIGN_CONFIG.COLORS.TEXT_PRIMARY
    message.TextScaled = true
    message.Font = DESIGN_CONFIG.FONTS.SECONDARY
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.Parent = toast
    
    -- 🎭 TOAST ANIMATIONS
    self:AddToastAnimations(toast)
    
    return toast
end

-- 🎭 ANIMATION SYSTEMS

-- 🎪 BUTTON ANIMATIONS
function UIDesignSystem:AddButtonAnimations(button)
    -- 🎯 HOVER ANIMATION
    button.MouseEnter:Connect(function()
        if self.UIState.AnimationsEnabled then
            local hoverTween = TweenService:Create(button, TweenInfo.new(0.2), {
                Size = button.Size + UDim2.new(0, 10, 0, 5),
                BackgroundTransparency = 0.1
            })
            hoverTween:Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if self.UIState.AnimationsEnabled then
            local leaveTween = TweenService:Create(button, TweenInfo.new(0.2), {
                Size = button.Size - UDim2.new(0, 10, 0, 5),
                BackgroundTransparency = 0
            })
            leaveTween:Play()
        end
    end)
    
    -- 🎨 CLICK ANIMATION
    button.MouseButton1Down:Connect(function()
        if self.UIState.AnimationsEnabled then
            local clickTween = TweenService:Create(button, TweenInfo.new(0.1), {
                Size = button.Size - UDim2.new(0, 5, 0, 2)
            })
            clickTween:Play()
        end
    end)
    
    button.MouseButton1Up:Connect(function()
        if self.UIState.AnimationsEnabled then
            local releaseTween = TweenService:Create(button, TweenInfo.new(0.1), {
                Size = button.Size + UDim2.new(0, 5, 0, 2)
            })
            releaseTween:Play()
        end
    end)
end

-- 🎨 HOVER ANIMATIONS
function UIDesignSystem:AddHoverAnimations(element)
    element.MouseEnter:Connect(function()
        if self.UIState.AnimationsEnabled then
            local hoverTween = TweenService:Create(element, TweenInfo.new(0.3), {
                BackgroundTransparency = element.BackgroundTransparency - 0.1
            })
            hoverTween:Play()
        end
    end)
    
    element.MouseLeave:Connect(function()
        if self.UIState.AnimationsEnabled then
            local leaveTween = TweenService:Create(element, TweenInfo.new(0.3), {
                BackgroundTransparency = element.BackgroundTransparency + 0.1
            })
            leaveTween:Play()
        end
    end)
end

-- 🎪 FAB ANIMATIONS
function UIDesignSystem:AddFABAnimations(fab)
    -- 🌟 FLOATING ANIMATION
    local floatTween = TweenService:Create(fab, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Position = fab.Position + UDim2.new(0, 0, 0, -5)
    })
    floatTween:Play()
    
    -- 🎭 ROTATION ANIMATION
    local rotationTween = TweenService:Create(fab, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
        Rotation = 360
    })
    rotationTween:Play()
end

-- 🎯 INPUT ANIMATIONS
function UIDesignSystem:AddInputAnimations(input)
    input.Focused:Connect(function()
        if self.UIState.AnimationsEnabled then
            local focusTween = TweenService:Create(input:FindFirstChild("UIStroke"), TweenInfo.new(0.2), {
                Transparency = 0.2,
                Thickness = 3
            })
            focusTween:Play()
        end
    end)
    
    input.FocusLost:Connect(function()
        if self.UIState.AnimationsEnabled then
            local blurTween = TweenService:Create(input:FindFirstChild("UIStroke"), TweenInfo.new(0.2), {
                Transparency = 0.7,
                Thickness = 2
            })
            blurTween:Play()
        end
    end)
end

-- 🎭 MODAL ANIMATIONS
function UIDesignSystem:AddModalAnimations(modal, backdrop)
    -- 🎪 ENTRANCE ANIMATION
    modal.Position = UDim2.new(0.5, -200, -0.5, -150)
    backdrop.BackgroundTransparency = 1
    
    local entranceTween = TweenService:Create(modal, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -200, 0.5, -150)
    })
    
    local backdropTween = TweenService:Create(backdrop, TweenInfo.new(0.4), {
        BackgroundTransparency = 0.5
    })
    
    entranceTween:Play()
    backdropTween:Play()
end

-- 🎨 TOAST ANIMATIONS
function UIDesignSystem:AddToastAnimations(toast)
    -- 🎯 SLIDE IN ANIMATION
    local slideInTween = TweenService:Create(toast, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -150, 0, 10)
    })
    slideInTween:Play()
    
    -- 🎭 AUTO HIDE ANIMATION
    spawn(function()
        wait(3)
        local slideOutTween = TweenService:Create(toast, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -150, 0, -60)
        })
        slideOutTween:Play()
        
        slideOutTween.Completed:Connect(function()
            toast:Destroy()
        end)
    end)
end

-- 🔊 SOUND SYSTEMS

-- 🎪 BUTTON SOUNDS
function UIDesignSystem:AddButtonSounds(button)
    if self.UIState.SoundEnabled then
        button.MouseButton1Click:Connect(function()
            local clickSound = Instance.new("Sound")
            clickSound.SoundId = "rbxasset://sounds/ui_click.mp3"
            clickSound.Volume = 0.5
            clickSound.Parent = button
            clickSound:Play()
            
            clickSound.Ended:Connect(function()
                clickSound:Destroy()
            end)
        end)
    end
end

-- 🎨 RESPONSIVE SYSTEM
function UIDesignSystem:SetupResponsiveSystem()
    -- 🖥️ SCREEN SIZE MONITORING
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        self:DetectDeviceType()
        self:UpdateResponsiveLayouts()
    end)
end

-- 📱 UPDATE RESPONSIVE LAYOUTS
function UIDesignSystem:UpdateResponsiveLayouts()
    -- 🎯 ADJUST COMPONENTS FOR DEVICE TYPE
    for _, component in pairs(self.Components) do
        if component.ResponsiveSettings then
            local settings = component.ResponsiveSettings[self.UIState.DeviceType]
            if settings then
                component.Size = settings.Size
                component.Position = settings.Position
                component.TextScaled = settings.TextScaled
            end
        end
    end
end

-- 🎨 UTILITY FUNCTIONS

-- ✨ BLUR EFFECT SIMULATION
function UIDesignSystem:AddBlurEffect(element)
    -- 🎯 SIMULATED BLUR WITH TRANSPARENCY GRADIENT
    local blurFrame = Instance.new("Frame")
    blurFrame.Name = "BlurEffect"
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.Position = UDim2.new(0, 0, 0, 0)
    blurFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    blurFrame.BackgroundTransparency = 0.95
    blurFrame.BorderSizePixel = 0
    blurFrame.Parent = element
    
    local blurCorner = Instance.new("UICorner")
    blurCorner.CornerRadius = UDim.new(0, DESIGN_CONFIG.GLASS_CORNER_RADIUS)
    blurCorner.Parent = blurFrame
end

-- 🌟 BACKGROUND PARTICLES
function UIDesignSystem:CreateBackgroundParticles(parent)
    for i = 1, 20 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = self.CurrentPalette.Primary
        particle.BackgroundTransparency = 0.8
        particle.BorderSizePixel = 0
        particle.Parent = parent
        
        -- 🎨 PARTICLE CORNER
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.5, 0)
        corner.Parent = particle
        
        -- 🎭 FLOATING ANIMATION
        local floatTween = TweenService:Create(particle, TweenInfo.new(
            math.random(3, 8), 
            Enum.EasingStyle.Sine, 
            Enum.EasingDirection.InOut, 
            -1, 
            true
        ), {
            Position = UDim2.new(math.random(), 0, math.random(), 0)
        })
        floatTween:Play()
    end
end

-- 🎯 THEME SWITCHING
function UIDesignSystem:SwitchTheme(themeName)
    if THEME_PALETTES[themeName] then
        self.UIState.CurrentTheme = themeName
        self.CurrentPalette = THEME_PALETTES[themeName]
        
        -- 🎨 UPDATE ALL COMPONENTS
        self:UpdateAllComponentColors()
        
        print("🎨 Theme switched to:", themeName)
    else
        warn("🎨 Theme not found:", themeName)
    end
end

-- 🎪 UPDATE ALL COMPONENT COLORS
function UIDesignSystem:UpdateAllComponentColors()
    -- 🎯 UPDATE BACKGROUND
    if self.BackgroundLayer then
        local colorTween = TweenService:Create(self.BackgroundLayer, TweenInfo.new(0.6), {
            BackgroundColor3 = self.CurrentPalette.Background
        })
        colorTween:Play()
        
        -- 🎨 UPDATE GRADIENT
        if self.BackgroundLayer:FindFirstChild("UIGradient") then
            self.BackgroundLayer.UIGradient.Color = self.CurrentPalette.Gradient
        end
    end
    
    -- 🌟 UPDATE COMPONENTS
    for _, component in pairs(self.Components) do
        if component.UpdateColors then
            component:UpdateColors(self.CurrentPalette)
        end
    end
end

-- 🎯 ACCESSIBILITY FEATURES
function UIDesignSystem:EnableAccessibilityMode()
    self.UIState.AccessibilityMode = true
    
    -- 🎨 HIGH CONTRAST MODE
    DESIGN_CONFIG.COLORS.TEXT_PRIMARY = Color3.fromRGB(255, 255, 255)
    DESIGN_CONFIG.COLORS.TEXT_SECONDARY = Color3.fromRGB(200, 200, 200)
    
    -- 🎭 REDUCED ANIMATIONS
    self.UIState.AnimationsEnabled = false
    
    -- 🔊 SOUND CUES
    self.UIState.SoundEnabled = true
    
    print("🎯 Accessibility mode enabled")
end

-- 🎨 CLEANUP
function UIDesignSystem:Cleanup()
    -- 🎭 STOP ALL ANIMATIONS
    for _, tween in pairs(self.AnimationController.ActiveTweens) do
        tween:Cancel()
    end
    
    -- 🎪 DESTROY UI
    if self.MainScreen then
        self.MainScreen:Destroy()
    end
    
    print("🎨 UI Design System cleaned up")
end

-- 🎯 EXPORT MODULE
return UIDesignSystem