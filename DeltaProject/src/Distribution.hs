module Distribution where
import System.Random

data Point = Point { px :: Double, py :: Double, pz :: Double }
    deriving (Eq, Show)

data Cube = Cube {
    length::Double, 
    center:: Point
    }
    deriving (Show)

data Distr = Distr [(Cube, Double)]
    deriving (Show)

standardCube :: Cube --с стандартный куб  центром в начале координат и стороной 2.
standardCube = Cube 2 (Point 0 0 0)

buildDistibution :: Double  -> Cube -> (Point -> Double) -> Distr
buildDistibution root (Cube length center ) f = let increment = length/(root*2.0) in
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
getPointsWithDistribution s d = map ( center . fst . getCube d ) ( randomRs (0 , 1) $ mkStdGen s )