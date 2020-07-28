module Perspective where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT as GLUT

import Circle
import PointsForRendering


main = do
  (progName,_) <- getArgsAndInitialize
  initialDisplayMode $= [WithDepthBuffer] --lets depth be a thing
  createWindow progName
  depthFunc $= Just Less --ensures closer objects hide objects that are farther away
  clearColor $= Color4 0 0 0 0
  displayCallback $= display

  reshapeCallback $= Just reshape
  
  matrixMode $= Projection
  loadIdentity
  let near  = 1  --want this value to be small so that you're not farsighted
      far   = 40 --want this value to be big so that you're not nearsighted
      right = 1
      top   = 1
  frustum (-right) right (-top) top near far
  matrixMode $= Modelview 0

  clearColor $= Color4 1 1 1 1
  mainLoop

display = do
  clear [ColorBuffer, DepthBuffer]
  loadIdentity --loads identity matrix
  translate (Vector3 0 0 (-2 :: GLfloat))
  currentColor $= Color4 0 0 1 1
  fillCircle 1

  loadIdentity
  translate (Vector3 4 4 (-5::GLfloat))
  currentColor $= Color4 0 1 0 1
  fillCircle 1
  flush
  

reshape s@(Size w h) = do
  --viewport $= (Position 0 0, s) --keeps the display function in the center of the window
  viewport $= (Position 50 50, Size (w - 80) (h - 60)) -- makes the image smaller than the window


  --frustum : left, right, top, bottom, near, far
