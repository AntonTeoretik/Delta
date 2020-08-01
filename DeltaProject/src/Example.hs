module Example
    ( simpleField
    ) where
import Algebra

simpleField :: Point -> Vector
simpleField (Point x y z) = (Vector x y z) <#> (Vector 1 0 0)
