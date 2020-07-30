module Electric where

import Algebra

data StaticElectricParticle = StaticElectricParticle {position :: Point, charge :: Double}
  deriving (Eq, Show)

getElectricField :: StaticElectricParticle -> Point -> Vector -- 
getElectricField particle p = (*.)((9*10^9)*(charge particle)/(veclength ((-->) (position particle) p))^3)((-->) (position particle) p) --

getElectricFieldSystem :: [StaticElectricParticle] -> Point -> Vector 
getElectricFieldSystem particles p= undefined

getSystemFromFuction :: (Double, Double) -> (Point, Double) -> [StaticElectricParticle] --
getSystemFromFuction = undefined