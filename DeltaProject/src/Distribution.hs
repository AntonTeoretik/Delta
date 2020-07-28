module Distribution where
    --import Algebra.hs

data Point = Point { px :: Double, py :: Double, pz :: Double }
  deriving (Eq, Generic, NFData, Show)


getPointsWithDistribution :: Int -> Distibution ->  [Point]standardCube = Cube 2 Point(0,0,0)

