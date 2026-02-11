module Main (main) where

import Raylib.Core 
	(
		beginDrawing,
		endDrawing,
		clearBackground,
		initWindow,
		closeWindow,
		setTargetFPS,
	)

import Raylib.Core.Shapes (drawRectangle)

import Raylib.Core.Text (drawText)
import Raylib.Util (whileWindowOpen0)
import Raylib.Util.Colors (lightGray, black, green)

width = 1280
height = 1080
fps = 60

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

	whileWindowOpen0 
		( do
			beginDrawing

			clearBackground black
			drawText "Hello, World!" 30 40 18 lightGray
			drawBorder

			endDrawing
		)

	-- closeWindow
