module Circle where
import PointsForRendering
import Graphics.Rendering.OpenGL

circlePoints radius number = [let alpha = twoPi * i /number
                             in (radius * (sin (alpha)) , radius * (cos (alpha)), 0)
                             |i <- [1, 2..number]]
                             where
                                twoPi = 2 * pi

circle radius = circlePoints radius 100

renderCircleApprox r n = displayPoints (circlePoints r n)

renderCircle r = displayPoints (circle r) LineLoop

fillCircle r = do
    displayPoints (circle r) Polygon

