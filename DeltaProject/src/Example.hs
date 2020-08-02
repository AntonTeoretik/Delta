module Example where

import Graphics
import Graphics.Rendering.OpenGL
import Algebra as A
import PointsForRendering
import Particles
import TempMasslessParticles

--почему-то у виртуальных частиц время двигается гораздо медленее чем у массовых

myParticle :: Particle
myParticle = Particle (A.Point 0.5 0.7 0) (A.Vector 0 0.3 0) 100 20 1 [] 5

myParticleSystem :: SystemOfParticles
{-myParticleSystem = SystemOfParticles [(Particle (A.Point (-0.7) (- 0.5) 0) (A.Vector 0 0.3 0) 500 20 1 [] 300) 

              ,(Particle (A.Point 0.8 0.3 0) (A.Vector 0 0.4 0) 500 20 1 [] 300)
              ,(Particle (A.Point 0.2 0.6 0) (A.Vector 0.2 0 0) 500 20 1 [] 300)
              ,(Particle (A.Point 0.1 0.5 0) (A.Vector 0.5 0 0.2) 500 20 1 [] 300)]
                                1
-}
{-myParticleSystem = SystemOfParticles [(Particle (A.Point x y z)
                                                (A.Vector a b c)
                                                lifetime
                                                mass
                                                charge
                                                track
                                                maxTrack)         
                                                                  | x <- [(-1), (-0.5) .. 1]
                                                                , y <- [(-1), (-0.5) .. 1]
                                                                , z <- [(-1), (-0.5) .. 1]
                                                                , a <- take 5 (return 0.1)
                                                                , b <- take 5 (return 0.1)
                                                                , c <- take 5 (return 0.1)
                                                                , lifetime <- take 5 (return 1000)
                                                                , mass <- take 5 (return 1000)
                                                                , charge <- take 5 (return 100)
                                                                , track <- take 5 (return [])
                                                                , maxTrack <- take 5 (return 300)]   
 

9 -}

myParticleSystem = SystemOfParticles [] 10                                 
                                               
myVirtualParticle :: VirtualParticle
myVirtualParticle = VirtualParticle (A.Point 0.5 0.7 0) 1.0

myVirtualParticleSystem :: SystemOfVirtualParticles
{-myVirtualParticleSystem = SystemOfVirtualParticles [(VirtualParticle (A.Point 0.5 0.7 0) 5),
                           (VirtualParticle (A.Point (-0.3) (-0.2) 0.4) 5),
                           (VirtualParticle (A.Point 0.8 0.1 (-1)) 5)]
-}
{-myVirtualParticleSystem = SystemOfVirtualParticles [(VirtualParticle (A.Point x y z) life) | x <- [(-1), (-0.5) .. 1]
                                                                                        , y <- [(-1), (-0.5) .. 1]
                                                                                        , z <- [(-1), (-0.5) .. 1]
                                                                                        , life <- take 5 (repeat 20)]
                                                   
-}
myVirtualParticleSystem = SystemOfVirtualParticles [] 

myForce :: A.Vector
myForce = A.Vector 1 1 0 

simpleField :: A.Point -> A.Vector
simpleField (A.Point x y z) = (*.) 0.4 $ (A.Vector x y z) <#> (A.Vector 1 0 0)

otherField :: A.Point -> A.Vector
otherField (A.Point x y z) = (*.) 0.4 $ (A.Vector x y z) <#> (A.Vector 0 1 0)

{-
myPoints = [(A.Point x y z) | x <- [(-1), (-0.9) .. 1]
                          , y <- [(-1), (-0.9) .. 1]
                          , z <- [(-1), (-0.9) .. 1]]
-}



{-
points = [(A.Point x y z) | x <- [0, 0.1 .. 1]
                        , y <- [0, 0.1 .. 1]
                        , z <- [0, 0.1 .. 1]]

-}
--main = renderInWindow (displayVector ((A.Point 0.1 0.3 0.5), (A.Vector 0.4 0.4 0.4)))
{- main = createWindow (displayVecField simpleField [(A.Point 0.5 0.1 0)
                                                 ,(A.Point 0.1 0.1 0) 
                                                 ,(A.Point 0.5 0.5 0)
                                                 ,(A.Point 0.1 0.5 0)
                                                 ,(A.Point 1 0 0)])

-}                                                 
