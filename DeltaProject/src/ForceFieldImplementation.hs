module Electric where
data StaticElectricParticle =  (PP :: Point, PV :: Vector) 
  deriving (Eq, Show)

getElectricField :: StaticElectricParticle -> Point -> Vector -- (точка, вектор) и точка дает (?) вектор
getElectricFieldSystem :: [StaticElectricParticle] -> Point -> Vector -- [(точка, вектор)] и точка дает (?) вектор

getSystemFromFuction :: (Double, Double) -> (Point, Double) -> [StaticElectricParticle] --(?)(число, число)->(точка, число)->[(точка, вектор)]