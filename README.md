# Mi configuración NixOS

Esta configuración de NixOS está organizada en múltiples perfiles para diferentes tipos de sistemas, optimizada para desarrollo y uso diario.

## ✨ Características Destacadas

- 🖥️ **Múltiples perfiles**: Configuraciones específicas para notebook y desktop
- 🎨 **Tema consistente**: Adwaita Dark con Hyprland + Waybar
- ⚡ **Gestión de energía**: Optimizaciones específicas para portátiles
- 🖱️ **Multi-monitor**: Soporte completo para configuraciones de doble pantalla
- 🛠️ **Modular**: Módulos reutilizables de Home Manager
- 🚀 **Aliases inteligentes**: Comandos simplificados para cambiar perfiles

## 🖥️ Perfiles Disponibles

### 1. **Notebook ASUS** (`nyx-asus`)

Sistema optimizado para laptop ASUS con NVIDIA y gestión de energía avanzada.

- **Hardware**: ASUS laptop con GPU NVIDIA
- **Funcionalidades**: Gestión de energía TLP, Bluetooth, control de brillo
- **Uso**: Desarrollo móvil, estudios, trabajo en movimiento

### 2. **Desktop PC Master Race** (`nyx-pcmasterrace`)

Sistema optimizado para escritorio con configuración de doble monitor y máximo rendimiento.

- **Hardware**: PC de escritorio con GPU NVIDIA dedicada
- **Funcionalidades**: Doble monitor, sin gestión de energía, máximo rendimiento
- **Uso**: Desarrollo intensivo, trabajo con múltiples pantallas

### 3. **Base** (`nixos` - fallback)

Configuración básica compatible con cualquier sistema que tenga drivers NVIDIA.

- **Hardware**: Cualquier sistema con GPU NVIDIA
- **Funcionalidades**: Configuración mínima funcional
- **Uso**: Sistema de respaldo o configuración inicial

## 🚀 Uso

### Usando los aliases de ZSH (recomendado):

```bash
# Para notebook ASUS
nyx-asus

# Para desktop PC Master Race
nyx-pcmasterrace

# Configuración base (fallback)
nyx-base

# Actualizar dependencias del flake
nyx-update
```

### Construir e instalar un perfil específico (método manual):

```bash
# Para notebook ASUS
sudo nixos-rebuild switch --flake .#nyx-asus

# Para desktop PC Master Race
sudo nixos-rebuild switch --flake .#nyx-pcmasterrace

# Configuración base (fallback)
sudo nixos-rebuild switch --flake .#nixos

# Actualizar flake (desde el directorio de configuración)
cd /home/nyx/nixos-config && nix flake update
```

> **💡 Tip**: Los aliases están configurados en el módulo ZSH y estarán disponibles automáticamente después de la primera instalación.

## 📁 Estructura del Proyecto

```
nixos-config/
├── configuration.nix         # Configuración original (fallback)
├── flake.nix                 # Definición de perfiles del sistema
├── hc-desktop.nix            # Hardware configuration para desktop
├── hc-notebook.nix           # Hardware configuration para notebook
├── hosts/
│   ├── base.nix              # Configuración base del sistema
│   ├── notebook.nix          # Configuración específica notebook
│   └── desktop.nix           # Configuración específica desktop
├── profiles/
│   ├── base.nix              # Perfil base de Home Manager
│   ├── notebook.nix          # Perfil Home Manager notebook
│   └── desktop.nix           # Perfil Home Manager desktop
├── modules/                  # Módulos compartidos de Home Manager
└── Wallpaper/                # Wallpaper/s
```

## 🔧 Diferencias entre perfiles

### **Notebook ASUS** (`nyx-asus`)

- **Sistema**: TLP (gestión de energía), Bluetooth, UPower
- **NVIDIA**: Gestión de energía habilitada
- **Paquetes**: Control de brillo (brightnessctl), herramientas de batería (powertop, acpi)
- **Comportamiento**: Suspend al cerrar tapa, optimizado para ahorro de energía

### **Desktop PC Master Race** (`nyx-pcmasterrace`)

- **Sistema**: Sin gestión de energía, optimizado para rendimiento
- **NVIDIA**: Sin gestión de energía (máximo rendimiento)
- **Paquetes**: Configuración básica sin herramientas de batería
- **Comportamiento**: Optimizado para rendimiento continuo

### **Base (común)**

- **Sistema**: NVIDIA drivers, Hyprland, Pipewire, SDDM con Wayland
- **Aplicaciones**: Brave, Obsidian, Discord, Telegram, Spotify, VS Code, Neovim
- **Desarrollo**: Git, Node.js, Docker, GitHub CLI
- **Tema**: Adwaita Dark con cursores Bibata-Modern-Classic
- **Módulos**: Git, ZSH, Kitty, Hyprland, Hyprpaper, Rofi, Waybar

## 🧩 Módulos Disponibles

Esta configuración utiliza módulos modulares de Home Manager que puedes habilitar/deshabilitar según necesites:

### **Módulos de Sistema**

- **`git.nix`**: Configuración de Git con credenciales
- **`zsh.nix`**: Shell ZSH con aliases personalizados
- **`kitty.nix`**: Terminal Kitty con configuración optimizada

### **Módulos de Entorno de Escritorio**

- **`hyprland.nix`**: Window manager Hyprland con configuración completa
- **`hyprpaper.nix`**: Daemon de wallpapers para Hyprland
- **`rofi/`**: Launcher de aplicaciones con tema personalizado
- **`waybar/`**: Barra de estado con configuración y estilos CSS

### **Características de los Módulos**

- ✅ Configuración modular y reutilizable
- ✅ Opciones configurables por perfil
- ✅ Temas consistentes entre aplicaciones
- ✅ Soporte para múltiples monitores (desktop)

## ⚠️ Importante - Configuración de Hardware

**Esta configuración utiliza archivos de hardware separados para cada tipo de sistema para evitar conflictos al hacer cambios.**

### Archivos de Hardware:

- `hc-desktop.nix`: Configuración de hardware para sistemas desktop
- `hc-notebook.nix`: Configuración de hardware para sistemas notebook

### Pasos para configurar un nuevo sistema:

1. **Genere** la configuración de hardware para su sistema:

   ```bash
   sudo nixos-generate-config --show-hardware-config > hardware-config-temp.nix
   ```

2. **Copie** el contenido del archivo temporal al archivo correspondiente:

   - Para notebook: copie a `hc-notebook.nix`
   - Para desktop: copie a `hc-desktop.nix`

3. **Elimine** el archivo temporal:
   ```bash
   rm hardware-config-temp.nix
   ```

### ¿Por qué archivos separados?

Los archivos de configuración de hardware contienen información específica del sistema como:

- Configuración de particiones y puntos de montaje
- Drivers y módulos del kernel específicos
- Configuración de red y dispositivos

Al tener archivos separados, evitamos que los cambios en un equipo afecten la configuración del otro, eliminando errores de configuración cuando se cambia entre diferentes máquinas.

## 🎨 Personalización

### **Cambiar wallpaper**

Edita el archivo `profiles/base.nix` y modifica la línea:

```nix
hyprpaper.wallpaper = "/home/nyx/nixos-config/Wallpaper/TuNuevoWallpaper.jpg";
```

### **Agregar aplicaciones**

Para agregar paquetes a todos los perfiles, edita `profiles/base.nix` en la sección `home.packages`.
Para paquetes específicos de un perfil, edita `profiles/notebook.nix` o `profiles/desktop.nix`.

### **Configurar monitores**

- **Notebook**: Edita `profiles/notebook.nix` en la sección `hyprland.monitor`
- **Desktop**: Edita `profiles/desktop.nix` en las secciones `hyprland.monitor` y `hyprland.workspaceMonitorBindings`

### **Modificar temas**

Los archivos de configuración visual están en:

- **Rofi**: `modules/rofi/rofi.rasi`
- **Waybar**: `modules/waybar/waybar.css` y `modules/waybar/waybar.jsonc`
- **Hyprland**: `modules/hyprland.nix`
