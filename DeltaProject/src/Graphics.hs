module Graphics where

import Algebra as A
import Graphics.Rendering.OpenGL

renderAs figure ps = renderPrimitive figure $ makeVertexes ps
makeVertexes = mapM_ (\(x, y, z) -> vertex$Vertex3 x y z)

--рисует вектор в 3D пространстве в данной точке
displayVector :: (A.Point, A.Vector) -> IO() 

displayVector (A.Point xp yp zp, A.Vector xv yv zv) = do
     clear [ColorBuffer] 
     let points = [(xp, yp, zp::Double)
                  ,(xv, yv, zv)]
     renderAs Lines points


--принимает векторное поле и список точек, в которых нужно нарисовать вектора, рисует их
displayVecField :: (A.Point -> A.Vector) -> [A.Point] -> IO()

displayVecField vecField ps = head $ map displayVector (zip ps $ map vecField ps)



---- создает окно и устанавливает всю конфигурацию (матрицы перспективы, прозрачность, положение камеры) и устанавливает данную функцию в качестве отрисовывающей
createWindow :: IO() -> IO()

createWindow = undefined

