module PointsForRendering where

import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL

--renderInWindow opens window, displayFunction = creates window graphics
{-
mainFor primitiveShape
 = renderInWindow (displayMyPoints primitiveShape)

displayMyPoints primitiveShape = do
	currentColor $= Color4 1 1 0 1
	clear [ColorBuffer]
	displayPoints myPoints primitiveShape

renderInWindow displayFunction = do
	(progName,_) <- getArgsAndInitialize
	createWindow progName
	displayCallback $= displayFunction
	mainLoop

displayPoints points primitiveShape = do
	renderAs primitiveShape points
	flush

renderAs figure ps = renderPrimitive figure $ makeVertexes ps

makeVertexes = mapM_ (\(x, y, z) -> vertex$Vertex3 x y z)


-}
