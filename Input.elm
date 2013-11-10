module Input (Input, input) where

import Keyboard

type Input = { space : Bool
             , dirL  : Int -- {x:Int,y:Int}
             , dirR  : Int -- {x:Int,y:Int}
             , delta : Time
             }

input : Signal Input
input = sampleOn delta (Input <~ Keyboard.space
                               ~ lift .y Keyboard.wasd
                               ~ lift .y Keyboard.arrows
                               ~ delta)

delta : Signal Time
delta = inSeconds <~ fps 50
