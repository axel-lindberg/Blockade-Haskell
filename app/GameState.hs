module GameState(Mode(..), GameState(..), updateGame, drawGame, gameLoop) where

import Player
import Board
import Raylib.Core
import Raylib.Types
import Raylib.Core.Text
import Raylib.Util.Colors
import Raylib.Core.Textures

data Mode = Start | Playing | GameOver
type Trail = [Position]

data GameState = GameState {
	mode :: Mode,
	player1 :: Player,
	player2 :: Player,
    trail :: Trail,
    texture1 :: Texture,
    texture2 :: Texture
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

            let position1 = playerPosition player1'
                position2 = playerPosition player2'
                oldTrail = trail gameState

            let collision = isOutOfBounds position1 || isOutOfBounds position2 || elem position1 oldTrail || elem position2 oldTrail

            let trail' = position1 : position2 : oldTrail

            if collision
                then return gameState {mode = GameOver}
                else return gameState {player1 = player1', player2 = player2', trail = trail'}

        GameOver -> do
            pressed <- isKeyPressed KeyEnter
            return (if pressed then gameState {
                mode = Start,
                player1 = Player (3, 3) PlayerDown,
                player2 = Player (24, 21) PlayerUp,
                trail = [(3, 3), (24, 21)]
                }
                else gameState)

drawGame :: GameState -> IO()
drawGame gameState =
    case mode gameState of
        Start -> do 
            textWidth1 <- measureText "Blockade" 40
            textWidth2 <- measureText "Press Space to start" 40
            drawText "Blockade" (div (screenWidth - textWidth1) 2) 300 40 green
            drawText "Press Space to start" (div (screenWidth - textWidth2) 2) 400 40 green

        Playing -> do
            drawBorder
            mapM_ drawTrailTile (trail gameState)
            drawPlayer (player1 gameState) (texture1 gameState)
            drawPlayer (player2 gameState) (texture2 gameState)
        
        GameOver -> do
            textWidth1 <- measureText "Game Over" 40
            textWidth2 <- measureText "Press Enter to play again" 40
            drawText "Game Over" (div (screenWidth - textWidth1) 2) 300 40 green
            drawText "Press Enter to play again" (div (screenWidth - textWidth2) 2) 400 40 green

gameLoop :: GameState -> IO()
gameLoop gameState = do
    beginDrawing
    clearBackground black

    gameState' <- updateGame gameState
    drawGame gameState'

    endDrawing
    
    gameLoop gameState'