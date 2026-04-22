module Player where

import Board (getTile, Position, tile_size)

import Raylib.Util.Colors (green)
import Raylib.Core.Shapes (drawRectangle)

data Dir = Up | Down | Left | Right

data Player = Player {
	pos :: Position,
	dir :: Dir
}

-- playerGetMovementVector :: Player -> Vector2
-- playerGetMovementVector (_, _, Up, _) = Vector2 0 1
-- playerGetMovementVector (_, _, Down, _) = Vector2 0 -1
-- playerGetMovementVector (_, _, Left, _) = Vector2 -1 0
-- playerGetMovementVector (_, _, Right, _) = Vector2 1 0

drawPlayer :: Player -> IO ()
drawPlayer player = do
	let (x, y) = getTile (pos player)
	drawRectangle x y tile_size tile_size green


-- 	let movementVector = playerGetMovementVector player
-- 	let top = center + movementVector * 0.7
-- 	let right = center + (multiplicativeInverse movementVector) * 0.5
-- 	let left = center - (multiplicativeInverse movementVector) * 0.5
-- 	drawTriangle top right left green
	