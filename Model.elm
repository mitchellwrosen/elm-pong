module Model where

halfWidth = 300
halfHeight = 200

data State = Play | Pause

type Ball = 
   { x  : Float
   , y  : Float
   , vx : Float
   , vy : Float 
   }

type Paddle = 
   { x  : Float
   , y  : Float
   , vx : Float
   , vy : Float 
   }

type Player = 
   { paddle : Paddle
   , score  : Int 
   }

type Game = 
   { width   : Int 
   , height  : Int 
   , state   : State 
   , ball    : Ball 
   , playerL : Player 
   , playerR : Player 
   }

game : Game
game = { width  = 600
       , height = 400 
       , state  = Pause 
       , ball    = { x=0, y=0, vx=200, vy=200 }
       , playerL = { paddle = { x = 20-300, y = 0, vx = 0, vy = 0 }, score = 0 }
       , playerR = { paddle = { x = 300-20, y = 0, vx = 0, vy = 0 }, score = 0 }
       }
