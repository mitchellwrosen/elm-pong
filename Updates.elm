module Updates where

import open Model
import open Input

stepObj t ({x,y,vx,vy} as obj) =
    { obj | x <- x + vx*t
          , y <- y + vy*t }

near : number -> number -> number -> Bool
near k c n = n >= k-c && n <= k+c

within ball paddle = near paddle.x 8  ball.x && 
                     near paddle.y 20 ball.y

stepV v lowerCollision upperCollision =
  if | lowerCollision -> abs v
     | upperCollision -> 0 - abs v
     | otherwise      -> v

stepBall : Time -> Ball -> Player -> Player -> Ball
stepBall t ({x,y,vx,vy} as ball) p1 p2 =
  if not (near 0 halfWidth ball.x)
  then { ball | x <- 0, y <- 0 }
  else stepObj t { ball | vx <- stepV vx (ball `within` p1.paddle) (ball `within` p2.paddle) ,
                          vy <- stepV vy (y < 7-halfHeight) (y > halfHeight-7) }

stepPlyr : Time -> Int -> Int -> Player -> Player
stepPlyr t dir points player =
  { player | paddle <- stepPaddle t dir player.paddle
           , score  <- player.score + points }

stepPaddle : Time -> Int -> Paddle -> Paddle
stepPaddle t dir paddle =
   let paddle1 = stepObj t { paddle | vy <- toFloat dir * 200 }
   in  { paddle1 | y <- clamp (22-halfHeight) (halfHeight-22) paddle1.y }

step : Input -> Game -> Game
step {space,dirL,dirR,delta} ({state,ball,playerL,playerR} as game) =
  let scoreL : Int
      scoreL = if ball.x >  halfWidth then 1 else 0
      scoreR = if ball.x < -halfWidth then 1 else 0
  in  {game| state   <- if | space            -> Play
                           | scoreL /= scoreR -> Pause
                           | otherwise        -> state
           , ball    <- if state == Pause then ball else
                            stepBall delta ball playerL playerR
           , playerL <- stepPlyr delta dirL scoreL playerL
           , playerR <- stepPlyr delta dirR scoreR playerR }
