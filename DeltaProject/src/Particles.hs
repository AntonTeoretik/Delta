{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Particles where
import Algebra    
    
data Particle = Particle {Point Vector lifetime :: Integer, mass :: Double, electricCharge :: Double}

data SystemOfParticles = SystemOfParticles { listOfParticles :: [Particle], radiusOfRegion :: Double}

evaluateParticle :: Double -> Vector -> Particle -> Particle
evaluateParticle k x (Particle {x1 x2 lifetime t, mass m, electricCharge q}) = Particle (x1 .-> x)  (Vector ((k *. (x /. m)) <+> x2))  lifetime (t - 1) mass m electricCharge q  

evaluateSystemOfParticles :: Double -> (Point -> Vector) -> (Point -> Vector) -> SystemParticles -> SystemParticles
evaluateSystemOfParticles k getMagneticForce (Vector (f)) (Particle {x1 x2 lifetime t, mass m, electricCharge q}) (getElectricForce (Vector (f')) (Particle {x1' x2' lifetime t', mass m', electricCharge q'})
(SystemOfParticles {listOfParticles (a : as), radiusOfRegion b}) = | a
                                                                   | 

addParticleToSystem :: Particle -> SystemOfParticles -> SystemOfParticles
addParticleToSystem (Particle {x1 x2 lifetime t, mass m, electricCharge q})  (SystemOfParticles {listOfParticles a, radiusOfRegion b}) = SystemOfParticles ((Particle {x1 x2 lifetime t, mass m, electricCharge q}) : a  (b) )  

getMagneticForce :: (Point -> Vector) -> Particle -> Vector 
getMagneticForce (Vector (f)) (Particle {x1 x2 lifetime t, mass m, electricCharge q}) = Vector $ q *. $ x2 <*> (Vector $ f)

getElectricForce :: (Point -> Vector) -> Particle -> Vector
getElectricForce (Vector (f)) (Particle {x1 x2 lifetime t, mass m, electricCharge q}) = Vector $ q *. (Vector (f)) 