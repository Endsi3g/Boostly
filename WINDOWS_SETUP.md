# Configuration Windows pour Flutter - BOOSTLY

## ⚠️ Problème CMake

Si vous rencontrez l'erreur :
```
CMake Error: No CMAKE_CXX_COMPILER could be found
```

Cela signifie que le compilateur C++ n'est pas installé sur votre système Windows.

## 🔧 Solution

### Option 1 : Installer Visual Studio Build Tools (Recommandé)

1. Télécharger [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)
2. Installer avec les composants suivants :
   - **C++ build tools**
   - **Windows 10/11 SDK**
   - **CMake tools for Windows**

### Option 2 : Installer Visual Studio Community (Complet)

1. Télécharger [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/)
2. Lors de l'installation, sélectionner :
   - **Développement Desktop en C++**
   - **Développement mobile avec .NET** (optionnel)

### Option 3 : Utiliser Android/iOS au lieu de Windows

Pour une application mobile, il est recommandé de tester sur Android ou iOS plutôt que Windows :

```bash
# Lister les appareils disponibles
flutter devices

# Lancer sur Android
flutter run -d android

# Lancer sur iOS (Mac uniquement)
flutter run -d ios
```

## ✅ Vérification

Après installation, vérifier :

```bash
# Vérifier Flutter
flutter doctor

# Vérifier CMake
cmake --version
```

## 📱 Alternative : Utiliser un émulateur Android

1. Installer Android Studio
2. Créer un AVD (Android Virtual Device)
3. Lancer l'application sur l'émulateur :

```bash
flutter run -d <device-id>
```

## 🎯 Recommandation

Pour le développement d'une application mobile BOOSTLY, utilisez :
- **Android Studio** avec un émulateur Android
- **Xcode** avec un simulateur iOS (sur Mac)

Le support Windows desktop n'est pas nécessaire pour une application mobile.

