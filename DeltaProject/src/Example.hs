module Example
    ( simpleField
    ) where
import Graphics
import Graphics.Rendering.OpenGL
import Algebra
import PointsForRendering

simpleField :: Point -> Vector
simpleField (Point x y z) = (Vector x y z) <#> (Vector 1 0 0)

main :: IO() -> IO()
main = renderInWindow (displayVector ((Point 0.1 0.3 0.5), (Vector 0.4 0.4 0.4)))
