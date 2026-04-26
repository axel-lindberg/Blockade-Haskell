module GameState(Mode(..), GameState(..), updateGame, drawGame, gameLoop) where

import Player
import Board
import Raylib.Core
import Raylib.Types
import Raylib.Core.Text
import Raylib.Util.Colors

data Mode = Start | Playing | GameOver

data GameState = GameState {
	mode :: Mode,
	player1 :: Player,
	player2 :: Player
	}

updateGame :: GameState -> IO GameState
updateGame gameState =
    case mode gameState of
        Start -> do
            pressed <- isKeyPressed KeySpace
            return (if pressed then gameState {mode = Playing} else gameState)
        
        Playing -> do
            player1' <- movePlayer (player1 gameState) inputPlayer1
            player2' <- movePlayer (player2 gameState) inputPlayer2
            return gameState {player1 = player1', player2 = player2'}

        GameOver -> do
            pressed <- isKeyPressed KeySpace
            return (if pressed then gameState {mode = Start} else gameState)

drawGame :: GameState -> IO()
drawGame gameState =
    case mode gameState of
        Start -> do 
            drawText "Blockade" 400 300 40 green

        Playing -> do
            drawBorder
            drawPlayer (player1 gameState)
            drawPlayer (player2 gameState)
        
        GameOver -> do
            drawText "Game Over" 400 300 40 green

gameLoop :: GameState -> IO()
gameLoop gameState = do
    beginDrawing
    clearBackground black

    gameState' <- updateGame gameState
    drawGame gameState'

    endDrawing
    
    gameLoop gameState'