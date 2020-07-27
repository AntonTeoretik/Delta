module Magnetic where

import Algebra	

data Circuit = Circuit Double [Point]
  deriving (Show, Eq, Generic, NFData)

magicConst :: Double
magicConst = (4 * pi * 10 ** (-7)) / (4 * pi)

getMagneticField :: Circuit -> Point -> Vector
getMagneticField (Circuit t r0 ) p = fold (<+>) zero list
  where
    list = zipWith (getElementaryInduction) r0 [circle] []
-- list :: [Vector] 
-- () :: ...-> Vector
-- [] :: ...-> Point
--


getMagneticFieldSystem :: [Circuit] -> Point -> Vector
getMagneticFieldSystem = undefined

circuitFromFunction :: Int -> Double -> (Double -> Point) -> Circuit
circuitFromFunction n z c = Circuit (z) map (c) [0,(2*pi / n)..(2*pi)]

circle :: Double -> Point
circle x = Point (sin x) (cos x) 0 

getElementaryInduction :: Point -> Point -> Point -> Vector
getElementaryInduction r0 r r1 = ((-->) r r1) <#> ((-->) r r0)



