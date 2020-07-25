module Electric where
data StaticElectricParticle = 

getElectricField :: StaticElectricParticle -> Point -> Vector
getElectricFieldSystem :: [StaticElectricParticle] -> Point -> Vector

getSystemFromFuction :: (Double, Double) -> (Point, Double) -> [StaticElectricParticle]