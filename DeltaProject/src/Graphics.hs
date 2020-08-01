module Graphics where

import GHC.Float
import Algebra as A
import Graphics.UI.GLUT as GLUT
import Graphics.Rendering.OpenGL
import PointsForRendering
import OrbitPointOfView
import Circle


--preservingMatrix : push the current matrix stack down by one, duplicating the current matrix, execute the given action, and pop the current matrix stack (restoring it to its previous state)
locally = preservingMatrix 

--рисует вектор в 3D пространстве в данной точке
displayVector :: (A.Point, A.Vector) -> IO() 

displayVector (A.Point xp yp zp, A.Vector xv yv zv) = do
     let short = (*.) 0.2 $ A.normalize (A.Vector xv yv zv) 
     let points = [(xp, yp, zp::Double)
                  ,(xp + (vx short), yp + (vy short), zp + (vz short)::Double)]
     let x = double2Float (distance (A.Point xp yp zp) (A.Point (xp + xv) (yp + yv) (zp + zv)))
     --currentColor $= Color4 1 1 0 ( min 1 $ double2Float $ 1 * ( 1 / (1 + (2.5 * xp)^2 + (2.5 * yp)^2 + (2.5 * zp)^2)  ))
     --currentColor $= Color4 1 1 0 (if (x < 3) then (x / 3) else 1)
     currentColor $= Color4 (1 / (1 + x)) 1 0 (1 - 1 / (1 + x))

     renderAs Lines points
     flush

--принимает векторное поле и список точек, в которых нужно нарисовать вектора, рисует их
displayVecField :: (A.Point -> A.Vector) -> [A.Point] -> IO()

displayVecField vecField ps = do
    initialDisplayMode $= [RGBAMode, WithAlphaComponent, WithDepthBuffer]
    depthFunc $= Just Less
    blend $= Enabled 
    blendFunc $= (SrcAlpha, OneMinusSrcAlpha)
    clear [ColorBuffer, DepthBuffer]
    mapM_ displayVector (zip ps $ map vecField ps)
    flush


---- создает окно и устанавливает всю конфигурацию (матрицы перспективы, прозрачность, положение камеры) и устанавливает данную функцию в качестве отрисовывающей
createMyWindow :: IO() -> IO()

createMyWindow = undefined
