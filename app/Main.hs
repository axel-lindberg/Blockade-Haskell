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
import Raylib.Core.Textures

import Data.IORef

fps:: Int
fps = 2

main :: IO ()
main = do
    initWindow screenWidth screenHeight "Blockade"
    setTargetFPS fps

    texturePlayer1 <- loadTexture "assets/player1Arrow.png"
    texturePlayer2 <- loadTexture "assets/player2Arrow.png"

    let initialState =
            GameState
                { mode = Start
                , player1 = Player (3, 3) PlayerDown
                , player2 = Player (24, 21) PlayerUp
                , trail = [(3, 3), (24, 21)]
                , texture1 = texturePlayer1
                , texture2 = texturePlayer2
                }

    gameLoop initialState
