module ForceLines where

import Algebra

data ForceLines = ForceLines [[Point]]
     derivng (Show, Eq)

buildForceLineFromPoint :: Double -> (Point -> Vector) -> Point -> [Point]
buildForceLineFromPoint a f x = x : zipWith (if a < veclength $ f x then .-> $ a *. $ normalize $ f x else  .-> $ f x) buildForceLineFromPoint (tail buildForceLineFromPoint)
                              

buildFroVecField :: Double -> (Point -> Vector) -> ForceLines
buildFroVecField = underfined























