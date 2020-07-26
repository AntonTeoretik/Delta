--module Example
--    ( simpleField
--    ) where

import Graphics
import Graphics.Rendering.OpenGL
import Algebra as A
import PointsForRendering

simpleField :: A.Point -> A.Vector
simpleField (A.Point x y z) = (A.Vector x y z) <#> (A.Vector 1 0 0)

--main :: IO() -> IO()
--main = renderInWindow (displayVector ((A.Point 0.1 0.3 0.5), (A.Vector 0.4 0.4 0.4)))
main = renderInWindow (displayVecField simpleField [(A.Point 0.5 0.1 0.3)
                                                   ,(A.Point 0.1 0.4 0.3) 
                                                   ,(A.Point 0.0 0.3 0.3)
                                                   ,(A.Point 0.7 0.7 0.7)])


