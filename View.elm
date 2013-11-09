module View where

import open Import
import open Model

pongGreen : Color
pongGreen = rgb 60 100 60

textGreen : Color
textGreen = rgb 160 200 160

display : (Int,Int) -> Game -> Element
display (w,h) {width,height,state,ball,playerL,playerR} =
  let scores : Element
      scores = txt (Text.height 50) (show playerL.score ++ "  " ++ show playerR.score)
  in container w h middle $ collage width height
       [ boardf width height
       , ballf ball
       , paddlef playerL.paddle
       , paddlef playerR.paddle
       , toForm scores & move (0, (toFloat height)/2 - 40)
       , toForm (if state == Play then spacer 1 1 else txt id msg)
           & move (0, 40 - (toFloat height)/2)
       ]

boardf : Int -> Int -> Form
boardf width height = rect (toFloat width) (toFloat height) & filled pongGreen

ballf : Ball -> Form
ballf ball = oval 15 15
   & filled white
   & move (ball.x, ball.y)

paddlef : Paddle -> Form
paddlef paddle = rect 10 40
   & filled white
   & move (paddle.x, paddle.y)

txt : (Text -> Text) -> String -> Element
txt f = text . f . monospace . Text.color textGreen . toText

msg : String
msg = "SPACE to start, WS and &uarr;&darr; to move"
