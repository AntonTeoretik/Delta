module MasslessParticles where

import Data.List

import Algebra

data VirtualParticle = VirtualParticle Point Double
data SystemOfVirtualParticles = SystemOfVirtualParticles [VirtualParticle]

evaluateParticle :: Double -> (Point -> Vector) -> VirtualParticle -> VirtualParticle
evaluateParticle t func (VirtualParticle pos time) = VirtualParticle (pos .-> t .* func pos) (time - t)

evaluateSVP :: Double -> (Point -> Vector) -> SystemOfVirtualParticles -> SystemOfVirtualParticles
evaluateSVP t func (SystemOfVirtualParticles list) = SystemOfVirtualParticles $ filter isAlive $ map (evaluateParticle t func) list

addVirtualParticleToSVP :: VirtualParticle -> SystemOfVirtualParticles -> SystemOfVirtualParticles
addVirtualParticleToSVP part (SystemOfVirtualParticles list) = SystemOfVirtualParticles $ part : list

isAlive :: VirtualParticle -> Bool
isAlive (VirtualParticle _ time) = time > 0