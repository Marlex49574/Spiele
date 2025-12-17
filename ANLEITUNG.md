# Snake Game - Schnellstart-Anleitung für Windows

## Einfachste Methode: PowerShell-Version starten ⭐ EMPFOHLEN

**Keine Installation erforderlich!**

1. **Spiel starten**:
   - Doppelklick auf `start_game_powershell.bat`
   - ODER: Rechtsklick auf `snake_game.ps1` → "Mit PowerShell ausführen"
   - ODER: In PowerShell: `.\snake_game.ps1`

**Das war's!** 🎮

**Vorteile der PowerShell-Version:**
- ✅ Keine Installation von Python oder anderen Programmen nötig
- ✅ PowerShell ist bereits in Windows enthalten
- ✅ Funktioniert sofort auf Windows 7/8/10/11
- ✅ Keine Abhängigkeiten, keine Probleme!

---

## Alternative: Python-Version starten

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

### PowerShell-Version

#### "Ausführung von Skripts ist deaktiviert"
Wenn du diese Fehlermeldung bekommst:
1. **Einfachste Lösung**: Benutze `start_game_powershell.bat` statt die .ps1-Datei direkt
2. **Alternative**: Öffne PowerShell als Administrator und führe aus: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

#### Spiel startet nicht oder stürzt ab
- Stelle sicher, dass du Windows 7 oder höher verwendest
- Versuche, die Datei `snake_game.ps1` zu öffnen, indem du mit der rechten Maustaste darauf klickst und "Mit PowerShell ausführen" wählst

### Python-Version

#### "python" wird nicht erkannt
- Python ist nicht installiert oder nicht im PATH
- Installiere Python neu und aktiviere "Add Python to PATH"

#### "No module named 'pygame'"
- pygame ist nicht installiert
- Führe aus: `pip install pygame`

#### Schwarzes Fenster öffnet sich kurz und schließt sofort
- Öffne die CMD in diesem Ordner
- Führe manuell aus: `python snake_game.py`
- Fehlermeldungen werden dann angezeigt

## Systemanforderungen

- Windows 7 oder höher
- Mindestens 50 MB freier Speicherplatz
- Für **PowerShell-Version**: Keine zusätzliche Software erforderlich! ✅
- Für Python-Version: Python 3.7 oder höher
- Für EXE-Version: Keine zusätzliche Software erforderlich
