import Window (dimensions)

import Input   (input)
import Model   (Game, initialGame)
import Updates (step)
import View    (display)

main : Signal Element
main = lift2 display dimensions gameState

gameState : Signal Game
gameState = foldp step initialGame input
