data Cube
data Distibution

standardCube :: Cube -- стандартный куб с центром в начале координат и стороной 2.

buildDistibution :: Int  -> Cube -> Double -> (Point -> Double) -> Distribution

getPointsWithDistribution :: Int -> Distibution ->  [Point]