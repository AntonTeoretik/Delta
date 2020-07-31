module Graphics where

import GHC.Float
import Algebra as A
import Graphics.UI.GLUT as GLUT
import Graphics.Rendering.OpenGL
import PointsForRendering
import OrbitPointOfView
import Circle

--import Particles

--preservingMatrix : push the current matrix staack down by one, duplicating the current matrix, execute the given action, and pop the current matrix stack (restoring it to its previous state)
locally = preservingMatrix 

--рисует вектор в 3D пространстве в данной точке
displayVector :: (A.Point, A.Vector) -> IO() 

displayVector (A.Point xp yp zp, A.Vector xv yv zv) = do 
     let points = [(xp, yp, zp::Double)
                  ,(xp + xv, yp + yv, zp + zv::Double)]
     let x = double2Float (distance (A.Point xp yp zp) (A.Point (xp + xv) (yp + yv) (zp + zv)))
     --currentColor $= Color4 1 1 0 ( min 1 $ double2Float $ 1 * ( 1 / (1 + (2.5 * xp)^2 + (2.5 * yp)^2 + (2.5 * zp)^2)  ))
     --currentColor $= Color4 1 1 0 (if (x < 3) then (x / 3) else 1)
     currentColor $= Color4 (min 1 (1.7 * x)) 1 0 (min 1 (1.7 * x))

     renderAs Lines points
     flush

--принимает векторное поле и список точек, в которых нужно нарисовать вектора, рисует их
--можно спокойно менять "0.1"
displayVecField :: (A.Point -> A.Vector) -> [A.Point] -> IO()

displayVecField vecField ps = do
    initialDisplayMode $= [RGBAMode, WithAlphaComponent, WithDepthBuffer]
    depthFunc $= Just Less
    blend $= Enabled 
    blendFunc $= (SrcAlpha, OneMinusSrcAlpha)
    clear [ColorBuffer, DepthBuffer]
    mapM_ displayVector (zip ps $ map vecField ps)
    flush

--принимает массовую частицу и рисует её (делает более прозрачной пока время двигается)
--displayParticle :: (Particle (A.Point xp yp zp) (A.Vector xv yv zv) life mass charge) -> IO()

--displayParticle myParticle = do
--    let start = (px $ position myParticle, py $ position myParticle, pz $ position myParticle :: Double)
--    let updatedParticle = evaluateParticle (Particle (A.Point xp yp zp) (A.Vector xv yv zv) life mass charge)
--    let end = (px $ position updatedParticle, py $ position updatedParticle, pz $ position updatedParticle)
--    currentColor $= Color4 0 1 1 $ time updatedParticle
--    translate (renderSphere 0.1 10 10) (vector updatedParticle)
--    flush
--
--displaySystemOfParticles :: [Particle] -> IO()
--
--displaySystemOfParticles particles = do
--    initialDisplayMode $= [RGBAMode, WithAlphaComponent, WithDepthBuffer]
--    depthFunc $= Just Less
--    blend $= Enabled
--    blendFunc $= (SrcAlpha, OneMinusSrcAlpha)
--    clear [ColorBuffer, DepthBuffer]
--    mapM_ displayParticle particles
--    flush

---- создает окно и устанавливает всю конфигурацию (матрицы перспективы, прозрачность, положение камеры) и устанавливает данную функцию в качестве отрисовывающей
createMyWindow :: IO() -> IO()

createMyWindow = undefined
