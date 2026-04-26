module Main (main) where
import Board (tile_size, screenWidth, screenHeight, tiles_h, tiles_v, drawBorder)
import Player
import GameState

import Raylib.Core

import Raylib.Core.Shapes
import Raylib.Types

import Raylib.Core.Text
import Raylib.Util
import Raylib.Util.Colors

import Data.IORef

fps:: Int
fps = 4

main :: IO ()
main = do
	initWindow screenWidth screenHeight "Blockade"
	setTargetFPS fps

	whileWindowOpen0 (do
		beginDrawing
		clearBackground black

		let initialState =
			GameState {
				mode = Start,
				player1 = Player (5, 5) PlayerRight,
				player2 = Player (10, 10) PlayerLeft
			}
		
		gameLoop initialState
		)

	--closeWindow
