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
displayPoints :: PrimitiveMode -> [(GLdouble, GLdouble, GLdouble)] -> IO()

displayPoints primitiveShape points = do
   clear [DepthBuffer]
   currentColor $= Color4 1 1 0 0
   renderAs primitiveShape points
   flush

--renders points in specific way (Lines, Polygon ...)
renderAs :: PrimitiveMode -> [(GLdouble, GLdouble, GLdouble)] -> IO()

renderAs figure ps = renderPrimitive figure $ makeVertexes ps

--makes GL vertexes out of list of coordinates
makeVertexes :: [(GLdouble, GLdouble, GLdouble)] -> IO()

makeVertexes = mapM_ (\(x, y, z) -> vertex$Vertex3 x y z)