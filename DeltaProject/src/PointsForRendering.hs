module PointsForRendering where

import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL

--renderInWindow opens window, displayFunction = creates window graphics

--opens window in which displayFunction creates the graphics
renderInWindow displayFunction = do
   (progName,_) <- getArgsAndInitialize
   createWindow progName
   displayCallback $= displayFunction
   mainLoop

--renderAs but monad form and actually creates the graphics
displayPoints :: [(GLdouble, GLdouble, GLdouble)] -> PrimitiveMode -> IO()

displayPoints points primitiveShape = do
   renderAs primitiveShape points
   flush

--renders points in specific way (Lines, Polygon ...)
renderAs :: PrimitiveMode -> [(GLdouble, GLdouble, GLdouble)] -> IO()

renderAs figure ps = renderPrimitive figure $ makeVertexes ps

--makes GL vertexes out of list of coordinates
makeVertexes :: [(GLdouble, GLdouble, GLdouble)] -> IO()

makeVertexes = mapM_ (\(x, y, z) -> vertex$Vertex3 x y z)















--mainFor primitiveShape
-- = renderInWindow (displayMyPoints primitiveShape)

--displayMyPoints primitiveShape = do
--   currentColor $= Color4 1 1 0 1
--   clear [ColorBuffer]
--   displayPoints myPoints primitiveShape



--myPoints
-- = [(0.2, -0.4, 0::GLdouble)
--   ,(0.46, -0.26, 0)
--   ,(0.6, 0, 0)
--   ,(0.46, 0.46, 0)
--   ,(0.2, 0.6, 0)
--   ,(0, 0.6, 0)
--   ,(-0.26, 0.46, 0)
--   ,(-0.4, 0.2, 0)
--   ,(-0.4, 0, 0)
--   ,(-0.26, -0.26, 0)
--   ,(0, -0.4, 0)
--   ]