module View where

import open Import
import open Model

display : (Int,Int) -> Game -> Element
display (windowWidth, windowHeight) {state,ball,playerL,playerR} =
    container windowWidth windowHeight middle $
        collage gameWidth gameHeight
            [ boardf
            , midlinef
            , ballf ball
            , paddlef playerL.paddle
            , paddlef playerR.paddle
            , scoresf playerL.score playerR.score 
            , infof state
            ]

midlinef : Form
midlinef = let midline = dashed black in 
   segment (0, -halfHeight) (0,halfHeight)
      & traced { midline | width <- 5 }


boardf : Form
boardf = rect (toFloat gameWidth) (toFloat gameHeight) 
   & filled (rgb 60 100 60)

ballf : Ball -> Form
ballf ball = oval 15 15
   & filled white
   & move (ball.x, ball.y)

paddlef : Paddle -> Form
paddlef paddle = rect 10 40
   & filled white
   & move (paddle.x, paddle.y)

scoresf : Int -> Int -> Form
scoresf scoreL scoreR = textf (Text.height 50) (show scoreL ++ "  " ++ show scoreR)
   & move (0, toFloat gameHeight / 2 - 40)

infof : State -> Form
infof state = 
   if state == Play 
      then toForm (spacer 1 1) 
      else textf id "SPACE to start, WS and &uarr;&darr; to move"
   & move (0, 40 - toFloat gameHeight / 2)

textf : (Text -> Text) -> String -> Form
textf f = toForm . text . f . monospace . Text.color (rgb 60 200 160) . toText
