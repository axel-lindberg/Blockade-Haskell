module Board where

data Tiles = Tiles {
    posX :: Int,
    posY :: Int,
    marked :: Bool
}

-- tile_size = 16
-- tiles_h = round(fromIntegral(width) / fromIntegral(tile_size))
-- tiles_v = round (fromIntegral(height) / fromIntegral(tile_size))

-- getTileCoord :: Int -> Int -> Vector2
-- getTileCoord x y = Vector2 (x * tiles_v) (y * tiles_h)