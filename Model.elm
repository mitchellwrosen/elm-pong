module Model where

(gameWidth, gameHeight) = (600, 400)
(halfWidth, halfHeight) = (300, 200)

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
   { state   : State 
   , ball    : Ball 
   , playerL : Player 
   , playerR : Player 
   }

initialGame : Game
initialGame = 
   { state   = Pause 
   , ball    = { x=0, y=0, vx=200, vy=200 } 
   , playerL = { paddle = { x = 20-300, y = 0, vx = 0, vy = 0 }, score = 0 } 
   , playerR = { paddle = { x = 300-20, y = 0, vx = 0, vy = 0 }, score = 0 } 
   }
