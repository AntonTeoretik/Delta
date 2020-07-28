module Electric where
data StaticElectricParticle = StaticElectricParticle {position :: Point, charge :: Double}
  deriving (Eq, Generic, NFData, Show)

getElectricField :: StaticElectricParticle -> Point -> Vector -- 


getElectricFieldSystem :: [StaticElectricParticle] -> Point -> Vector -- 


getSystemFromFuction :: (Double, Double) -> (Point, Double) -> [StaticElectricParticle] --