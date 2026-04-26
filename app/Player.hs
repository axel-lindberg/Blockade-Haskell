module Player(Player(..), Dir(..), drawPlayer, movePlayer, inputPlayer1, inputPlayer2, isOutOfBounds) where

import Board

import Raylib.Core
import Raylib.Util.Colors
import Raylib.Core.Shapes (drawRectangle)
import Raylib.Types
import Raylib.Core.Textures

data Dir = PlayerUp | PlayerDown | PlayerLeft | PlayerRight
	deriving (Eq)

data Player = Player {
	playerPosition :: Position,
	direction :: Dir
}

drawPlayer :: Player -> Texture -> IO ()
drawPlayer player texture = do
    let (x, y) = getTile (playerPosition player)

        rotation =
            case direction player of
                PlayerUp    -> 0
                PlayerRight -> 90
                PlayerDown  -> 180
                PlayerLeft  -> 270

        destRect = Rectangle
            (fromIntegral x + fromIntegral tile_size / 2)
            (fromIntegral y + fromIntegral tile_size / 2)
            (fromIntegral tile_size)
            (fromIntegral tile_size)

        sourceRect = Rectangle 0 0 32 32

        origin = Vector2
            (fromIntegral tile_size / 2)
            (fromIntegral tile_size / 2)

    drawTexturePro texture sourceRect destRect origin rotation white

	

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
	let oldDirection = direction player
	pressedW <- isKeyPressed KeyW
	pressedA <- isKeyPressed KeyA
	pressedS <- isKeyPressed KeyS
	pressedD <- isKeyPressed KeyD

	return (if pressedW && (oldDirection /= PlayerDown) then player {direction = PlayerUp}
			 else if pressedA && (oldDirection /= PlayerRight) then player {direction = PlayerLeft}
			 else if pressedS && (oldDirection /= PlayerUp) then player {direction = PlayerDown}
			 else if pressedD && (oldDirection /= PlayerLeft) then player {direction = PlayerRight}
			 else player)

inputPlayer2 :: Player -> IO Player
inputPlayer2 player = do
	let oldDirection = direction player
	pressedUp <- isKeyPressed KeyUp
	pressedLeft <- isKeyPressed KeyLeft
	pressedDown <- isKeyPressed KeyDown
	pressedRight <- isKeyPressed KeyRight

	return (if pressedUp && (oldDirection /= PlayerDown) then player {direction = PlayerUp}
			 else if pressedLeft && (oldDirection /= PlayerRight) then player {direction = PlayerLeft}
			 else if pressedDown && (oldDirection /= PlayerUp) then player {direction = PlayerDown}
			 else if pressedRight && (oldDirection /= PlayerLeft) then player {direction = PlayerRight}
			 else player)
			
isOutOfBounds :: Position -> Bool
isOutOfBounds (x, y) =
    x <= 0 || x >= tiles_W - 1 ||
    y <= 0 || y >= tiles_H - 1