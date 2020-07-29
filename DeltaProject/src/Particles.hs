{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Particles where
import Algebra
import Data.List    
    
data Particle = Particle {position Point, velocity Vector, lifetime :: Integer, mass :: Double, electricCharge :: Double}

data SystemOfParticles = SystemOfParticles { listOfParticles :: [Particle], radiusOfRegion :: Double}

evaluateParticle :: Double -> Vector -> Particle -> Particle
evaluateParticle k f (Particle x1 v t m q) = Particle ((x1 .-> f) ((k *. (f /. m)) <+> v) (t - 1) m q) 

evaluateSystemOfParticles :: Double -> (Point -> Vector) -> (Point -> Vector) -> SystemParticles -> SystemParticles
evaluateSystemOfParticles k f f' (SystemOfParticles a r) = map (if Particle {lifetime <= 0} then filter Particle {lifetime <= 0} (a) else evaluateParticle k (f <+> f') ) (a) 
                                                                  

addParticleToSystem :: Particle -> SystemOfParticles -> SystemOfParticles
addParticleToSystem particle (SystemOfParticles a r) = SystemOfParticles (particle : a) r  

getMagneticForce :: (Point -> Vector) -> Particle -> Vector 
getMagneticForce f (Particle x1 x2 _ _ q) = q *. x2 <#> f x1

getElectricForce :: (Point -> Vector) -> Particle -> Vector
getElectricForce f (Particle x1 _ _ _ q) = q *. f x1 