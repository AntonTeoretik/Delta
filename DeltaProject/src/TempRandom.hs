module TempRandom where
import System.Random
import Algebra
import Data.List

generatePointsInCube :: Int -> Double -> [Point]
generatePointsInCube x r = pointsFromDoubles (randomRs (-(r/2), r/2) (mkStdGen x)) 

pointsFromDoubles :: [Double] -> [Point]
pointsFromDoubles (x : y : z : restz) = (Point  x y z) : (pointsFromDoubles restz)

randomNumber :: Int -> [Double]
randomNumber x = randomRs (1, 10) (mkStdGen x)

extractPointfromCubeInSphere :: Double -> Point -> Bool
extractPointfromCubeInSphere r (Point x y z) = x^2 + y^2 + z^2 <= r^2

generatePointsInSphere :: Int -> Double -> [Point]
generatePointsInSphere x r = filter (extractPointfromCubeInSphere r) (generatePointsInCube x $ 2 * r) 
