module Electric where
data StaticElectricParticle = StaticElectricParticle {position :: Point, charge :: Double}
  deriving (Eq, Generic, NFData, Show)

getElectricField :: StaticElectricParticle -> Point -> Vector -- 
getElectricField particle p = particle * ((veclenght(p (-->) (1, 1, 1)))^3)/((9*(10^9))*p*1) --

getElectricFieldSystem :: [StaticElectricParticle] -> Point -> Vector -- 


getSystemFromFuction :: (Double, Double) -> (Point, Double) -> [StaticElectricParticle] --