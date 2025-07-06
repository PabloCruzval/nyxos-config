# Mi configuración NixOS

Esta configuración de NixOS está organizada en múltiples perfiles para diferentes tipos de sistemas.

## 🖥️ Perfiles Disponibles

### 1. **Notebook** (`nixos-notebook`)

- Optimizado para portátiles con NVIDIA
- Gestión de energía (TLP) y Bluetooth
- Control de brillo y herramientas de batería
- NVIDIA con gestión de energía habilitada

### 2. **Desktop/Torre** (`nixos-desktop`)

- Optimizado para computadoras de escritorio
- NVIDIA con máximo rendimiento (sin gestión de energía)
- Optimizaciones para gaming
- Monitor GPU (nvtop)

### 3. **Base** (fallback)

- Configuración básica con drivers NVIDIA
- Compatible con ambos tipos de sistema

## 🚀 Uso

### Usando los aliases de zsh (recomendado):

```bash
# Para notebook
nyx-notebook

# Para desktop/torre
nyx-desktop

# Configuración base (fallback)
nyx-base

# Actualizar flake
nyx-update
```

### Construir e instalar un perfil específico (manual):

```bash
# Para notebook
sudo nixos-rebuild switch --flake .#nixos-notebook

# Para desktop/torre
sudo nixos-rebuild switch --flake .#nixos-desktop

# Configuración original (fallback)
sudo nixos-rebuild switch --flake .#nixos
```

## 📁 Estructura del Proyecto

```
nixos-config/
├── configuration.nix          # Configuración original (fallback)
├── flake.nix                 # Definición de perfiles
├── hosts/
│   ├── base.nix              # Configuración base del sistema
│   ├── notebook.nix          # Configuración específica notebook
│   └── desktop.nix           # Configuración específica desktop
├── profiles/
│   ├── base.nix              # Perfil base de Home Manager
│   ├── notebook.nix          # Perfil Home Manager notebook
│   └── desktop.nix           # Perfil Home Manager desktop
├── modules/                  # Módulos compartidos
└── Wallpaper/               # Recursos compartidos
```

## 🔧 Diferencias entre perfiles

### **Notebook**

- **Sistema**: TLP (gestión de energía), Bluetooth, UPower
- **NVIDIA**: Gestión de energía habilitada
- **Paquetes**: Control de brillo, herramientas de batería
- **Comportamiento**: Suspend al cerrar tapa

### **Desktop**

- **Sistema**: Optimizaciones para gaming
- **NVIDIA**: Sin gestión de energía (máximo rendimiento)
- **Paquetes**: Solo nvtop para monitoreo GPU
- **Comportamiento**: Optimizado para rendimiento

### **Base (común)**

- **Sistema**: NVIDIA drivers, Hyprland, Pipewire, tema oscuro
- **Paquetes**: Aplicaciones esenciales + Obsidian para estudios

## ⚠️ Importante - Configuración de Hardware

**Antes de usar esta configuración, debe reemplazar el archivo `hardware-configuration.nix` con el de su sistema.**

### Pasos a seguir:

1. **Elimine** el archivo `hardware-configuration.nix` actual de este repositorio
2. **Copie** su archivo de hardware desde `/etc/nixos/hardware-configuration.nix`
3. **Pegue** el archivo en la raíz de este repositorio

### ¿Por qué es necesario?

El archivo `hardware-configuration.nix` contiene la configuración específica de hardware de su sistema, incluyendo:

- Configuración de particiones y puntos de montaje
- Drivers y módulos del kernel específicos
- Configuración de red y dispositivos

**Nota:** Este archivo no se incluye en `.gitignore` porque es requerido para que `nixos-rebuild` funcione correctamente.
