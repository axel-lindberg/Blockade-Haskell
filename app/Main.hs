module Main (main) where
	-- import Board (tile_size)

import Raylib.Core

import Raylib.Core.Shapes
import Raylib.Types

import Raylib.Core.Text
import Raylib.Util
import Raylib.Util.Colors

import Data.IORef
import Control.Monad (when)

data GameState = Start | Playing | GameOver deriving (Enum)

tile_size = 16

width = 1280
height = 1080
fps = 60

tiles_h = round(fromIntegral(width) / fromIntegral(tile_size))
tiles_v = round (fromIntegral(height) / fromIntegral(tile_size))

drawBorder :: IO ()
drawBorder = do
	drawRectangle 0 0 width tile_size green -- Top
	drawRectangle (width - tile_size) 0 tile_size height green -- Right
	drawRectangle 0 (height - tile_size) width tile_size green -- Bottom
	drawRectangle 0 0 tile_size height green -- Left

main :: IO ()
main = do
	initWindow width height "Blockade"
	setTargetFPS fps

	gameStateRef <- newIORef Start

	whileWindowOpen0 (do
		beginDrawing
		clearBackground black

		gameState <- readIORef gameStateRef

		case gameState of
			Start -> do
				drawText "Blockade" (round (fromIntegral(width)/fromIntegral(2)) - 18 * 5) 30 40 green
				drawText "Press SPACE to start" 400 (round (fromIntegral(width)/fromIntegral(2))) 40 green

				pressed <- isKeyPressed KeySpace
                
				when pressed (do 
					writeIORef gameStateRef Playing
					)
				
			Playing -> do 
				drawText "Playing" (round (fromIntegral(width)/fromIntegral(2)) - 18 * 5) 30 40 green
					
			--GameOver -> do
						--drawText "Player # won!" 400 300 40 green
						
		drawBorder

		endDrawing
		)

	-- closeWindow
