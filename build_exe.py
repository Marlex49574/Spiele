"""
Build-Skript für Snake Game Windows EXE
Dieses Skript erstellt eine ausführbare Windows-Datei (.exe) aus dem Snake-Spiel
"""

import subprocess
import sys
import os

def build_exe():
    """Erstellt die Windows EXE-Datei mit PyInstaller"""
    
    print("=" * 60)
    print("Snake Game - Windows EXE Builder")
    print("=" * 60)
    print()
    
    # Überprüfe ob PyInstaller installiert ist
    try:
        import PyInstaller
        print("✓ PyInstaller gefunden")
    except ImportError:
        print("PyInstaller nicht gefunden. Installiere PyInstaller...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "pyinstaller"])
        print("✓ PyInstaller installiert")
    
    print()
    print("Erstelle Windows EXE-Datei...")
    print()
    
    # PyInstaller Befehl
    cmd = [
        "pyinstaller",
        "--name=SnakeGame",
        "--onedir",
        "--windowed",
        "--clean",
        "snake_game.py"
    ]
    
    try:
        subprocess.check_call(cmd)
        print()
        print("=" * 60)
        print("✓ EXE-Datei erfolgreich erstellt!")
        print("=" * 60)
        print()
        print("Die ausführbare Datei befindet sich in:")
        print(f"  {os.path.abspath('dist/SnakeGame/SnakeGame.exe')}")
        print()
        print("Du kannst die gesamte 'dist/SnakeGame/' Ordner")
        print("an einen anderen Ort kopieren und dort ausführen.")
        print()
        
    except subprocess.CalledProcessError as e:
        print()
        print("✗ Fehler beim Erstellen der EXE-Datei")
        print(f"  Fehler: {e}")
        sys.exit(1)

if __name__ == "__main__":
    build_exe()
