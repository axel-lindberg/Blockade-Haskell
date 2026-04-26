module Board(Position, Tile(..), tile_size, screenWidth, screenHeight, tiles_h, tiles_v, getTile, drawBorder) where

import Raylib.Util.Colors (green)
import Raylib.Core.Shapes (drawRectangle)

type Position = (Int, Int)

data Tile = Tile {
    position :: Position
}

tile_size :: Int
tile_size = 32

screenWidth :: Int
screenWidth = 896

screenHeight :: Int
screenHeight = 800

tiles_h :: Int
tiles_h = round(fromIntegral(screenWidth) / fromIntegral(tile_size))

tiles_v :: Int
tiles_v = round (fromIntegral(screenHeight) / fromIntegral(tile_size))

getTile :: (Int, Int) -> Position
getTile (x, y) = (x * tile_size, y * tile_size)

drawBorder :: IO ()
drawBorder = do
	drawRectangle 0 0 screenWidth tile_size green -- Top
	drawRectangle (screenWidth - tile_size) 0 tile_size screenHeight green -- Right
	drawRectangle 0 (screenHeight - tile_size) screenWidth tile_size green -- Bottom
	drawRectangle 0 0 tile_size screenHeight green -- Left