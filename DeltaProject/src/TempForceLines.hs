module TempForceLines where

import Algebra
import TempRandom 

data ForceLines = ForceLines {bigList :: [[Point]]}
     deriving (Show, Eq)

buildForceLineFromPoint :: Double -> (Point -> Vector) -> Point -> [Point]
buildForceLineFromPoint a f x = x : buildForceLineFromPoint a f (nextPoint a f x) 

nextPoint :: Double -> (Point -> Vector) -> Point -> Point
nextPoint a f x = x .-> (a *. (normalize (f x))) 

buildFromVecField :: Double -> Double -> Int -> Int -> (Point -> Vector) -> ForceLines
buildFromVecField x a b i f = ForceLines $ map (take 1000) $ map (buildForceLineFromPoint a f) (take b $ generatePointsInCube i x)   
-- x - сторона куба 
-- а - расстояние между т. на сил. лин.
-- b - кол-во сил. лин.
-- i - управляет generatePointsInCube
