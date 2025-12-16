@echo off
REM Schnellstart-Skript für Snake Game (Python-Version)
REM Führt das Spiel direkt mit Python aus

echo Starte Snake Game...
python snake_game.py
if errorlevel 1 (
    echo.
    echo [FEHLER] Konnte das Spiel nicht starten
    echo Stelle sicher, dass Python und pygame installiert sind:
    echo   pip install -r requirements.txt
    echo.
    pause
)
