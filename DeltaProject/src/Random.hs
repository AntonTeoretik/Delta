module Random where 
import System.Random	
import Algebra


generatePointsInCube :: Int -> Double -> [Point]
generatePointsInCube = randomRs mkStdGen x (1, 10)

--randomRs mkStdGen x (1, 10)



--randomRs :: RandomGen g => (Int, Int) -> g -> [Int]

--mkStdGen :: Int -> StdGen




generatePointsInSphere :: Int -> Double -> [Point]
generatePointsInSphere = undefined

generatePointsOnSphere :: Int -> Double -> [Point]
generatePointsOnSphere = undefined