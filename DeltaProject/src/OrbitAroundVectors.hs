{-# LANGUAGE FlexibleContexts #-}

module OrbitAroundVectors where
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT as GLUT
import Data.IORef

import TempParticles as TMP
import TempMasslessParticles as TVP --есть изменения к TempMasslessParticles - я дала имена элементам VirtualParticle и virtualSystemOfParticles

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
   
   points <- new myPoints
   force <- new myForce 
   massParticle <- new myParticle
   particleSystem <- new myParticleSystem
   
   virtualParticle <- new myVirtualParticle
   vParticleSystem <- new myVirtualParticleSystem 

   step <- new _STEP
   field1 <- new simpleField
   field2 <- new otherField
   idleCallback $= Just (idleParticleSystem particleSystem step field1 field2) --двигает много массивных частиц + запоминает предыдущие положения
   --idleCallback $= Just (idleVPS vParticleSystem step field1) --двигает много виртуальных частиц
   displayCallback $= displayMass pPos particleSystem
   reshapeCallback $= Just reshape
   mainLoop

displayField pPos field points= do
   f <- field
   ps <- points
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   displayVecField f ps --рисует векторное поле 


displayMass pPos particleSystem = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   ps <- get particleSystem
   mapM_ (massShiftCircle 0.1) (listOfParticles ps) --рисует массовые частицы 
   mapM_ particleTrail (listOfParticles ps) --рисует след
   swapBuffers

displayVirtual pPos vParticleSystem = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   vps <- get vParticleSystem
   mapM_ (virtualShiftCircle 0.1) (listOfVirtualParticles vps) -- рисует виртуальные частицы
   swapBuffers

particleTrail :: TMP.Particle -> IO()
particleTrail massParticle = do
   renderAs Lines $ pointToTriple $ track massParticle
 
pointToTriple points = map pT points

pT (A.Point x y z) = (x, y, z)

keyboard pPos c _ _ _ = keyForPos pPos c

massShiftCircle :: Double -> Particle -> IO()
massShiftCircle r p = preservingMatrix $ 
                     do 
                        (translate $ Vector3 (px $ TMP.position p) (py $  TMP.position p) (pz $ TMP.position p))
                        renderSphere r 10 10 

virtualShiftCircle :: Double -> VirtualParticle -> IO()
virtualShiftCircle r p = preservingMatrix $
                     do
                        (translate $ Vector3 (px $ TVP.position p) (py $  TVP.position p) (pz $ TVP.position p))
                        renderOtherSphere r 10 10



idleParticleSystem particleSystem step field1 field2 = do
  ps <- get particleSystem
  s <- get step
  f1 <- get field1
  f2 <- get field2
  particleSystem $= TMP.evaluateSystemOfParticles s f1 f2 ps
  postRedisplay Nothing

idleVPS vParticleSystem step field1 = do 
  vps <- get vParticleSystem
  s <- get step
  f1 <- get field1
  vParticleSystem $= TVP.evaluateSVP s f1 vps
  postRedisplay Nothing
