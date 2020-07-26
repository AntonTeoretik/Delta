module ForceLines where

data ForceLines = ForceLines [[Point]]
derivng (Show, Eq)

buildForceLineFromPoint :: Double -> (Point -> Vector) -> Point -> [Point]
buildForceLineFromPoint a (Vector x y z) (Point k l m) = (Point k l m) : map (.->) buildForceLineFromPoint (Vector x1 y1 z1) 
                               where (Vector x1 y1 z1) = a *. (normalize Vector x y z) 

buildFroVecField :: Double -> (Point -> Vector) -> ForceLines
buildFroVecField = underfined




















