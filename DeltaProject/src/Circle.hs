module Circle where
import PointsForRendering
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT.Objects

circlePoints radius number = [let alpha = twoPi * i /number
                             in (radius * (sin (alpha)) , radius * (cos (alpha)), 0)
                             |i <- [1, 2..number]]
                             where
                                twoPi = 2 * pi

circle radius = circlePoints radius 100

--renderCircleApprox r n = displayPoints (circlePoints r n)

renderCircle r = displayPoints LineLoop (circle r) 

fillCircle r = do
    displayPoints Polygon (circle r) 

renderSphere r lat long = do
    currentColor $= Color4 1 0.2 1 1
    renderObject Solid $ Sphere' r lat long

renderOtherSphere r lat long = do
    currentColor $= Color4 0 1 0.3 1
    renderObject Solid $ Sphere' r lat long 