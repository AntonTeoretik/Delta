{-# LANGUAGE FlexibleContexts #-}

module OrbitAroundVectors where
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT as GLUT
import Data.IORef

import TempParticles

import PointsForRendering
import StateUtil
import Algebra as A
import OrbitPointOfView
import StateUtil
import Graphics
import Circle
import Example

locally = preservingMatrix

_STEP = 0.01

main' = do
   (progName,_) <- getArgsAndInitialize
   initialDisplayMode $= [WithDepthBuffer, DoubleBuffered]
   createWindow progName
   depthFunc $= Just Less

   pPos <- new (90 :: Int, 270 :: Int, 2.0)
   keyboardMouseCallback $= Just (keyboard pPos)
   
   force <- new myForce --я не уверенна откуда сила берётся -> сама сделала
   aParticle <- new myParticle
   particleSystem <- new myParticleSystem
   step <- new _STEP
   field1 <- new simpleField
   field2 <- new otherField
   --idleCallback $= Just (idleParticle aParticle step force)
   idleCallback $= Just (idleParticleSystem particleSystem step field1 field2)

   displayCallback $= display pPos particleSystem
   reshapeCallback $= Just reshape
   mainLoop

--Тут менять функцию/точки
--display :: (HasGetter t (a, b, GLdouble), Integral b, Integral a) => t -> IO()
display pPos particleSystem = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   --p <- get aParticle
   ps <- get particleSystem
   --displayVecField simpleField points --рисует данное поле
   --translate$Vector3 (px $ TempParticles.position p) (py $  TempParticles.position p) (pz $ TempParticles.position p) -- рисует одну частицу
   --fillCircle 0.1 --рисует одну частицу
   mapM_ (shiftCircle 0.1) (listOfParticles ps) --рисует все частицы 
   swapBuffers

keyboard pPos c _ _ _ = keyForPos pPos c

shiftCircle :: Double -> Particle -> IO()
shiftCircle r p = do
   translate$Vector3 (px $ TempParticles.position p) (py $  TempParticles.position p) (pz $ TempParticles.position p)
   fillCircle r
   translate $ Vector3 ((* (-1)) $ px $ TempParticles.position p) ((* (-1)) $ py $ TempParticles.position p) ((* (-1)) $ pz $ TempParticles.position p)
   

idleParticle aParticle step force = do
  p <- get aParticle
  s <- get step
  f <- get force
  aParticle $= evaluateParticle s f p
  postRedisplay Nothing


idleParticleSystem particleSystem step field1 field2 = do
  ps <- get particleSystem
  s <- get step
  f1 <- get field1
  f2 <- get field2
  particleSystem $= evaluateSystemOfParticles s f1 f2 ps
  postRedisplay Nothing 
