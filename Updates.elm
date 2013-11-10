module Updates (step) where

import open Input
import open Model

step : Input -> Game -> Game
step {space,dirL,dirR,delta} ({state,ball,playerL,playerR} as game) =
  let scoreL = if ball.x >  halfWidth then 1 else 0
      scoreR = if ball.x < -halfWidth then 1 else 0
  in  { game | state   <- stepState space scoreL scoreR state
             , ball    <- stepBall state delta ball playerL.paddle playerR.paddle
             , playerL <- stepPlayer delta dirL scoreL playerL
             , playerR <- stepPlayer delta dirR scoreR playerR }

stepState : Bool -> Int -> Int -> State -> State
stepState space scoreL scoreR state =
   if | space            -> Play
      | scoreL /= scoreR -> Pause
      | otherwise        -> state

stepBall : State -> Time -> Ball -> Paddle -> Paddle -> Ball
stepBall state t ({x,y,vx,vy} as ball) paddleL paddleR =
    if | state == Pause                -> ball
       | not (near 0 halfWidth ball.x) -> { ball | x <- 0, y <- 0 }
       | otherwise                     ->
           stepObj t { ball | vx <- stepVelocity vx (ball `within` paddleL) (ball `within` paddleR)
                            , vy <- stepVelocity vy (y < 7-halfHeight) (y > halfHeight-7) }

stepPlayer : Time -> Int -> Int -> Player -> Player
stepPlayer t dir points player =
  { player | paddle <- stepPaddle t dir player.paddle
           , score  <- player.score + points }

stepPaddle : Time -> Int -> Paddle -> Paddle
stepPaddle t dir paddle =
   let paddle' = stepObj t { paddle | vy <- toFloat dir * 200 }
   in  { paddle' | y <- clamp (22-halfHeight) (halfHeight-22) paddle'.y }

stepObj t ({x,y,vx,vy} as obj) =
    { obj | x <- x + vx*t
          , y <- y + vy*t }

near : number -> number -> number -> Bool
near bullseye radius dart = abs (dart-bullseye) <= radius

within ball paddle = near paddle.x 8 ball.x && near paddle.y 20 ball.y

stepVelocity v lowerCollision upperCollision =
  if | lowerCollision -> abs v
     | upperCollision -> 0 - abs v
     | otherwise      -> v
