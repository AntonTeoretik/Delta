module Example
    ( simpleField
    , otherField
    , points
    , myParticle
    , myParticleSystem
    , myForce
    ) where

import Graphics
import Graphics.Rendering.OpenGL
import Algebra as A
import PointsForRendering
import TempParticles

myParticle :: Particle
myParticle = Particle (A.Point 0.5 0.7 0) (A.Vector 0 0.3 0) 100 20 1

myParticleSystem :: SystemOfParticles
myParticleSystem = SystemOfParticles [(Particle (A.Point (-0.5) (- 0.9) 0) (A.Vector 0 0.3 0) 300 20 1) 
              ,(Particle (A.Point 0.8 0.3 0) (A.Vector 0 0.4 0) 300 20 1)
              ,(Particle (A.Point 0.2 0.6 0) (A.Vector 0.2 0 0) 200 20 1)
              ,(Particle (A.Point (-0.3) 0.5 0) (A.Vector 0 0 0.2) 500 20 1)]
                                1

myForce :: A.Vector
myForce = A.Vector 1 1 0 

simpleField :: A.Point -> A.Vector
simpleField (A.Point x y z) = (*.) 0.4 $ (A.Vector x y z) <#> (A.Vector 1 0 0)

otherField :: A.Point -> A.Vector
otherField (A.Point x y z) = (*.) 0.4 $ (A.Vector x y z) <#> (A.Vector 0 1 0)

points = [(A.Point x y z) | x <- [(-1), (-0.9) .. 1]
                          , y <- [(-1), (-0.9) .. 1]
                          , z <- [(-1), (-0.9) .. 1]]


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
