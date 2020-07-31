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

--buildDistibution :: Double  -> Cube -> Double -> (Point -> Double) -> Distr
buildDistibution root (Cube length center ) f = let increment = length/(root*2.0) in 
                                                 Distr [(Cube (increment*2) p , f p )| p <- listOfPoints root (Cube length center)]

GetCube d =  d !! number where 
                size = sum [snd x|x<-d]
                number = round (randomIO :: IO Double)*size

listOfPoints root (Cube l (Point x y z)) = [ Point x+x1 y+y1 z+z1 | x1 <- possiblePoints, y1 <- possiblePoints, z1 <- possiblePoints ]
                            where increment = l/(root*2)
                                  possiblePoints = map (+3) [( -1 ) * ( l / 2 - increment ), (-1)*(l/2 - 3*increment) .. (l/2 - increment)] 
    
getPointsWithDistribution :: Int -> Distibution ->  [Point]
getPointsWithDistribution d = cycle [GetCube d.center] 