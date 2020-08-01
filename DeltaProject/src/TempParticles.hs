{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module TempParticles where
import Algebra
import Data.List    
    
data Particle = Particle {position :: Point, velocity :: Vector, lifetime :: Integer, mass :: Double, electricCharge :: Double, track :: [Point], maxlenght ::  Int}

data SystemOfParticles = SystemOfParticles { listOfParticles :: [Particle], radiusOfRegion :: Double}

evaluateParticle :: Double -> Vector -> Particle -> Particle
evaluateParticle k f (Particle x1 v t m q tr len) = Particle (x1 .-> k *. v ) ((k *. (f /. m)) <+> v) (t - 1) m q (take len (x1 : tr)) len

moveByField :: Double -> (Point -> Vector) -> (Point -> Vector) -> Particle -> Particle
moveByField k f f' p = evaluateParticle k force p 
                                        where 
                                          force = (getElectricForce f p) <+> (getMagneticForce f' p)  

evaluateSystemOfParticles :: Double -> (Point -> Vector) -> (Point -> Vector) -> SystemOfParticles -> SystemOfParticles

evaluateSystemOfParticles k f f' (SystemOfParticles a r) =
  SystemOfParticles (filter (\(Particle {position = (Point x y z)}) ->  x^2 + y^2 + z^2 <= r^2) $ filter (\(Particle {lifetime = l} ) -> l > 0) (map (moveByField k f f') a)) r


addParticleToSystem :: Particle -> SystemOfParticles -> SystemOfParticles
addParticleToSystem particle (SystemOfParticles a r) = SystemOfParticles (particle : a) r  


getMagneticForce :: (Point -> Vector) -> Particle -> Vector 
getMagneticForce f (Particle {position = x1, velocity = x2, electricCharge = q}) = q *. x2 <#> f x1


getElectricForce :: (Point -> Vector) -> Particle -> Vector
getElectricForce f (Particle {position = x1, electricCharge = q}) = q *. f x1
