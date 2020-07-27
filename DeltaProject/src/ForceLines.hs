module ForceLines where

import Algebra

data ForceLines = ForceLines [[Point]]
derivng (Show, Eq)

buildForceLineFromPoint :: Double -> (Point -> Vector) -> Point -> [Point]
buildForceLineFromPoint a f x = x : zipWith f' buildForceLineFromPoint (tail buildForceLineFromPoint)
                               where f':: Point -> Point
							         f' = if a < veclength $ f x then .-> $ a *. $ normalize $ f x else  .-> $ f x 

buildFroVecField :: Double -> (Point -> Vector) -> ForceLines
buildFroVecField = underfined























