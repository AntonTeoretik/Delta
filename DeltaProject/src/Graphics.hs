{-# LANGUAGE FlexibleContexts #-}

module Graphics where

import Algebra as A
import Graphics.Rendering.OpenGL
import PointsForRendering
import OrbitPointOfView
import Circle


--рисует вектор в 3D пространстве в данной точке
displayVector :: (A.Point, A.Vector) -> IO() 

displayVector (A.Point xp yp zp, A.Vector xv yv zv) = do 
     let points = [(xp, yp, zp::GLdouble)
                  ,(xv, yv, zv)]
     renderAs Lines points
     flush


--принимает векторное поле и список точек, в которых нужно нарисовать вектора, рисует их
displayVecField :: (A.Point -> A.Vector) -> [A.Point] -> IO()

displayVecField vecField ps = do
    currentColor $= Color4 1 1 0 1
    clear [ColorBuffer, DepthBuffer]
    mapM_ displayVector (zip ps $ map vecField ps)
    flush



---- создает окно и устанавливает всю конфигурацию (матрицы перспективы, прозрачность, положение камеры) и устанавливает данную функцию в качестве отрисовывающей
createMyWindow :: IO() -> IO()

createMyWindow displayFunction = do
    (progName, _) <- getArgsAndInitialize
    initialDisplayMode $= [DepthBuffer, doubleBuffer]
    createWindow progName
    depthFunc $= Just Less

    pPos <- new (90::Int, 270::Int, 2.0)
    keyboardMouseCallback $= Just (keyboard pPos)

    displayCallback $= display pPos
    reshapeCallback $= Just reshape
    mainLoop

display pPos = do
    loadIdentity
    setPointOfView pPos
    clear [ColorBuffer, DepthBuffer]
    circle 5
    swapBuffers

keyboard pPos c _  _ _ = keyForPos pPos c