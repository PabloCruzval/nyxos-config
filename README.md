# Configuración NixOS

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
