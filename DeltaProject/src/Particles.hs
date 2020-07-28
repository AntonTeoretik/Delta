{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Particles where
import Algebra    
    
data Particle = Particle {Point Vector lifetime :: Integer, mass :: Double, electricCharge :: Double}

data SystemOfParticles = SystemOfParticles { listOfParticles :: [Particle], radiusOfRegion :: Double}

evaluateParticle :: Double -> Vector -> Particle -> Particle
evaluateParticle k (Vector x y z) (Particle (Point x1 y1 z1) (Vector x2 y2 z2) lifetime t, mass m, electricCharge q) = Particle (Point x1 y1 z1 .-> Vector x y z)  (Vector ((k *. (Vector x y z /. mass m)) <+> (Vector x2 y2 z2)))  lifetime (t - 1) mass m electricCharge q  

evaluateSystemOfParticles :: Double -> (Point -> Vector) -> (Point -> Vector) -> SystemParticles -> SystemParticles
evaluateSystemOfParticles k getMagneticForce (Vector (f x y z)) (Particle (Point x1 y1 z1) (Vector x2 y2 z2) lifetime t mass m electricCharge q) getElectricForce (Vector (f x' y' z')) (Particle (Point x1' y1' z1') (Vector x2' y2' z2') lifetime t' mass
 m' electricCharge q') (SystemOfParticles listOfParticles a radiusOfRegion b) = |
                                                                                | 

addParticleToSystem :: Particle -> SystemOfParticles -> SystemOfParticles
addParticleToSystem (Particle (Point x1 y1 z1) (Vector x2 y2 z2) lifetime t mass m electricCharge q)  (SystemOfParticles listOfParticles a radiusOfRegion b) = SystemOfParticles ((Particle (Point x1 y1 z1) (Vector x2 y2 z2) lifetime t mass m electricCharge q) : a  (b) )  

getMagneticForce :: (Point -> Vector) -> Particle -> Vector 
getMagneticForce (Vector (f x y z)) (Particle (Point x1 y1 z1) (Vector x2 y2 z2) lifetime t mass m electricCharge q) = Vector $ q *. $ (Vector x2 y2 z2) <*> (Vector $ f x y z)

getElectricForce :: (Point -> Vector) -> Particle -> Vector
getElectricForce (Vector (f x y z)) (Particle (Point x1 y1 z1) (Vector x2 y2 z2) lifetime t mass m electricCharge q) = Vector $ q *. (Vector (f x y z)) 