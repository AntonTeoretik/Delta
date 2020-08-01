module Distribution where
import System.Random
import Algebra

-- data Point = Point { px :: Double, py :: Double, pz :: Double }
--     deriving (Eq, Show)

data Cube = Cube {
    length:: Double, 
    center:: Point
    }
    deriving (Show)

data Distr = Distr [(Cube, Double)]
    deriving (Show)

standardCube :: Cube --с стандартный куб  центром в начале координат и стороной 2.
standardCube = Cube 2 (Point 0 0 0)

buildDistribution :: Double  -> Cube -> (Point -> Double) -> Distr
buildDistribution root (Cube length center ) f = let increment = length/(root*2.0) in
                                                 Distr [(Cube (increment*2) p , f p )| p <- listOfPoints root (Cube length center)]


getCube :: Distr -> Double -> (Cube , Double)
getCube (Distr d)  r =  d !! getNum (r*size) vectorSizes where 
                size = sum vectorSizes
                vectorSizes= [snd x | x <- d ]
                -- random = round (randomIO :: IO Double)*size

getNum :: Double -> [Double] -> Int
getNum r (x:[]) = 0
getNum r (x:xs) | r < x = 0
                | otherwise = 1+(getNum (r-x) xs)


listOfPoints :: Double -> Cube -> [Point]
listOfPoints root (Cube l (Point x y z)) = [ Point (x1+x) (y1+y) (z1+z) | x1 <- possiblePoints, y1 <- possiblePoints, z1 <- possiblePoints ]
                            where increment = l/(root*2)
                                  possiblePoints = {-map (+3)-}[( -1 ) * ( l / 2 - increment ), (-1)*(l/2 - 3*increment) .. (l/2 - increment)]

getPointsWithDistribution :: Int -> Distr -> [Point]
getPointsWithDistribution s d = map ( \(x,y,z,t) -> let (Cube l c, _) = getCube d t in c .-> Vector ( l*(x - 0.5) ) ( l*(y - 0.5) ) (l*(z - 0.5))  ) (groupByFours $ randomRs (0.0,1.0) $ mkStdGen s )


groupByFours :: [a] -> [(a,a,a,a)]
groupByFours (x : y : z : t : xs) = (x, y, z, t) : groupByFours xs
groupByFours _ = []

