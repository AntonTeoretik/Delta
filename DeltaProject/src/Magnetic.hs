module Magnetic where

import Algebra	

data Circuit = Circuit Double Point
  deriving (Show, Eq, Generic, NFData)

magicConst :: Double
magicConst = (4 * pi * 10 ** (-7)) / (4 * pi)

--getMagneticField :: Circuit -> Point -> Vector
--getMagneticField ( Circuit (a) (Point (x) (y) (z)) ) = (magicConst / 4) + ((a * () ()))
-- hhhhhhh

getMagneticFieldSystem :: [Circuit] -> Point -> Vector
getMagneticFieldSystem = undefined

circuitFromFunction :: Int -> (Double -> Point) -> Circuit
circuitFromFunction n c = Circuit (n) (c n)

circle :: Double -> Point
circle x = Point (sin x) (cos x) 0

getElementaryInduction :: Point -> Point -> Point -> Vector
getElementaryInduction (Point x y z) (Point x1 y1 z1) (Point x2 y2 z2) = ((-->) (Point x y z) (Point x2 y2 z2)) <#> (-->) ((Point x y z) (Point x1 y1 z1))



