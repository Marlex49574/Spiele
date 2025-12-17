# Snake Game - PowerShell Version
# Ein einfaches Snake-Spiel für Windows PowerShell
# Steuerung: Pfeiltasten
# Ziel: Sammle die roten Punkte und werde länger!

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Konstanten
$WINDOW_WIDTH = 800
$WINDOW_HEIGHT = 600
$GRID_SIZE = 20
$GRID_WIDTH = [int]($WINDOW_WIDTH / $GRID_SIZE)
$GRID_HEIGHT = [int]($WINDOW_HEIGHT / $GRID_SIZE)
$GAME_SPEED = 100  # Millisekunden zwischen Updates (niedriger = schneller)

# Farben
$BLACK = [System.Drawing.Color]::Black
$GREEN = [System.Drawing.Color]::Lime
$RED = [System.Drawing.Color]::Red
$WHITE = [System.Drawing.Color]::White
$DARK_GREEN = [System.Drawing.Color]::FromArgb(0, 180, 0)
$GRID_COLOR = [System.Drawing.Color]::FromArgb(40, 40, 40)

# Richtungen
$script:UP = @{X=0; Y=-1}
$script:DOWN = @{X=0; Y=1}
$script:LEFT = @{X=-1; Y=0}
$script:RIGHT = @{X=1; Y=0}

# Initialisiere Richtungen-Array für zufällige Auswahl
$script:directions = @($UP, $DOWN, $LEFT, $RIGHT)

# Spielvariablen
$script:snakePositions = @()
$script:snakeLength = 3
$script:snakeDirection = $null
$script:foodPosition = @{X=0; Y=0}
$script:score = 0
$script:gameTimer = $null

# Random-Generator
$script:random = New-Object System.Random

# Snake initialisieren
function Initialize-Snake {
    $script:snakeLength = 3
    $startX = [int]($GRID_WIDTH / 2)
    $startY = [int]($GRID_HEIGHT / 2)
    $script:snakePositions = @(@{X=$startX; Y=$startY})
    $script:snakeDirection = $script:directions[$script:random.Next(0, 4)]
    $script:score = 0
}

# Food Position randomisieren
function New-FoodPosition {
    $script:foodPosition = @{
        X = $script:random.Next(0, $GRID_WIDTH)
        Y = $script:random.Next(0, $GRID_HEIGHT)
    }
    
    # Stelle sicher, dass Essen nicht auf Schlange erscheint
    $onSnake = $false
    do {
        $onSnake = $false
        foreach ($pos in $script:snakePositions) {
            if ($pos.X -eq $script:foodPosition.X -and $pos.Y -eq $script:foodPosition.Y) {
                $onSnake = $true
                $script:foodPosition = @{
                    X = $script:random.Next(0, $GRID_WIDTH)
                    Y = $script:random.Next(0, $GRID_HEIGHT)
                }
                break
            }
        }
    } while ($onSnake)
}

# Position vergleichen
function Compare-Position($pos1, $pos2) {
    return ($pos1.X -eq $pos2.X) -and ($pos1.Y -eq $pos2.Y)
}

# Snake aktualisieren
function Update-Snake {
    $head = $script:snakePositions[0]
    $newX = ($head.X + $script:snakeDirection.X + $GRID_WIDTH) % $GRID_WIDTH
    $newY = ($head.Y + $script:snakeDirection.Y + $GRID_HEIGHT) % $GRID_HEIGHT
    $newHead = @{X=$newX; Y=$newY}
    
    # Prüfe Selbstkollision (ignoriere die ersten zwei Segmente: Kopf und Nacken)
    for ($i = 2; $i -lt $script:snakePositions.Count; $i++) {
        if (Compare-Position $newHead $script:snakePositions[$i]) {
            Initialize-Snake
            New-FoodPosition
            return
        }
    }
    
    # Füge neuen Kopf hinzu
    $script:snakePositions = @($newHead) + $script:snakePositions
    
    # Entferne Schwanz wenn Länge überschritten
    if ($script:snakePositions.Count -gt $script:snakeLength) {
        $script:snakePositions = $script:snakePositions[0..($script:snakeLength - 1)]
    }
    
    # Prüfe ob Essen erreicht
    if (Compare-Position $newHead $script:foodPosition) {
        $script:snakeLength++
        $script:score += 10
        New-FoodPosition
    }
}

# Zeichne das Spiel
function Draw-Game {
    param($e)
    
    $g = $e.Graphics
    $g.Clear($BLACK)
    
    # Zeichne Gitter
    $pen = New-Object System.Drawing.Pen($GRID_COLOR, 1)
    for ($y = 0; $y -lt $WINDOW_HEIGHT; $y += $GRID_SIZE) {
        for ($x = 0; $x -lt $WINDOW_WIDTH; $x += $GRID_SIZE) {
            $g.DrawRectangle($pen, $x, $y, $GRID_SIZE, $GRID_SIZE)
        }
    }
    $pen.Dispose()
    
    # Zeichne Schlange
    $headBrush = New-Object System.Drawing.SolidBrush($GREEN)
    $bodyBrush = New-Object System.Drawing.SolidBrush($DARK_GREEN)
    $borderPen = New-Object System.Drawing.Pen($BLACK, 1)
    
    for ($i = 0; $i -lt $script:snakePositions.Count; $i++) {
        $pos = $script:snakePositions[$i]
        $x = $pos.X * $GRID_SIZE
        $y = $pos.Y * $GRID_SIZE
        
        if ($i -eq 0) {
            $g.FillRectangle($headBrush, $x, $y, $GRID_SIZE, $GRID_SIZE)
        } else {
            $g.FillRectangle($bodyBrush, $x, $y, $GRID_SIZE, $GRID_SIZE)
        }
        $g.DrawRectangle($borderPen, $x, $y, $GRID_SIZE, $GRID_SIZE)
    }
    
    $headBrush.Dispose()
    $bodyBrush.Dispose()
    
    # Zeichne Essen
    $foodBrush = New-Object System.Drawing.SolidBrush($RED)
    $foodX = $script:foodPosition.X * $GRID_SIZE
    $foodY = $script:foodPosition.Y * $GRID_SIZE
    $g.FillRectangle($foodBrush, $foodX, $foodY, $GRID_SIZE, $GRID_SIZE)
    $g.DrawRectangle($borderPen, $foodX, $foodY, $GRID_SIZE, $GRID_SIZE)
    $foodBrush.Dispose()
    $borderPen.Dispose()
    
    # Zeichne Score
    $font = New-Object System.Drawing.Font("Arial", 16)
    $textBrush = New-Object System.Drawing.SolidBrush($WHITE)
    $g.DrawString("Punkte: $($script:score)", $font, $textBrush, 10, 10)
    $font.Dispose()
    $textBrush.Dispose()
}

# Hauptfunktion
function Start-SnakeGame {
    # Formular erstellen
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Snake Game"
    $form.Size = New-Object System.Drawing.Size($WINDOW_WIDTH + 16, $WINDOW_HEIGHT + 39)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false
    $form.KeyPreview = $true
    
    # PictureBox für Zeichnung
    $pictureBox = New-Object System.Windows.Forms.PictureBox
    $pictureBox.Size = New-Object System.Drawing.Size($WINDOW_WIDTH, $WINDOW_HEIGHT)
    $pictureBox.Location = New-Object System.Drawing.Point(0, 0)
    $pictureBox.BackColor = $BLACK
    $form.Controls.Add($pictureBox)
    
    # Doppel-Buffering für flüssige Darstellung (mit Fehlerbehandlung)
    try {
        $pictureBox.GetType().GetProperty("DoubleBuffered", [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::NonPublic).SetValue($pictureBox, $true, $null)
    } catch {
        # Wenn DoubleBuffering nicht gesetzt werden kann, trotzdem fortfahren
        # Das Spiel funktioniert auch ohne, nur eventuell mit leichtem Flackern
    }
    
    # Paint Event
    $pictureBox.Add_Paint({ Draw-Game $_ })
    
    # Tastatur-Event
    $form.Add_KeyDown({
        param($sender, $e)
        
        switch ($e.KeyCode) {
            "Up" {
                if ($script:snakeDirection.X -ne 0 -or $script:snakeDirection.Y -ne 1) {
                    $script:snakeDirection = $script:UP
                }
            }
            "Down" {
                if ($script:snakeDirection.X -ne 0 -or $script:snakeDirection.Y -ne -1) {
                    $script:snakeDirection = $script:DOWN
                }
            }
            "Left" {
                if ($script:snakeDirection.X -ne 1 -or $script:snakeDirection.Y -ne 0) {
                    $script:snakeDirection = $script:LEFT
                }
            }
            "Right" {
                if ($script:snakeDirection.X -ne -1 -or $script:snakeDirection.Y -ne 0) {
                    $script:snakeDirection = $script:RIGHT
                }
            }
            "Escape" {
                $form.Close()
            }
        }
    })
    
    # Spiel initialisieren
    Initialize-Snake
    New-FoodPosition
    
    # Timer für Spiel-Loop
    $script:gameTimer = New-Object System.Windows.Forms.Timer
    $script:gameTimer.Interval = $GAME_SPEED
    $script:gameTimer.Add_Tick({
        Update-Snake
        $pictureBox.Invalidate()
    })
    $script:gameTimer.Start()
    
    # Form schließen Event
    $form.Add_FormClosing({
        $script:gameTimer.Stop()
        $script:gameTimer.Dispose()
    })
    
    # Zeige Formular
    [void]$form.ShowDialog()
    $form.Dispose()
}

# Spiel starten
Start-SnakeGame
