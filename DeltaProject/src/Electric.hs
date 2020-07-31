module Electric where

import Algebra

data StaticElectricParticle = StaticElectricParticle {position :: Point, charge :: Double}
  deriving (Eq, Show)

getCoordsArray ::  Int -> [(Double, Double)]
getCoordsArray n = [ (x, y) | x <- lst,  y <- lst ]
  where
    lst = [0, 1/(realToFrac n)..1] 

getElectricField :: StaticElectricParticle -> Point -> Vector -- 
getElectricField particle p = (*.)((9*10^9)*(charge particle)/(veclength ((-->) (position particle) p))^3)((-->) (position particle) p) --

getElectricFieldSystem :: [StaticElectricParticle] -> Point -> Vector 
getElectricFieldSystem particles p= foldl (<+>) zero (map (\t -> getElectricField t p) particles)

getSystemFromFuction :: Int -> ((Double, Double) -> (Point, Double)) -> [StaticElectricParticle] --
getSystemFromFuction n f = map  ( ( \(p, c) -> StaticElectricParticle p c ) . f )    (getCoordsArray n)