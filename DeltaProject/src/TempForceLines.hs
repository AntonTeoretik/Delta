module TempForceLines where

import Algebra
import TempRandom 

import Constants



data ForceLines = ForceLines {bigList :: [[Point]]}
     deriving (Show, Eq)



buildForceLineFromPoint :: Double -> (Point -> Vector) -> Point -> [Point]
buildForceLineFromPoint a f x = x : buildForceLineFromPoint a f (nextPoint a f x) 


concatInfinityArraysAndTake :: Int -> ([Point], [Point]) -> [Point]
concatInfinityArraysAndTake n (xs, yx) = (reverse . take n) yx ++ take n xs 


nextPoint :: Double -> (Point -> Vector) -> Point -> Point
nextPoint a f x = x .-> (a *. (normalize (f x))) 



buildFromVecField :: Double -> Double -> Int -> Int -> (Point -> Vector) -> ForceLines
buildFromVecField x a b i f = ForceLines $ map (concatInfinityArraysAndTake _FORCE_LINE_LENGTH . makeTwoSequences) (take b $ generatePointsInCube i x) 
  where
    makeTwoSequences p = (buildForceLineFromPoint a f' p, buildForceLineFromPoint a f p)
    f' x = (-1) *. f x

-- x - сторона куба 
-- а - расстояние между т. на сил. лин.
-- b - кол-во сил. лин.
-- i - управляет generatePointsInCube
