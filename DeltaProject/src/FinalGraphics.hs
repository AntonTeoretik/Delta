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
import OrbitAroundVectors
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
{-
showAnyField (SceneParameters randomGenValue domainRadius) (ShowVectors numVectors lengthVectors) field = do
   (progName,_) <- getArgsAndInitialize
   initialDisplayMode $= [WithDepthBuffer, DoubleBuffered]
   createWindow progName
   depthFunc $= Just Less

   pPos <- new (90 :: Int, 270 :: Int, 2.0)
   keyboardMouseCallback $= Just (keyboard pPos)
{-
   cubeLength <- new _CUBELENGTH
   generateCubePoints <- new _GENERATECUBEPOINTS
   number <- new _NUMBER
   current <- new _CURRENT
   charge <- new _CHARGE

   points <- new myPoints
   force <- new myForce
   magnetCircuits <- new [circuitFromFunction _NUMBER _CURRENT Magnetic.circle]
   
   staticElectricParticles <- new [ (StaticElectricParticle (A.Point (-1) 0 0) 1), (StaticElectricParticle (A.Point (1) 0 0) (-1)) ]
-}
   displayCallback $= displayField pPos field (take numVectors (generatePointsInSphere randomGenValue domainRadius))
   reshapeCallback $= Just reshape
   mainLoop


    


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
-}-}
