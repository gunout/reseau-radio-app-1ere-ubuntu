<!-- ============================================================ -->
<!--  BADGES                                                      -->
<!-- ============================================================ -->

<div align="center">

# 📻 Radio La 1ère

### Lecteur radio minimaliste pour les stations **Outre-mer La 1ère**

[![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![PyQt6](https://img.shields.io/badge/PyQt6-6.5%2B-41CD52?style=for-the-badge&logo=qt&logoColor=white)](https://pypi.org/project/PyQt6/)
[![mpv](https://img.shields.io/badge/mpv-player-691F69?style=for-the-badge&logo=mpv&logoColor=white)](https://mpv.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-0078D6?style=for-the-badge&logo=linux&logoColor=white)](#)
[![Status](https://img.shields.io/badge/Status-Stable-brightgreen?style=for-the-badge)](#)
[![PRs](https://img.shields.io/badge/PRs-Welcome-ff69b4?style=for-the-badge)](#contribuer)

<br>

<img src="https://img.shields.io/badge/Martinique-1ère-00A0E4?style=flat-square" />
<img src="https://img.shields.io/badge/Guadeloupe-1ère-00A0E4?style=flat-square" />
<img src="https://img.shields.io/badge/Guyane-1ère-00A0E4?style=flat-square" />
<img src="https://img.shields.io/badge/Mayotte-1ère-00A0E4?style=flat-square" />
<img src="https://img.shields.io/badge/Réunion-1ère-00A0E4?style=flat-square" />
<img src="https://img.shields.io/badge/Nouvelle--Calédonie-1ère-00A0E4?style=flat-square" />
<img src="https://img.shields.io/badge/Polynésie-1ère-00A0E4?style=flat-square" />

</div>

---

## ✨ Aperçu

**Radio La 1ère** est un lecteur radio **ultra-léger**, **frameless** et **moderne** qui regroupe les neuf stations de radio du réseau **Outre-mer La 1ère** (France Télévisions).

Interface sombre, visualiseur audio animé, contrôles repliables, popup de liens vers les sites territoriaux : tout est pensé pour une expérience fluide et discrète.


<img width="450" height="70" alt="1ERE" src="https://github.com/user-attachments/assets/f12e7fe3-0230-4a59-99d9-111118d40f75" />

<img width="450" height="420" alt="1ERE 1" src="https://github.com/user-attachments/assets/f54fc522-09e1-4488-97d6-06c2b5d8ae8d" />

<img width="450" height="420" alt="1ERE 3" src="https://github.com/user-attachments/assets/6e8f956f-9186-4073-9969-b46012249627" />

<img width="380" height="460" alt="1ERE 4" src="https://github.com/user-attachments/assets/aceaba77-57fb-4d9c-b7ef-e2ddc4256502" />

---

## 🎯 Fonctionnalités

| Fonctionnalité | Description |
|---|---|
| 🎧 **9 stations La 1ère** | Martinique, Guadeloupe, Guyane, Mayotte, Réunion, Nouvelle-Calédonie, Polynésie, Wallis-et-Futuna, Saint-Pierre-et-Miquelon |
| 🎨 **Interface frameless** | Design sombre, coins arrondis, drag & resize natifs |
| 📊 **Visualiseur audio** | 32 barres animées en temps réel |
| 🔇 **Contrôles complets** | Play / Pause / Stop / Mute / Volume |
| 🪗 **Repli automatique** | Les contrôles se cachent après 3,5 s d'inactivité |
| 🔽 **Fenêtre repliable** | Mode mini pour ne garder que la barre de titre |
| 🌐 **Popup sites** | Accès direct aux sites territoriaux de La 1ère |
| ⚡ **Léger** | Basé sur `mpv` — consommation minimale |

---

## 🚀 Installation rapide

### Méthode automatique (recommandée)

```bash
git clone https://github.com/gleaphe/radio-la1ere.git
cd radio-la1ere
chmod +x install.sh
./install.sh
```

Le script détecte ton OS, installe `mpv`, `ffmpeg`, crée un environnement virtuel, installe les dépendances Python et génère un lanceur `run.sh`.

### Lancement

```bash
./run.sh
```

---

## 🛠️ Installation manuelle

<details>
<summary><b>Clique pour déplier</b></summary>

### 1. Prérequis système

**Debian / Ubuntu**
```bash
sudo apt update
sudo apt install -y mpv ffmpeg python3-pip python3-venv \
                    libxcb-cursor0 libxkbcommon-x11-0
```

**Fedora / RHEL**
```bash
sudo dnf install -y mpv ffmpeg python3-pip python3-virtualenv
```

**Arch Linux**
```bash
sudo pacman -S mpv ffmpeg python-pip python-virtualenv
```

**macOS (Homebrew)**
```bash
brew install mpv ffmpeg python@3.11
```

### 2. Environnement Python

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 3. Lancement

```bash
python3 radio.py
```

</details>

---

## 📁 Structure du projet

```
radio-la1ere/
├── radio.py            # Application principale
├── install.sh          # Script d'installation automatique
├── run.sh              # Lanceur généré (après install)
├── requirements.txt    # Dépendances Python
├── logo.png            # Logo affiché dans le HUD (optionnel)
├── README.md
└── LICENSE
```

---

## 📦 Dépendances

| Paquet | Version | Rôle |
|---|---|---|
| `PyQt6` | ≥ 6.5.0 | Interface graphique |
| `python-mpv` | ≥ 1.0.4 | Lecture audio |
| `mpv` (système) | ≥ 0.35 | Backend audio |
| `ffmpeg` (système) | ≥ 5.0 | Décodage des flux |

---

## ⌨️ Raccourcis & interactions

| Action | Geste |
|---|---|
| Déplacer la fenêtre | Glisser la souris sur la barre du haut |
| Redimensionner | Glisser les bords / coins |
| Lire une station | **Double-clic** sur la station |
| Replier les contrôles | Bouton `⌄` en bas à droite |
| Replier la fenêtre | Bouton `⌃` en haut à droite |
| Ouvrir le popup sites | Bouton `SITES` |

---

## 🌍 Stations incluses

| Station | Région |
|---|---|
| 🏝️ Martinique 1ère | Antilles |
| 🌴 Guadeloupe 1ère | Antilles |
| 🌳 Guyane 1ère | Amérique du Sud |
| 🐢 Mayotte 1ère | Océan Indien |
| 🌋 Réunion 1ère | Océan Indien |
| 🏝️ Nouvelle-Calédonie 1ère | Pacifique |
| 🌺 Polynésie 1ère | Pacifique |
| 🏝️ Wallis-et-Futuna 1ère | Pacifique |
| ❄️ Saint-Pierre-et-Miquelon 1ère | Atlantique Nord |

---

## 🤝 Contribuer

Les contributions sont **les bienvenues** !

1. Fork le projet
2. Crée une branche (`git checkout -b feature/ma-feature`)
3. Commit (`git commit -m 'Ajout de ma feature'`)
4. Push (`git push origin feature/ma-feature`)
5. Ouvre une **Pull Request**

---

## 🐛 Signaler un bug

Ouvre une [issue](https://github.com/gleaphe/radio-la1ere/issues) avec :
- Ton OS et version
- La version Python
- Les logs d'erreur

---

## 📜 Licence

Distribué sous licence **MIT**. Voir [`LICENSE`](LICENSE) pour plus d'infos.

---

## 🙏 Remerciements

- [France Télévisions — Outre-mer La 1ère](https://la1ere.francetvinfo.fr/) pour les flux radio
- [mpv](https://mpv.io/) pour le backend audio
- [PyQt6](https://www.riverbankcomputing.com/software/pyqt/) pour l'interface

---

<div align="center">

**Fait avec ❤️ par [gleaphe](https://github.com/gleaphe)**

⭐ N'oublie pas de mettre une étoile si ce projet t'a plu !

</div>

---

<div align="center">

### 🇫🇷 Gunout · 2026

![Made in France](https://img.shields.io/badge/Made_in-France-002395?style=flat-square&labelColor=FFFFFF&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA5MDAgNjAwIj48cmVjdCB3aWR0aD0iOTAwIiBoZWlnaHQ9IjYwMCIgZmlsbD0iIzAwMjM5NSIvPjxyZWN0IHdpZHRoPSI5MDAiIGhlaWdodD0iNDAwIiB5PSIxMDAiIGZpbGw9IiNmZmYiLz48cmVjdCB3aWR0aD0iOTAwIiBoZWlnaHQ9IjIwMCIgeT0iNDAwIiBmaWxsPSIjZWQyOTM5Ii8+PC9zdmc+)
![GitHub](https://img.shields.io/badge/GitHub-gunout-181717?style=flat-square&logo=github&logoColor=white)
![Year](https://img.shields.io/badge/2026-ED2939?style=flat-square&labelColor=FFFFFF)

<sub>© 2026 <strong>Gunout</strong> — Tous droits réservés.</sub>

</div>
