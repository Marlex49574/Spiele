# Snake Game - Schnellstart-Anleitung für Windows

## Einfachste Methode: Python-Version starten

1. **Python installieren** (falls noch nicht vorhanden):
   - Gehe zu https://www.python.org/downloads/
   - Lade Python 3.x herunter und installiere es
   - **WICHTIG**: Aktiviere "Add Python to PATH" während der Installation

2. **Abhängigkeiten installieren**:
   - Öffne die Eingabeaufforderung (CMD) in diesem Ordner
   - Führe aus: `pip install -r requirements.txt`

3. **Spiel starten**:
   - Doppelklick auf `start_game.bat`
   - ODER: Führe in der CMD aus: `python snake_game.py`

## Windows EXE erstellen (keine Python-Installation auf Zielcomputer nötig)

1. **Voraussetzungen**:
   - Python muss installiert sein (siehe oben)
   - Abhängigkeiten installiert (siehe oben)

2. **EXE erstellen**:
   - Doppelklick auf `build_windows.bat`
   - ODER: Führe in der CMD aus: `python build_exe.py`

3. **EXE verwenden**:
   - Die erstellte EXE befindet sich in: `dist\SnakeGame\SnakeGame.exe`
   - Kopiere den gesamten `dist\SnakeGame\` Ordner auf jeden Windows-PC
   - Starte `SnakeGame.exe` - keine Python-Installation erforderlich!

## Steuerung

- **Pfeiltasten**: Schlange steuern
- **ESC**: Spiel beenden

## Problembehebung

### "python" wird nicht erkannt
- Python ist nicht installiert oder nicht im PATH
- Installiere Python neu und aktiviere "Add Python to PATH"

### "No module named 'pygame'"
- pygame ist nicht installiert
- Führe aus: `pip install pygame`

### Schwarzes Fenster öffnet sich kurz und schließt sofort
- Öffne die CMD in diesem Ordner
- Führe manuell aus: `python snake_game.py`
- Fehlermeldungen werden dann angezeigt

## Systemanforderungen

- Windows 7 oder höher
- Mindestens 50 MB freier Speicherplatz
- Für Python-Version: Python 3.7 oder höher
- Für EXE-Version: Keine zusätzliche Software erforderlich
