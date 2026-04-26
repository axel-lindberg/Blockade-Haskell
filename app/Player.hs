module Player(Player(..), Dir(..), drawPlayer, movePlayer, inputPlayer1, inputPlayer2) where

import Board

import Raylib.Core
import Raylib.Util.Colors (green)
import Raylib.Core.Shapes (drawRectangle)
import Raylib.Types

data Dir = PlayerUp | PlayerDown | PlayerLeft | PlayerRight

data Player = Player {
	playerPosition :: Position,
	direction :: Dir
}

-- playerGetMovementVector :: Player -> Vector2
-- playerGetMovementVector (_, _, Up, _) = Vector2 0 1
-- playerGetMovementVector (_, _, Down, _) = Vector2 0 -1
-- playerGetMovementVector (_, _, Left, _) = Vector2 -1 0
-- playerGetMovementVector (_, _, Right, _) = Vector2 1 0

-- 	let movementVector = playerGetMovementVector player
-- 	let top = center + movementVector * 0.7
-- 	let right = center + (multiplicativeInverse movementVector) * 0.5
-- 	let left = center - (multiplicativeInverse movementVector) * 0.5
-- 	drawTriangle top right left green

drawPlayer :: Player -> IO ()
drawPlayer player = do
	let (x, y) = getTile (playerPosition player)
	drawRectangle x y tile_size tile_size green

movePlayer :: Player -> (Player -> IO Player) -> IO Player
movePlayer player inputPlayer = do
	player' <- inputPlayer player
	let (x, y) = playerPosition player'
	return (case direction player' of
		PlayerUp	-> player' {playerPosition = (x, y - 1)}
		PlayerDown	-> player' {playerPosition = (x, y + 1)}
		PlayerLeft	-> player' {playerPosition = (x - 1, y)}
		PlayerRight	-> player' {playerPosition = (x + 1, y)})


inputPlayer1 :: Player -> IO Player
inputPlayer1 player = do
	pressedW <- isKeyPressed KeyW
	pressedA <- isKeyPressed KeyA
	pressedS <- isKeyPressed KeyS
	pressedD <- isKeyPressed KeyD

	return (if pressedW then player {direction = PlayerUp}
			 else if pressedA then player {direction = PlayerLeft}
			 else if pressedS then player {direction = PlayerDown}
			 else if pressedD then player {direction = PlayerRight}
			 else player)

inputPlayer2 :: Player -> IO Player
inputPlayer2 player = do
	pressedUp <- isKeyPressed KeyUp
	pressedLeft <- isKeyPressed KeyLeft
	pressedDown <- isKeyPressed KeyDown
	pressedRight <- isKeyPressed KeyRight

	return (if pressedUp then player {direction = PlayerUp}
			 else if pressedLeft then player {direction = PlayerLeft}
			 else if pressedDown then player {direction = PlayerDown}
			 else if pressedRight then player {direction = PlayerRight}
			 else player)