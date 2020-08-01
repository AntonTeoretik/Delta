module PointAppearance where
import System.Random
import Random
import Particles
import Algebra

generateMassiveParticles :: Double -> -- cube length
                            Double -> -- max mass`
                            Double -> -- max charge
                            [Double] -> 
                            [Particle]
generateMassiveParticles l mm em (x : y : z : v1 : v2 : v3 : m : e : li : le : restz) = 
    Particle {
      position = Point (x*l/2) (y*l/2) (z*l/2), 
      velocity = Vector (v1*l/2) (v2*l/2) (v3*l/2), 
      mass = (abs m ) * mm , 
      electricCharge = e * em,
      lifetime = floor ((abs li)* 100),
      track = [],
      maxlenght =  floor ((abs le)* 10)
    } : (generateMassiveParticles l mm em restz)

extractParticlesfromCubeInSphere :: Double -> Double -> Particle -> Bool
extractParticlesfromCubeInSphere i l Particle {position = (Point x y z)} =  i^2 <= x^2 + y^2 + z^2 && x^2 + y^2 + z^2 <= l^2



generateParticlesInCube :: Int -> 
                           Double -> -- cube edge length
                           Double -> -- max mass`
                           Double -> -- max charge
                           [Particle]
generateParticlesInCube x l mm mc = generateMassiveParticles l mm mc $ generateRandoms x


generateParticlesInSphere :: Int -> 
                             Double -> -- small radius
                             Double -> -- large radius
                             Double -> -- max mass`
                             Double -> -- max charge
                             [Particle]
generateParticlesInSphere x i l mm mc = filter (extractParticlesfromCubeInSphere i l) (generateMassiveParticles (2*l) mm mc $ generateRandoms x) 



generateRandoms :: Int -> [Double]
generateRandoms x = randomRs (-1, 1) (mkStdGen x)

{-
generatePointsInCube :: Int -> Double -> [Point]
generatePointsInCube x r = pointsFromDoubles (randomRs (-(r/2), r/2) (mkStdGen x)) 

pointsFromDoubles :: [Double] -> [Point]
pointsFromDoubles (x : y : z : restz) = (Point  x y z) : (pointsFromDoubles restz)

randomNumber :: Int -> Double -> Double -> [Double]
randomNumber x m n = randomRs (m, n) (mkStdGen x)

extractPointfromCubeInSphere :: Double -> Point -> Bool
extractPointfromCubeInSphere r (Point x y z) = x^2 + y^2 + z^2 <= r^2

generatePointsInSphere :: Int -> Double -> [Point]
generatePointsInSphere x r = filter (extractPointfromCubeInSphere r) (generatePointsInCube x r) 
-}