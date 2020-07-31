module ForceLines where
import Algebra
import Random
data ForceLines = ForceLines [[Point]]
     deriving (Show, Eq)
buildForceLineFromPoint :: Double -> Int -> (Point -> Vector) -> Point -> [Point]
buildForceLineFromPoint a b f x = back : front
                        where back  = init $ reverse $ take b (x : buildForceLineFromPoint a f (nextPointBack a f x))
                              front = take b (x : buildForceLineFromPoint a f (nextPoint a f x))
-- a - расстояние между т. на сил. лин.
-- 2*b - кол-во т. на сил. лин
-- x - первая т.

nextPoint :: Double -> (Point -> Vector) -> Point -> Point
nextPoint a f x = x .-> (a *. (normalize (f x)))

nextPointBack :: Double -> (Point -> Vector) -> Point -> Point -- в обратную сторону
nextPointBack a f x = x .-> (((-1) * a) *. (normalize (f x)))

buildFromVecField :: Double -> Double -> Int -> Int -> (Point -> Vector) -> ForceLines
buildFromVecField x a b i f = ForceLines $ map (buildForceLineFromPoint a f) (take b $ generatePointsInCube i x)
-- x - сторона куба
-- а - расстояние между т. на сил. лин.
-- b - кол-во сил. лин.
-- i - управляет generatePointsInCube























