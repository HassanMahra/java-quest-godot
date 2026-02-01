# Junior Developer Simulator - Godot Edition
# ==========================================

## Projektstruktur

```
java-quest-godot/
├── project.godot          # Godot Projekt-Konfiguration
├── icon.png               # App Icon
├── scenes/
│   ├── Main.tscn          # Hauptszene
│   ├── Office.tscn        # Büro-Hintergrund
│   ├── Character.tscn     # Pixel-Charakter
│   ├── Monitor.tscn       # PC-Monitor mit IDE
│   ├── MailApp.tscn       # Mail-Fenster
│   └── IDE.tscn           # Code-Editor
├── scripts/
│   ├── Main.gd            # Game Controller
│   ├── OfficeScene.gd     # Büro-Logik
│   ├── Character.gd       # Charakter-Animation
│   └── Tasks.gd           # Aufgaben-Definitionen
├── assets/
│   ├── sprites/           # Pixel-Art Grafiken
│   ├── sounds/            # Sound Effects
│   └── fonts/             # Schriftarten
└── README.md
```

## Setup

1. Godot 3.5+ installieren: https://godotengine.org/download
2. Projekt öffnen: `godot --path /root/java-quest-godot`
3. F5 drücken zum Starten

## Nächste Schritte

1. [ ] Main.tscn Szene erstellen (Node2D + Camera2D)
2. [ ] Pixel-Art Büro zeichnen (Sprites oder ColorRect)
3. [ ] Monitor-Klick-Area einbauen
4. [ ] IDE-Fenster mit TextEdit für Code
5. [ ] Mail-System implementieren
6. [ ] Sound Effects hinzufügen
7. [ ] Steam Export konfigurieren

## Tasten

- **Linksklick auf Monitor**: Zoom IN
- **ESC**: Zoom OUT

## Tech Stack

- **Godot 3.5** (GDScript)
- **Pixel-Perfect 2D** Rendering
- **Camera2D** mit Smooth Zoom
- **AudioStreamPlayer** für Sounds

---
Entwickelt von Hassan Mahra & Kai 🦞
