module Magnetic where

import Algebra	

data Circuit = Circuit Double [Point]
  deriving (Show, Eq)

magicConst :: Double
magicConst = (4 * pi * 10 ** (-7)) / (4 * pi)

getMagneticField :: Circuit -> Point -> Vector
getMagneticField (Circuit t r2 ) p = (*.) t (foldl (<+>) zero list)
  where
    list = zipWith (getElementaryInduction p) r2 ((tail r2) ++ [head r2])
-- list :: [Vector] 
-- () :: ...-> Vector
-- [] :: ...-> Point
--


getMagneticFieldSystem :: [Circuit] -> Point -> Vector
getMagneticFieldSystem list p = foldl (<+>) zero (map (\t -> getMagneticField t p) list)
-- not used: getMagneticField; circle; circleFromFunction; 



circuitFromFunction :: Int -> Double -> (Double -> Point) -> Circuit
circuitFromFunction n z c = Circuit (z) (map (c) [0,(2*pi / realToFrac(n))..(2*pi)])
-- double -> int


circle :: Double -> Point
circle x = Point (sin x) (cos x) 0 

getElementaryInduction :: Point -> Point -> Point -> Vector
getElementaryInduction r0 r r1 = ((-->) r r1) <#> ((-->) r r0)



