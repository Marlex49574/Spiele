"""
Snake Game - Ein einfaches Snake-Spiel für Windows
Steuerung: Pfeiltasten
Ziel: Sammle die roten Punkte und werde länger!
"""

import pygame
import random
import sys

# Initialisierung
pygame.init()

# Konstanten
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
GRID_SIZE = 20
GRID_WIDTH = WINDOW_WIDTH // GRID_SIZE
GRID_HEIGHT = WINDOW_HEIGHT // GRID_SIZE

# Farben
BLACK = (0, 0, 0)
GREEN = (0, 255, 0)
RED = (255, 0, 0)
WHITE = (255, 255, 255)
DARK_GREEN = (0, 180, 0)

# Richtungen
UP = (0, -1)
DOWN = (0, 1)
LEFT = (-1, 0)
RIGHT = (1, 0)

class Snake:
    def __init__(self):
        self.length = 3
        self.positions = [(GRID_WIDTH // 2, GRID_HEIGHT // 2)]
        self.direction = random.choice([UP, DOWN, LEFT, RIGHT])
        self.color = GREEN
        self.score = 0

    def get_head_position(self):
        return self.positions[0]

    def update(self):
        cur = self.get_head_position()
        x, y = self.direction
        new = ((cur[0] + x) % GRID_WIDTH, (cur[1] + y) % GRID_HEIGHT)
        
        if len(self.positions) > 2 and new in self.positions[2:]:
            self.reset()
        else:
            self.positions.insert(0, new)
            if len(self.positions) > self.length:
                self.positions.pop()

    def reset(self):
        self.length = 3
        self.positions = [(GRID_WIDTH // 2, GRID_HEIGHT // 2)]
        self.direction = random.choice([UP, DOWN, LEFT, RIGHT])
        self.score = 0

    def render(self, surface):
        for i, p in enumerate(self.positions):
            x = p[0] * GRID_SIZE
            y = p[1] * GRID_SIZE
            
            # Kopf ist heller grün
            if i == 0:
                color = GREEN
            else:
                color = DARK_GREEN
            
            rect = pygame.Rect(x, y, GRID_SIZE, GRID_SIZE)
            pygame.draw.rect(surface, color, rect)
            pygame.draw.rect(surface, BLACK, rect, 1)

    def handle_keys(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_UP and self.direction != DOWN:
                    self.direction = UP
                elif event.key == pygame.K_DOWN and self.direction != UP:
                    self.direction = DOWN
                elif event.key == pygame.K_LEFT and self.direction != RIGHT:
                    self.direction = LEFT
                elif event.key == pygame.K_RIGHT and self.direction != LEFT:
                    self.direction = RIGHT
                elif event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()

class Food:
    def __init__(self):
        self.position = (0, 0)
        self.color = RED
        self.randomize_position()

    def randomize_position(self):
        self.position = (random.randint(0, GRID_WIDTH - 1),
                        random.randint(0, GRID_HEIGHT - 1))

    def render(self, surface):
        x = self.position[0] * GRID_SIZE
        y = self.position[1] * GRID_SIZE
        rect = pygame.Rect(x, y, GRID_SIZE, GRID_SIZE)
        pygame.draw.rect(surface, self.color, rect)
        pygame.draw.rect(surface, BLACK, rect, 1)

def draw_grid(surface):
    for y in range(0, WINDOW_HEIGHT, GRID_SIZE):
        for x in range(0, WINDOW_WIDTH, GRID_SIZE):
            rect = pygame.Rect(x, y, GRID_SIZE, GRID_SIZE)
            pygame.draw.rect(surface, (40, 40, 40), rect, 1)

def main():
    # Fenster erstellen
    screen = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
    pygame.display.set_caption('Snake Game')
    
    clock = pygame.time.Clock()
    
    # Spielobjekte
    snake = Snake()
    food = Food()
    
    # Font für Score
    font = pygame.font.Font(None, 36)
    
    # Spielschleife
    while True:
        # Events behandeln
        snake.handle_keys()
        
        # Update
        snake.update()
        
        # Prüfen ob Schlange Essen erreicht hat
        if snake.get_head_position() == food.position:
            snake.length += 1
            snake.score += 10
            food.randomize_position()
            # Stelle sicher, dass Essen nicht auf Schlange erscheint
            while food.position in snake.positions:
                food.randomize_position()
        
        # Zeichnen
        screen.fill(BLACK)
        draw_grid(screen)
        snake.render(screen)
        food.render(screen)
        
        # Score anzeigen
        score_text = font.render(f'Punkte: {snake.score}', True, WHITE)
        screen.blit(score_text, (10, 10))
        
        pygame.display.update()
        clock.tick(10)  # 10 FPS für angenehme Geschwindigkeit

if __name__ == '__main__':
    main()
