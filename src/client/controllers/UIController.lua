--[[
    🎨 FASHION REVOLUTION - UI Controller
    Contrôleur de l'interface utilisateur côté client
]]

local UIController = {}

function UIController.Initialize()
    print("🎨 UI Controller initialized")
end

function UIController.ShowInterface(interfaceName)
    print("📱 Showing interface:", interfaceName)
end

function UIController.HideInterface(interfaceName)
    print("🚫 Hiding interface:", interfaceName)
end

return UIController