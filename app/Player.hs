module Player where

import Raylib.Util.Colors (lightGray, black, green)

data Dir = Up | Down | Left | Right deriving (Enum, Show)
data Player = Player {
	pos_x :: Int,	
	pos_y :: Int,
	dir :: Dir,
	score :: Int
}

-- playerGetMovementVector :: Player -> Vector2
-- playerGetMovementVector (_, _, Up, _) = Vector2 0 1
-- playerGetMovementVector (_, _, Down, _) = Vector2 0 -1
-- playerGetMovementVector (_, _, Left, _) = Vector2 -1 0
-- playerGetMovementVector (_, _, Right, _) = Vector2 1 0

-- drawPlayer :: Player -> IO ()
-- drawPlayer player = do
-- 	let center = getTileCoord (pos_x player) (pos_y player)
-- 	let movementVector = playerGetMovementVector player
-- 	let top = center + movementVector * 0.7
-- 	let right = center + (multiplicativeInverse movementVector) * 0.5
-- 	let left = center - (multiplicativeInverse movementVector) * 0.5
-- 	drawTriangle top right left green
	