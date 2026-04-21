# Void Niri Stack

A modular Wayland stack installer for Void Linux featuring:

* Niri compositor
* Quickshell shell UI
* Noctalia shell integration
* GPU auto-detection
* Clean modular installer framework

Built for clean, reproducible setups on Void Linux.

---

## ⚠️ Requirements

Before running the installer, make sure your system has:

```bash
sudo xbps-install -Su
sudo xbps-install -y git curl base-devel pkgconf
```

✔ Required for cloning and building
✔ Avoids early installation failures

---

## 🚀 Installation

```bash
git clone https://github.com/Ygolana/void-niri-stack.git
cd void-niri-stack
chmod +x install.sh
./install.sh --all
```

---

## ⚙️ Install Modes

| Mode         | Description                               |
| ------------ | ----------------------------------------- |
| `--all`      | Full stack (Niri + Quickshell + Noctalia) |
| `--niri`     | Install Niri only                         |
| `--noctalia` | Install Quickshell + Noctalia             |

Example:

```bash
./install.sh --niri
```

---

## 🧱 What Gets Installed

* Wayland base stack
* GPU drivers (auto-detected)
* Niri (built from source)
* Quickshell (built from source)
* Noctalia shell (downloaded release)

---

## ⏱️ Build Time

* Base install → fast
* Niri build → medium
* Quickshell build → slowest

👉 Total time depends on CPU (can take several minutes)

---

## ⚠️ Notes

* Designed specifically for Void Linux (not Arch/Ubuntu)
* Uses `xbps-install` for package management
* Requires working internet connection

---

## 🧪 Troubleshooting

If something fails:

1. Check internet:

```bash
ping 1.1.1.1
```

2. Clean build and retry:

```bash
rm -rf ~/build/niri-stack
./install.sh --all
```

---

## 📦 Project Structure

```
install.sh
lib/
modules/
config/
```

---

## 🧠 Philosophy

This project aims to be:

* Minimal
* Modular
* Reproducible
* Void-native

---

## 📌 Status

Active development — expect updates and improvements.
