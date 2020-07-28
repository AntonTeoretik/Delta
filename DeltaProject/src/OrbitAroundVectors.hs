{-# LANGUAGE FlexibleContexts #-}

module OrbitAroundVectors where
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT as GLUT

import Algebra as A
import OrbitPointOfView
import StateUtil
import Graphics
import Circle
import Example

locally = preservingMatrix

main' = do
   (progName,_) <- getArgsAndInitialize
   initialDisplayMode $= [WithDepthBuffer, DoubleBuffered]
   createWindow progName
   depthFunc $= Just Less

   pPos <- new (90 :: Int, 270 :: Int, 2.0)
   keyboardMouseCallback $= Just (keyboard pPos)

   displayCallback $= display pPos
   reshapeCallback $= Just reshape
   mainLoop

--Тут менять функцию/точки
display pPos = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   displayVecField simpleField [(A.Point 0.5 0.1 0)
                               ,(A.Point 0.1 0.1 (-3))                                         ,(A.Point 0.5 0.5 0)
                               ,(A.Point 0.1 0.5 2)
                               ,(A.Point 1 0 0)]
   swapBuffers

keyboard pPos c _ _ _ = keyForPos pPos c