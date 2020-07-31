{-# LANGUAGE FlexibleContexts #-}

module Idle where

import Circle
import PointsForRendering
import StateUtil

import Graphics.Rendering.OpenGL
import Data.IORef
import Graphics.UI.GLUT as GLUT

_STEP = 0.001

main'' = do
  (progName,_) <- getArgsAndInitialize
  initialDisplayMode $= [DoubleBuffered]
  createWindow progName
  radius <- new 0.1
  step <- new _STEP
  displayCallback $= display radius
  idleCallback $= Just (idle radius step)
  mainLoop

display radius = do
  clear [ColorBuffer]
  r <- get radius
  renderCircle r 
  swapBuffers

idle radius step = do
  r <- get radius
  s <- get step
  if r >= 1 then step $= _STEP
            else if r <= 0 then step $= _STEP
                           else return ()

  s <- get step
  radius $= r + s
  postRedisplay Nothing


