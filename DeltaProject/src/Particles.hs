{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Particles where
import Algebra    
    
data Particle = Particle Point Double Integer Double Double

data SystemOfParticles = SystemOfParticles [] Double

evaluateParticle :: Double -> Vector -> Particle -> Particle

evaluateSystemOfParticles :: Double -> (Point -> Vector) -> (Point -> Vector) -> SystemParticles -> SystemParticles

addParticleToSystem :: Particle -> SystemOfParticles -> SystemOfParticles

getMagneticForce :: (Point -> Vector) -> Particle -> Vector


getElectricForce :: (Point -> Vector) -> Particle -> Vector