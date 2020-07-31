
module TempMasslessParticles where

import Data.List

import Algebra

data VirtualParticle = VirtualParticle {position :: Point, life :: Double}
data SystemOfVirtualParticles = SystemOfVirtualParticles {listOfVirtualParticles :: [VirtualParticle]}

evaluateParticle :: Double -> (Point -> Vector) -> VirtualParticle -> VirtualParticle
evaluateParticle t func (VirtualParticle pos time) = VirtualParticle (pos .-> t *. func pos) (time - t)

evaluateSVP :: Double -> (Point -> Vector) -> SystemOfVirtualParticles -> SystemOfVirtualParticles
evaluateSVP t func (SystemOfVirtualParticles list) = SystemOfVirtualParticles $ filter isAlive $ map (evaluateParticle t func) list

addVirtualParticleToSVP :: VirtualParticle -> SystemOfVirtualParticles -> SystemOfVirtualParticles
addVirtualParticleToSVP part (SystemOfVirtualParticles list) = SystemOfVirtualParticles $ part : list

isAlive :: VirtualParticle -> Bool
isAlive (VirtualParticle _ time) = time > 0
