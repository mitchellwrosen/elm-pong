import Window (dimensions)

import Input   (input)
import Model   (Game, game)
import View    (display)
import Updates (step)

main : Signal Element
main = lift2 display dimensions gameState

gameState : Signal Game
gameState = foldp step game input
