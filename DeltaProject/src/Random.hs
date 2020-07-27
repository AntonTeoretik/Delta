module Random where 
import System.Random	
import Algebra


generatePointsInCube :: Int -> Double -> [Point]
generatePointsInCube = undefined

--randomRs mkStdGen x (1, 10)

randomNumber :: Int -> [Double]
randomNumber x = randomRs (1, 10) (mkStdGen x)

--randomRs :: RandomGen g => (Int, Int) -> g -> [Int]

--mkStdGen :: Int -> StdGen




generatePointsInSphere :: Int -> Double -> [Point]
generatePointsInSphere = undefined

generatePointsOnSphere :: Int -> Double -> [Point]
generatePointsOnSphere = undefined 