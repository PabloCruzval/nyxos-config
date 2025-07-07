# Mi configuración NixOS

Esta configuración de NixOS está organizada en múltiples perfiles para diferentes tipos de sistemas.

## 🖥️ Perfiles Disponibles

### 1. **Notebook ASUS** (`nyx-asus`)

- Optimizado para portátiles con NVIDIA
- Gestión de energía (TLP) y Bluetooth
- Control de brillo y herramientas de batería
- NVIDIA con gestión de energía habilitada

### 2. **Desktop PC Master Race** (`nyx-pcmasterrace`)

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
# Para notebook ASUS
nyx-asus

# Para desktop PC Master Race
nyx-pcmasterrace

# Configuración base (fallback)
nyx-base

# Actualizar flake
nyx-update
```

### Construir e instalar un perfil específico (manual):

```bash
# Para notebook ASUS
sudo nixos-rebuild switch --flake .#nyx-asus

# Para desktop PC Master Race
sudo nixos-rebuild switch --flake .#nyx-pcmasterrace

# Configuración original (fallback)
sudo nixos-rebuild switch --flake .#nixos
```

## 📁 Estructura del Proyecto

```
nixos-config/
├── configuration.nix         # Configuración original (fallback)
├── flake.nix                 # Definición de perfiles
├── hc-desktop.nix           # Hardware configuration para desktop
├── hc-notebook.nix          # Hardware configuration para notebook
├── hosts/
│   ├── base.nix              # Configuración base del sistema
│   ├── notebook.nix          # Configuración específica notebook
│   └── desktop.nix           # Configuración específica desktop
├── profiles/
│   ├── base.nix              # Perfil base de Home Manager
│   ├── notebook.nix          # Perfil Home Manager notebook
│   └── desktop.nix           # Perfil Home Manager desktop
├── modules/                  # Módulos compartidos
└── Wallpaper/                # Recursos compartidos
```

## 🔧 Diferencias entre perfiles

### **Notebook ASUS**

- **Sistema**: TLP (gestión de energía), Bluetooth, UPower
- **NVIDIA**: Gestión de energía habilitada
- **Paquetes**: Control de brillo, herramientas de batería
- **Comportamiento**: Suspend al cerrar tapa

### **Desktop PC Master Race**

- **Sistema**: Optimizaciones para gaming
- **NVIDIA**: Sin gestión de energía (máximo rendimiento)
- **Paquetes**: Solo nvtop para monitoreo GPU
- **Comportamiento**: Optimizado para rendimiento

### **Base (común)**

- **Sistema**: NVIDIA drivers, Hyprland, Pipewire, tema oscuro
- **Paquetes**: Aplicaciones esenciales + Obsidian para estudios

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
