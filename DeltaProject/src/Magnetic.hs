module Magnetic where

import Algebra	

data Circuit = Circuit Double Point
  deriving (Show, Eq, Generic, NFData)

magicConst :: Double
magicConst = (4 * pi * 10 ** (-7)) / (4 * pi)

--getMagneticField :: Circuit -> Point -> Vector
--getMagneticField ( Circuit (a) (Point (x) (y) (z)) ) = (magicConst / 4) + ((a * () ()))

getMagneticFieldSystem :: [Circuit] -> Point -> Vector
getMagneticFieldSystem = undefined

circuitFromFunction :: Int -> Double -> (Double -> Point) -> Circuit
circuitFromFunction n z c = Circuit (n) (c n)

circle :: Double -> [Point]
circle x = Point (sin x) (cos x) 0 : []

getElementaryInduction :: Point -> Point -> Point -> Vector
getElementaryInduction r0 r 1 = ((-->) r r1) <#> ((-->) r r0)



