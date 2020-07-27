module StateUtil where

import Graphics.Rendering.OpenGL
import Data.IORef
import Graphics.UI.GLUT

--instance HasSetter IORef where
--   ($=) var val = write IORef var val

--instance HasGetter IORef where
--   get var = readIORef var

new = newIORef