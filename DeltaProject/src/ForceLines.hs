module ForceLines where

import Algebra

data ForceLines = ForceLines [[Point]]
     deriving (Show, Eq)

buildForceLineFromPoint :: Double -> (Point -> Vector) -> Point -> [Point]
buildForceLineFromPoint a f x = x : buildForceLineFromPoint a f (nextPoint a f x) 

nextPoint :: Double -> (Point -> Vector) -> Point -> Point
nextPoint a f x = x .-> (a *. (normalize (f x))) 

buildFroVecField :: Double -> (Point -> Vector) -> ForceLines
buildFroVecField = undefined























