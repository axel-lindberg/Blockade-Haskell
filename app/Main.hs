module Main (main) where
import Board (tile_size, screenWidth, screenHeight, tiles_h, tiles_v, drawBorder)
import Player ()

import Raylib.Core

import Raylib.Core.Shapes
import Raylib.Types

import Raylib.Core.Text
import Raylib.Util
import Raylib.Util.Colors

import Data.IORef
import Control.Monad (when)

data GameState = Start | Playing | GameOver deriving (Enum)
fps = 60

main :: IO ()
main = do
	initWindow screenWidth screenHeight "Blockade"
	setTargetFPS fps

	gameStateRef <- newIORef Start

	whileWindowOpen0 (do
		beginDrawing
		clearBackground black

		gameState <- readIORef gameStateRef

		case gameState of
			Start -> do
				drawText "Blockade" (round (fromIntegral(screenWidth)/fromIntegral(2)) - 18 * 5) 30 40 green
				drawText "Press SPACE to start" 200 (round (fromIntegral(screenWidth)/fromIntegral(2))) 40 green

				pressed <- isKeyPressed KeySpace
                
				when pressed (do 
					writeIORef gameStateRef Playing
					)
				
			Playing -> do 
				drawText "Playing" (round (fromIntegral(screenWidth)/fromIntegral(2)) - 18 * 5) 30 40 green

				drawBorder

				pressed <- isKeyPressed KeySpace
                
				when pressed (do 
					writeIORef gameStateRef GameOver
					)
					
			GameOver -> do
				drawText "Player # won!" (round (fromIntegral(screenWidth)/fromIntegral(2)) - 18 * 5) 30 40 green
				drawText "Press ENTER to play again" 400 (round (fromIntegral(screenWidth)/fromIntegral(2))) 40 green

				pressed <- isKeyPressed KeyEnter
                
				when pressed (do 
					writeIORef gameStateRef Start
					)
						
		endDrawing
		)

	-- closeWindow
