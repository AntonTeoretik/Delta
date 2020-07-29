module Graphics where

import GHC.Float
import Algebra as A
import Graphics.UI.GLUT as GLUT
import Graphics.Rendering.OpenGL
import PointsForRendering
import OrbitPointOfView
import Circle

--preservingMatrix : push the current matrix staack down by one, duplicating the current matrix, execute the given action, and pop the current matrix stack (restoring it to its previous state)
locally = preservingMatrix 

--рисует вектор в 3D пространстве в данной точке
displayVector :: (A.Point, A.Vector) -> IO() 

displayVector (A.Point xp yp zp, A.Vector xv yv zv) = do 
     let points = [(xp, yp, zp::Double)
                  ,(xp + xv, yp + yv, zp + zv::Double)]
     currentColor $= Color4 1 1 0 ( min 1 $ double2Float $ 1 * ( 1  / (1 + (4 * xp)^2 + (4 * yp)^2 + (4 * zp)^2)  ))
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



---- создает окно и устанавливает всю конфигурацию (матрицы перспективы, прозрачность, положение камеры) и устанавливает данную функцию в качестве отрисовывающей
createMyWindow :: IO() -> IO()

createMyWindow = undefined
