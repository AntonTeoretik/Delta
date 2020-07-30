module Random where
import System.Random
import Algebra


generatePointsInCube :: Int -> Double -> [Point]
generatePointsInCube x r = pointsFromDoubles (randomRs (-(r/2), r/2) (mkStdGen x)) 






pointsFromDoubles :: [Double] -> [Point]
pointsFromDoubles (x : y : z : restz) = (Point  x y z) : (pointsFromDoubles restz)

--randomRs mkStdGen x (1, 10)

randomNumber :: Int -> [Double]
randomNumber x = randomRs (1, 10) (mkStdGen x)

--randomRs :: RandomGen g => (Int, Int) -> g -> [Int]

--mkStdGen :: Int -> StdGen
