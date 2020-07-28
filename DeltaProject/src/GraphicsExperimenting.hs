module GraphicsExperimenting where

import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL

--to execute: 
-- ghc -package GLUT -o [name_of_result] GraphicsExperimenting.hs

--createAWindow is a variable name, can change to anything
--can replace prog_Name with a string, which would be the name of the program

main = do
  (prog_Name,_) <- getArgsAndInitialize
  createAWindow prog_Name
  --createAWindow "getScreenAndWindow"
  --x <- get screenSize --shows size of whole screen
  x <- get initialWindowSize
  print x
  mainLoop



-- displayPoints = displays points that I define
-- nyWindow = variable name, can change to anything

createAWindow myWindow = do
  createWindow myWindow
  initialWindowSize $= Size 400 500 --changes default window size from Size 300 300
  displayCallback $= display 

-- GLfloat = floating point coordinates in GL
-- default dimensions of graphics window: lower left corner = (-1, -1), upper right corner = (1, 1)


--clear [ColorBuffer] = creates transparent window
--renderPrimitive = 1st arg - what rendering, 2nd arg - transform coordinates into data used by HOpenGL
-- l-> Points = draw points
-- l-> Polygon = draw points and fill in the space between them with borders = straight lines 
--     l-> no anti-aliasing :)
-- l-> 2nd argument is sequence of monadic statements
--     l-> mapM_ is the composition of map and sequence, such that a list of triples can be converted to a monadic vertex statement
--flush = says to draw what was requested (commands = "please do something")

--display function
display = do
    clearColor $= Color4 1 0 0 1
    clear [ColorBuffer] --clear everything from window
    let points = [((-0.25), 0.25, 0.0::GLfloat)
                  ,(0.75, 0.35, 0.0)
                  ,(0.75, (-0.15), 0.0)]
    renderLineLoop points
    flush

makeVertexes = mapM_ (\(x, y, z)->vertex$Vertex3 x y z)

renderAs figure ps = renderPrimitive figure$makeVertexes ps

renderPolygon = renderAs Polygon

renderLines = renderAs Lines -- connects point 1 with 2, 3 with 4, etc

renderLineLoop = renderAs LineLoop -- connects into outline of polygon

--also exist:
--  LineStrip (connects all points except last to first)
-- Triangles (takes 1st 3, 2nd 3, etc, and makes triangles)
-- TriangleStrips (sequence of triangles where the next triangle uses 2 points of predecessor and one new point)
-- TriangleFan (one starting point for all triangles, drawn starting from the first point)
-- Quads (like Triangles but with 4-point-groups)
-- QuadStrips (2 points of preceeding quads for the next quad -> need n = 4 + 2 * m vertexes)
-- Polygon (connects arbitrary number of points - no convex corners allowed, lines may not cross each other, need to be planar)

----------------------------------------------------------------

--MONADS

--monads have "do" notation
--l-> start with keyword "do"

--variables are defined and redefined in let-expressions
--l-> variables in let-expressions redefine each time - 4th line of example creates a new variable x, not assigns a new value to existing variable x

--monadic statements have a result that is retrieved by the <- notation

-- main = do
--   let x = 5
--   print x
--   let x = 6
--   print x
--   xs <- getLine
--   print (length xs)

----------------------------------------------------------------

--Setting Values

-- $= assigns values to variables (left operand is a variable that gets assigned right operand)

----------------------------------------------------------------

--what can draw with Primitive:

--data PrimitiveMode = Points
--                   | Lines
--                   | LineLoop
--                   | LineStrip
--                   | Triangles
--                   | TriangleStrip
--                   | TriangleFan
--                   | Quads
--                   | QuadStrip
--                   | Polygon
--                   deriving ( Eq, Ord, Show )