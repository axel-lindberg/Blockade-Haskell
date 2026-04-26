module Main (main) where
import Board
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
fps = 1

main :: IO ()
main = do
	initWindow screenWidth screenHeight "Blockade"
	setTargetFPS fps

	whileWindowOpen0 (do

		let initialState =
			GameState {
				mode = Start,
				player1 = Player (3, 3) PlayerDown,
				player2 = Player (24, 21) PlayerUp,
				trail = []
			}
		
		gameLoop initialState
		)

	--closeWindow
