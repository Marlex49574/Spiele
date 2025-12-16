@echo off
REM Windows Build-Skript für Snake Game
REM Dieses Skript erstellt die Windows EXE-Datei

echo ============================================================
echo Snake Game - Windows EXE Builder
echo ============================================================
echo.

REM Prüfe ob Python installiert ist
python --version >nul 2>&1
if errorlevel 1 (
    echo [FEHLER] Python ist nicht installiert!
    echo Bitte installiere Python von https://www.python.org/
    pause
    exit /b 1
)

echo [OK] Python gefunden

REM Installiere Abhängigkeiten
echo.
echo Installiere Abhängigkeiten...
pip install -r requirements.txt
if errorlevel 1 (
    echo [FEHLER] Konnte Abhängigkeiten nicht installieren
    pause
    exit /b 1
)

echo [OK] Abhängigkeiten installiert

REM Installiere PyInstaller
echo.
echo Installiere PyInstaller...
pip install pyinstaller
if errorlevel 1 (
    echo [FEHLER] Konnte PyInstaller nicht installieren
    pause
    exit /b 1
)

echo [OK] PyInstaller installiert

REM Erstelle EXE
echo.
echo Erstelle Windows EXE-Datei...
pyinstaller --name=SnakeGame --onedir --windowed --clean snake_game.py
if errorlevel 1 (
    echo [FEHLER] Konnte EXE nicht erstellen
    pause
    exit /b 1
)

echo.
echo ============================================================
echo [OK] EXE-Datei erfolgreich erstellt!
echo ============================================================
echo.
echo Die ausführbare Datei befindet sich in:
echo   dist\SnakeGame\SnakeGame.exe
echo.
echo Du kannst den gesamten 'dist\SnakeGame\' Ordner
echo an einen anderen Ort kopieren und dort ausführen.
echo.
pause
