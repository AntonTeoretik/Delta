{-# LANGUAGE FlexibleContexts #-}

module OrbitAroundVectors where
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT as GLUT
import Data.IORef

import Particles as TMP
import TempMasslessParticles as TVP --есть изменения к TempMasslessParticles - я дала имена элементам VirtualParticle и virtualSystemOfParticles
import ForceLines --изменения: дала название элементу ForceLines, сделала чтобы в каждой силовой линии конечное количество точек
import Magnetic
import Random
import Distribution

import PointsForRendering
import StateUtil
import Algebra as A
import OrbitPointOfView
import StateUtil
import Graphics
import Circle
import Example
import Electric

locally = preservingMatrix

_STEP = 0.01 --промежуток времени который проходит между шагами idle

--тут определить всякие физические переменные:
_RADIUS = 0.08 -- радиус сферы которая рисует частицы
_CUBELENGTH = 5 -- длина стороны куба который для generatePointsFromCube
_POINTDIST = 0.01 -- растояние между точками на силовой линии
_FORCELINENUM = 100 -- количество силовых линий
_GENERATECUBEPOINTS = 10 --что-то про generatePointsFromCube, не знаю что делает
_CURRENT = (-3) --ток в магнитном поле
_NUMBER = 100 --число которое берёт circuitFromFunction - не знаю, что делает
_CHARGE = 1

main' = do
   (progName,_) <- getArgsAndInitialize
   initialDisplayMode $= [WithDepthBuffer, DoubleBuffered]
   createWindow progName
   depthFunc $= Just Less

   pPos <- new (90 :: Int, 270 :: Int, 2.0)
   keyboardMouseCallback $= Just (keyboard pPos)
   
   -- все my__ берутся из Example.hs, я сделала случайным образом пару точек чтобы проверить что всё рисуется
   -- когда будет имплементирован код который рандомно генерирует точки, надо будет это заменить

   radius <- new _RADIUS
   cubeLength <- new _CUBELENGTH
   pointDist <- new _POINTDIST
   forceLineNum <- new _FORCELINENUM
   generateCubePoints <- new _GENERATECUBEPOINTS
   number <- new _NUMBER
   current <- new _CURRENT
   charge <- new _CHARGE
    
   newPoints <- new $ generatePointsInSphere _CUBELENGTH _GENERATECUBEPOINTS


   points <- new myPoints
   force <- new myForce 
   massParticle <- new myParticle
   particleSystem <- new myParticleSystem
    
   virtualParticle <- new myVirtualParticle
   vParticleSystem <- new myVirtualParticleSystem 

   magnetCircuits <- new [circuitFromFunction _NUMBER _CURRENT Magnetic.circle]
   
   staticElectricParticles <- new $ [ StaticElectricParticle (A.Point (-1) 0 0) 1, StaticElectricParticle (A.Point 1 0 0) (-1) ]

   step <- new _STEP
   field1 <- new simpleField
   field2 <- new otherField
   field3 <- new $ getMagneticFieldSystem [circuitFromFunction _NUMBER _CURRENT Magnetic.circle]
   field4 <- new $ getElectricFieldSystem [StaticElectricParticle (A.Point (-1) 0 0) 1, StaticElectricParticle (A.Point 1 0 0) (-1) ]

   --idleCallback $= Just (idleParticleSystem particleSystem step field2 field1 newPoints) --двигает много массивных частиц + запоминает предыдущие положения
   --idleCallback $= Just (idleVPS vParticleSystem step field3 newPoints) --двигает много виртуальных частиц
   --displayCallback $= displayMass pPos particleSystem -- рисует массовые частицы и их следа
   --displayCallback $= displayVirtual pPos vParticleSystem radius-- рисует виртуальные частицы
   --displayCallback $= displayField pPos field1 points -- рисует векторное поле
   --displayCallback $= displayForceLines pPos cubeLength pointDist forceLineNum generateCubePoints field1  -- рисует силовые линии
   --displayCallback $= displayMagnetic pPos magnetCircuits number current cubeLength generateCubePoints
   displayCallback $= displayElectric pPos staticElectricParticles cubeLength generateCubePoints
   reshapeCallback $= Just reshape
   mainLoop

displayField pPos field points= do
   f <- get field
   ps <- get points
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   displayVecField f ps --рисует векторное поле
   swapBuffers 


displayMass pPos particleSystem = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   ps <- get particleSystem
   mapM_ (massShiftCircle) (listOfParticles ps) --рисует массовые частицы 
   mapM_ particleTrail (listOfParticles ps) --рисует след
   swapBuffers

displayVirtual pPos vParticleSystem radius = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   vps <- get vParticleSystem
   r <- get radius
   mapM_ (virtualShiftCircle) (listOfVirtualParticles vps) -- рисует виртуальные частицы
   swapBuffers

displayForceLines pPos cubeLength pointDist forceLineNum generateCubePoints field1 = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   cl <- get cubeLength
   pd <- get pointDist
   fln <- get forceLineNum
   gcp <- get generateCubePoints
   f <- get field1
   renderForceLines cl pd fln gcp f --рисует силовые линии
   swapBuffers

displayMagnetic pPos magnetCircuits number current cubeLength generateCubePoints = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   mc <- get magnetCircuits
   n <- get number
   c <- get current
   cl <- get cubeLength
   gcp <- get generateCubePoints
   --displayVecField (getMagneticFieldSystem mc) (take 10000 $ generatePointsInSphere cl gcp)
   displayVecField (getMagneticFieldSystem mc) (take 8000 $ getPointsWithDistribution 8 $ Distr [((Distribution.Cube 8 (A.Point 0 0 0)), 10)])
   currentColor $= Color4 0 0 1 1
   mapM_ (renderAs LineLoop) (map pointToTriple $ map bigBoyList mc) 
   swapBuffers 





displayElectric pPos staticElectricParticles cubeLength generateCubePoints= do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   sep <- get staticElectricParticles
   cl <- get cubeLength
   gcp <- get generateCubePoints
   --displayVecField (getElectricFieldSystem sep) (take 10000 $ generatePointsInSphere cl gcp)
   displayVecField (getElectricFieldSystem sep) (take 8000 $ getPointsWithDistribution 8 $ Distr [((Distribution.Cube 8 (A.Point 0 0 0)), 10)])
   currentColor $= Color4 0 0 1 1
   renderAs LineLoop $ pointToTriple $ map Electric.position sep
   swapBuffers

particleTrail :: TMP.Particle -> IO()
particleTrail massParticle = do
   renderAs Lines $ pointToTriple $ track massParticle
 
pointToTriple points = map pT points

pT (A.Point x y z) = (x, y, z)

keyboard pPos c _ _ _ = keyForPos pPos c

massShiftCircle ::  Particle -> IO()
{-massShiftCircle r p = preservingMatrix $ 
                     do 
                        (translate $ Vector3 (px $ TMP.position p) (py $  TMP.position p) (pz $ TMP.position p))
                        renderSphere r 10 10 
-}
massShiftCircle (Particle (A.Point x y z) _ _ _ _ _ _) = do
    let point = [(x, y, z)]
    currentColor $= Color4 0 1 1 1
    renderAs Points point
virtualShiftCircle :: VirtualParticle -> IO()
{-virtualShiftCircle r p = preservingMatrix $
                     do
                        (translate $ Vector3 (px $ TVP.position p) (py $  TVP.position p) (pz $ TVP.position p))
                        renderOtherSphere r 10 10
-}
virtualShiftCircle (VirtualParticle (A.Point x y z) _) = do
   let point = [(x, y, z)]
   currentColor $= Color4 1 1 0 1
   renderAs Points point
renderForceLines :: Double -> Double -> Int -> Int -> (Point -> Vector) -> IO()
renderForceLines x a b i f = mapM_ (renderAs LineStrip) $ map pointToTriple $ bigList $ buildFromVecField x a b i f

idleParticleSystem particleSystem step field field' newPoints = do
  ps <- get particleSystem
  s <- get step
  f1 <- get field
  f2 <- get field'
  newpoints <- get newPoints
  let newps = addParticleToSystem (Particle (head newpoints) (tV (pT (head (tail newpoints)))) 300 100 5 [] 300) ps
  particleSystem $= TMP.evaluateSystemOfParticles s f1 f2 newps
  newPoints $= tail newpoints
  postRedisplay Nothing
tV (x, y, z) = (A.Vector x y z)
idleVPS vParticleSystem step field1 newPoints = do 
  vps <- get vParticleSystem
  s <- get step
  f1 <- get field1
  --cl <- get cubeLength
  --gcp <- get generateCubePoints
  newpoints <- get newPoints
  let newvps = TVP.addVirtualParticleToSVP (VirtualParticle (head newpoints) 20) vps 
  vParticleSystem $= TVP.evaluateSVP s f1 newvps
  newPoints $= tail newpoints
  postRedisplay Nothing
