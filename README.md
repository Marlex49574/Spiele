# Snake Game

Ein einfaches Snake-Spiel für Windows mit grüner Schlange und roten Punkten zum Einsammeln.

## Spielanleitung

### Ziel des Spiels
Steuere die grüne Schlange und sammle die roten Punkte ein. Mit jedem Punkt wird die Schlange länger und du erhältst 10 Punkte.

### Steuerung
- **Pfeiltaste Oben**: Nach oben bewegen
- **Pfeiltaste Unten**: Nach unten bewegen
- **Pfeiltaste Links**: Nach links bewegen
- **Pfeiltaste Rechts**: Nach rechts bewegen
- **ESC**: Spiel beenden

### Spielregeln
- Die Schlange bewegt sich kontinuierlich in die gewählte Richtung
- Sammle die roten Punkte ein, um zu wachsen und Punkte zu sammeln
- Wenn die Schlange sich selbst berührt, startet das Spiel neu
- Die Schlange kann durch die Wände hindurch auf die andere Seite gelangen

## Installation und Ausführung

### Option 1: Python-Version ausführen (benötigt Python)
1. Installiere Python 3.x von python.org
2. Installiere die Abhängigkeiten:
   ```
   pip install -r requirements.txt
   ```
3. Starte das Spiel:
   ```
   python snake_game.py
   ```

### Option 2: Windows EXE erstellen
1. Installiere PyInstaller:
   ```
   pip install pyinstaller
   ```
2. Führe das Build-Skript aus:
   ```
   python build_exe.py
   ```
3. Die EXE-Datei findest du im Ordner `dist/SnakeGame/`
4. Starte `SnakeGame.exe`

## Systemanforderungen
- Windows 7 oder höher
- Mindestens 50 MB freier Speicherplatz

## Features
- Grüne Schlange (heller Kopf, dunklerer Körper)
- Rote Punkte zum Einsammeln
- Punktezähler
- Gitter zur besseren Orientierung
- Automatischer Neustart bei Kollision mit sich selbst
- Wrap-around durch Wände

Viel Spaß beim Spielen!
