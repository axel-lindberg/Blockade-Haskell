module Board(Position, Tile(..), tile_size, screenWidth, screenHeight, tiles_H, tiles_W, getTile, drawBorder, drawTile, drawTrailTile) where

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

-- Get amount of tiles horizontally
tiles_W :: Int
tiles_W = div screenWidth tile_size

-- Get amount of tiles vertically
tiles_H :: Int
tiles_H = div screenHeight tile_size

-- Get pixel coordinate of a tile
getTile :: (Int, Int) -> Position
getTile (x, y) = (x * tile_size, y * tile_size)

-- Draw rectangle at position
drawTile :: Tile -> IO ()
drawTile tile =
	let (x, y) = getTile (position tile)
	in drawRectangle x y tile_size tile_size green

-- Add tiles around the map
drawBorder :: IO ()
drawBorder = 
	mapM_ drawTile borderTiles
	where
		top = [Tile (x, 0) | x <- [0 .. tiles_W]]
		bottom = [Tile (x, tiles_H - 1) | x <- [0 .. tiles_W]]
		left = [Tile (0, y) | y <- [0 .. tiles_H - 1]]
		right = [Tile (tiles_W - 1, y) | y <- [0 .. tiles_H - 1]]

		borderTiles = top ++ bottom ++ left ++ right

-- Helper function to call draw tile for positions
drawTrailTile :: Position -> IO ()
drawTrailTile position = drawTile (Tile position)
