module Random where
import System.Random
import Algebra
import Data.List

generatePointsInCube :: Int -> Double -> [Point]
generatePointsInCube x r = pointsFromDoubles (randomRs (-(r/2), r/2) (mkStdGen x)) 






pointsFromDoubles :: [Double] -> [Point]
pointsFromDoubles (x : y : z : restz) = (Point  x y z) : (pointsFromDoubles restz)

--randomRs mkStdGen x (1, 10)

randomNumber :: Int -> [Double]
randomNumber x = randomRs (1, 10) (mkStdGen x)

--randomRs :: RandomGen g => (Int, Int) -> g -> [Int]

--mkStdGen :: Int -> StdGen

extractPointfromCubeInSphere :: Double -> Point -> Bool
extractPointfromCubeInSphere r (Point x y z) = if (sqrt(x-0)^2 + (y-0)^2 + (z-0)^2) <= r then True else False

-- r = sqrt(x-0)^2 + (y-0)^2 + (z-0)^2







generatePointsInSphere :: Int -> Double -> [Point]
generatePointsInSphere x r = filter (extractPointfromCubeInSphere r) (generatePointsInCube x r) 


--generatePointsOnSphere :: Int -> Double -> [Point]
--generatePointsOnSphere = undefined 
