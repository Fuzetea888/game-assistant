# 🚀 FASHION REVOLUTION - Configuration Rojo

## 📦 Installation de Rojo

### Option 1: Installation avec npm (Recommandée)
```bash
npm install -g rojo
```

### Option 2: Installation avec Aftman
```bash
# Installer Aftman d'abord
curl -L -o aftman.zip https://github.com/LPGhatguy/aftman/releases/latest/download/aftman-linux.zip
unzip aftman.zip
chmod +x aftman
sudo mv aftman /usr/local/bin/

# Installer Rojo avec Aftman
aftman add rojo-rbx/rojo@7.4.0
aftman install
```

### Option 3: Téléchargement Manuel
```bash
# Télécharger depuis GitHub Releases
wget https://github.com/rojo-rbx/rojo/releases/latest/download/rojo-linux.zip
unzip rojo-linux.zip
chmod +x rojo
sudo mv rojo /usr/local/bin/
```

## 🎮 Démarrage du Projet

### 1. Vérifier l'Installation
```bash
rojo --version
# Should output: Rojo 7.x.x
```

### 2. Lancer le Serveur Rojo
```bash
# Dans le dossier fashion-revolution/
rojo serve

# Ou avec port spécifique
rojo serve --port 34872
```

### 3. Dans Roblox Studio

1. **Installer le Plugin Rojo**
   - Aller sur https://roblox.com/library/13916111004/Rojo
   - Cliquer "Get" pour installer le plugin

2. **Connecter au Serveur**
   - Ouvrir Roblox Studio
   - Aller dans l'onglet "Plugins"
   - Cliquer sur l'icône Rojo
   - Se connecter à `localhost:34872`

3. **Synchroniser le Projet**
   - Cliquer "Sync In" dans le panneau Rojo
   - Tous les modules Fashion Revolution seront importés

4. **Tester le Jeu**
   - Appuyer F5 pour lancer le jeu
   - Vérifier que les systèmes s'initialisent dans la console

## 📁 Structure du Projet Synchronized

Après synchronisation, votre projet Roblox aura cette structure :

```
📁 ReplicatedStorage
  └── 📁 FashionRevolutionModules
      ├── 📁 Core
      │   ├── 📄 MapGenerator
      │   ├── 📄 AIFashionGenerator
      │   ├── 📄 CinematicRunway
      │   ├── 📄 SocialCompetition
      │   ├── 📄 CreatorEconomy
      │   ├── 📄 VisualEffectsManager
      │   └── 📄 AssetCreator
      ├── 📁 UI
      │   └── 📄 UIDesignSystem
      └── 📁 Shared
          ├── 📄 GameConfig
          ├── 📄 Constants
          └── 📄 Utils

📁 ServerScriptService
  └── 📁 FashionRevolutionServer
      ├── 📄 MainGame
      ├── 📄 GameInitializer
      ├── 📁 Services
      ├── 📁 DataStore
      └── 📁 Security

📁 StarterPlayer
  ├── 📁 StarterPlayerScripts
  │   └── 📁 FashionRevolutionClient
  │       ├── 📄 ClientMain
  │       ├── 📁 Controllers
  │       ├── 📁 UI
  │       └── 📁 Systems
  └── 📁 StarterGui
      └── 📄 FashionRevolutionGui

📁 Lighting (Avec effets post-processing)
📁 Workspace (Avec spawn et structure monde)
📁 SoundService (Avec music et SFX)
📁 Teams (Contestants, Judges, Spectators)
```

## 🔧 Configuration Avancée

### Hot Reloading Activé
Rojo synchronise automatiquement les changements de code. Éditez vos fichiers `.lua` et ils sont mis à jour instantanément dans Studio !

### Multiple Ports pour Dev Team
```bash
# Développeur 1 - Core Systems
rojo serve --port 34872

# Développeur 2 - UI Systems  
rojo serve --port 34873

# Développeur 3 - Client Systems
rojo serve --port 34874
```

### Variables d'Environnement
```bash
# Optionnel: Configurer ROJO_PROJECT_PATH
export ROJO_PROJECT_PATH=/workspace/default.project.json

# Lancer avec configuration personnalisée
rojo serve default.project.json
```

## 🚨 Troubleshooting

### ❌ Erreur: "command not found"
```bash
# Vérifier PATH
echo $PATH

# Ajouter rojo au PATH
export PATH="$PATH:/usr/local/bin"

# Ou installer via npm
npm install -g rojo
```

### ❌ Erreur: "Failed to connect"
```bash
# Vérifier que rojo serve est lancé
ps aux | grep rojo

# Vérifier le port
netstat -tulpn | grep 34872

# Redémarrer rojo
pkill rojo
rojo serve
```

### ❌ Erreur: "Sync failed"
1. Vérifier que tous les fichiers existent
2. Vérifier la syntaxe de `default.project.json`
3. Redémarrer Roblox Studio
4. Réinstaller le plugin Rojo

### ❌ Scripts n'apparaissent pas
1. Vérifier les chemins dans `default.project.json`
2. S'assurer que tous les dossiers existent
3. Relancer "Sync In" dans Studio

## 📊 Validation de la Configuration

### Check List avant Lancement
- [ ] Rojo installé et fonctionnel
- [ ] Plugin Rojo installé dans Studio  
- [ ] Serveur rojo lancé sur port 34872
- [ ] Connexion Studio → Rojo réussie
- [ ] Sync In exécuté sans erreur
- [ ] Tous les modules apparaissent dans l'Explorer
- [ ] F5 lance le jeu sans erreurs console
- [ ] Interface Fashion Revolution s'affiche

### Test de Base
```lua
-- Dans ServerScriptService, créer un script test:
local MainGame = require(game.ReplicatedStorage.FashionRevolutionModules.Core.MainGame)
print("✅ Fashion Revolution Ready!")
```

## 🎯 Performance Optimization

### Rojo Build pour Production
```bash
# Build pour déploiement
rojo build --output FashionRevolution.rbxl

# Build avec source maps
rojo build --output FashionRevolution.rbxl --plugin sourcemap
```

### Exclusions pour Performance
```json
// Dans default.project.json, ajouter:
"$ignoreUnknownInstances": true,
"$className": "DataModel",
"$properties": {
    "FilteringEnabled": true
}
```

## 🚀 Ready to Launch!

Une fois la configuration terminée, Fashion Revolution est prêt à révolutionner le gaming fashion sur Roblox !

**Commandes de vérification finale :**
```bash
# Vérifier que tout fonctionne
rojo --version
ls -la src/
cat default.project.json | head -10

# Lancer le serveur de développement
rojo serve --verbose
```

**Dans Roblox Studio :**
1. Connecter Rojo ✅
2. Sync In ✅  
3. F5 pour tester ✅
4. Vérifier console logs ✅
5. Welcome screen s'affiche ✅

🎉 **Fashion Revolution est maintenant opérationnel avec Rojo !**

---

*Pour des questions ou du support, créer une issue GitHub ou rejoindre notre Discord de développement.*