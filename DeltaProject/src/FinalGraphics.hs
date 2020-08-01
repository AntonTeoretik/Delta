{-# LANGUAGE FlexibleContexts #-}

module FinalGraphics where
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT as GLUT
import Data.IORef

import Particles as TMP
import TempMasslessParticles as TVP
import ForceLines 
import Magnetic
import Random

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
{-
_STEP = 0.01 --промежуток времени который проходит между шагами idle

--тут определить всякие физические переменные:
_RADIUS = 0.05 -- радиус сферы которая рисует частицы
_CUBELENGTH = 5 -- длина стороны куба который для generatePointsFromCube
_POINTDIST = 0.01 -- растояние между точками на силовой линии
_FORCELINENUM = 100 -- количество силовых линий
_GENERATECUBEPOINTS = 5 --что-то про generatePointsFromCube, не знаю что делает
_CURRENT = 3 --ток в магнитном поле
_NUMBER = 100 --число которое берёт circuitFromFunction - не знаю, что делает
_CHARGE = 1 --заряд массивной частицы
-}

data Mode = ShowVectors Int Double -- число векторов и их длина
          | ShowForceLines Int Int -- их число и длина каждой
          | ShowMasslessParticles Int  -- изначальное число частиц
          | ShowVectorsWithDistribution Int Double -- то, что делает Илья

data SceneParameters = SceneParameters {randomGenValue :: Int, domainRadius :: Double }

showAnyField :: SceneParameters ->
                Mode ->
                (Point -> Double) -> -- поле
                IO ()

showPhysicalSystem :: SceneParameters ->
                      [StaticElectricParticle] -> -- тут мб другое название, не помню
                      [Circuit] -> 
                      IO () -- рисует всю систему и запускает движение массивных частиц
showAnyField = undefined
showPhysicalSystem = undefined
{-main''' = do
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

   points <- new myPoints
   force <- new myForce 
   massParticle <- new myParticle
   particleSystem <- new myParticleSystem
   
   virtualParticle <- new myVirtualParticle
   vParticleSystem <- new myVirtualParticleSystem 

   magnetCircuits <- new [circuitFromFunction _NUMBER _CURRENT Magnetic.circle]
   
   --staticElectricParticles <- new $ take 1000 $ getSystemFromFuction _CHARGE (\(a, b) -> (A.Point a 1 1, b))

   staticElectricParticles <- new [ (StaticElectricParticle (A.Point (-1) 0 0) 1), (StaticElectricParticle (A.Point (1) 0 0) (-1)) ]

   step <- new _STEP
   field1 <- new simpleField
   field2 <- new otherField
   field3 <- new $ getMagneticFieldSystem [circuitFromFunction _NUMBER _CURRENT Magnetic.circle]
   --idleCallback $= Just (idleParticleSystem particleSystem step field1 field2) --двигает много массивных частиц + запоминает предыдущие положения
   idleCallback $= Just (idleVPS vParticleSystem step field3 cubeLength generateCubePoints) --двигает много виртуальных частиц
   --displayCallback $= displayMass pPos particleSystem radius field3-- рисует массовые частицы и их следа
   displayCallback $= displayVirtual pPos vParticleSystem radius field3-- рисует виртуальные частицы
   --displayCallback $= displayField pPos field1 points -- рисует векторное поле
   --displayCallback $= displayForceLines pPos cubeLength pointDist forceLineNum generateCubePoints field1  -- рисует силовые линии
   --displayCallback $= displayMagnetic pPos magnetCircuits number current cubeLength generateCubePoints
   --displayCallback $= displayElectric pPos staticElectricParticles cubeLength generateCubePoints
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


displayMass pPos particleSystem radius field = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   ps <- get particleSystem
   f <- get field
   r <- get radius
   mapM_ (massShiftCircle r f) (listOfParticles ps) --рисует массовые частицы 
   mapM_ (particleTrail f) (listOfParticles ps) --рисует след
   swapBuffers

displayVirtual pPos vParticleSystem radius field = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   vps <- get vParticleSystem
   r <- get radius
   f <- get field
   mapM_ (virtualShiftCircle r f) (listOfVirtualParticles vps) -- рисует виртуальные частицы
   swapBuffers

displayForceLines pPos cubeLength pointDist forceLineNum generateCubePoints field = do
   loadIdentity
   setPointOfView pPos
   clear [ColorBuffer, DepthBuffer]
   cl <- get cubeLength
   pd <- get pointDist
   fln <- get forceLineNum
   gcp <- get generateCubePoints
   f <- get field
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
   displayVecField (getMagneticFieldSystem mc) (take 10000 $ generatePointsInSphere cl gcp)
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
   displayVecField (getElectricFieldSystem sep) (take 5000 $ generatePointsInSphere cl gcp)
   swapBuffers

idleParticleSystem particleSystem step field1 field2 = do
  ps <- get particleSystem
  s <- get step
  f1 <- get field1
  f2 <- get field2
  particleSystem $= TMP.evaluateSystemOfParticles s f1 f2 ps
  postRedisplay Nothing

idleVPS vParticleSystem step field cubeLength generateCubePoints = do
  vps <- get vParticleSystem
  s <- get step
  f1 <- get field
  cl <- get cubeLength
  gcp <- get generateCubePoints
  let newvps =  addVirtualParticleToSVP (VirtualParticle (head $ generatePointsInSphere cl gcp) 20) vps
  vParticleSystem $= TVP.evaluateSVP s f1 newvps
  --vParticleSystem $= TVP.evaluateSVP s f1 vps
  postRedisplay Nothing


particleTrail :: (A.Point -> A.Vector) -> TMP.Particle  -> IO()
particleTrail field massParticle = do
   renderAs Lines $ vectorToTriple $ map field $ track massParticle
 
vectorToTriple vectors = map vT vectors
pointToTriple points = map pT points

vT (A.Vector x y z) = (x, y, z)
pT (A.Point x y z) = (x, y, z)

keyboard pPos c _ _ _ = keyForPos pPos c

massShiftCircle :: Double -> (A.Point -> A.Vector) -> Particle -> IO()
massShiftCircle r f p = preservingMatrix $ 
                     do 
                        let x = f $ A.Point (px $ TMP.position p) (py $ TMP.position p) (pz $ TMP.position p)
                        (translate $ Vector3 (vx x) (vy x) (vz x))
                        renderSphere r 10 10 

virtualShiftCircle :: Double -> (A.Point -> A.Vector) -> VirtualParticle -> IO()
virtualShiftCircle r f p = preservingMatrix $
                     do
                       let x = f $ A.Point (px $ TVP.position p) (py $ TVP.position p) (pz $ TVP.position p)
                       (translate $ Vector3  (vx x) (vy x) (vz x))
                       renderOtherSphere r 10 10

renderForceLines :: Double -> Double -> Int -> Int -> (Point -> Vector) -> IO()
renderForceLines x a b i f = mapM_ (renderAs LineStrip) $ map pointToTriple $ bigList $ buildFromVecField x a b i f

-}
