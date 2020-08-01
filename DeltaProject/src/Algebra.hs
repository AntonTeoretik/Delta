{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Algebra where

import GHC.Generics (Generic)
import Control.DeepSeq

data Point = Point { px :: Double, py :: Double, pz :: Double }
  deriving (Eq, Generic, NFData, Show)

data Vector = Vector { vx :: Double, vy :: Double, vz :: Double }
  deriving (Eq, Generic, NFData, Show)

distance :: Point -> Point -> Double
distance (Point x1 y1 z1) (Point x2 y2 z2) = sqrt ((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2)

infixl 7 -->
infixl 7 .->
infixl 6 <#>

infixl 8 *.
infixl 4 <+>
infixl 4 <->

-- Dot product
(<.>) :: Vector -> Vector -> Double
(<.>) (Vector x1 y1 z1) (Vector x2 y2 z2) = x1 * x2 + y1 * y2 + z2 * z2

-- Cross product
(<#>) :: Vector -> Vector -> Vector
(<#>) (Vector x1 y1 z1) (Vector x2 y2 z2) = Vector (y1 * z2 - z1 * y2)
                                                   (z1 * x2 - x1 * z2)
                                                   (x1 * y2 - y1 * x2)

-- Scalar product
(*.) :: Double -> Vector -> Vector
(*.) d (Vector x y z) = Vector (x * d)
                               (y * d)
                               (z * d)

-- Add, Sub
(<+>) :: Vector -> Vector -> Vector
(<+>) (Vector x1 y1 z1) (Vector x2 y2 z2) = Vector (x1 + x2)
                                                   (y1 + y2)
                                                   (z1 + z2)

(<->) :: Vector -> Vector -> Vector
(<->) (Vector x1 y1 z1) (Vector x2 y2 z2) = Vector (x1 - x2)
                                                   (y1 - y2)
                                                   (z1 - z2)

zero :: Vector
zero = Vector 0 0 0

-- Connection between vectors and points
(-->) :: Point -> Point -> Vector
(-->) (Point x1 y1 z1) (Point x2 y2 z2) = Vector (x2 - x1)
                                                 (y2 - y1)
                                                 (z2 - z1)

-- Translate point
(.->) :: Point -> Vector -> Point
(.->) (Point xp yp zp) (Vector xv yv zv) = Point (xp + xv)
                                                 (yp + yv)
                                                 (zp + zv)

veclength :: Vector -> Double
veclength (Vector x y z) = distance (Point x y z) (Point 0 0 0)

normalize :: Vector -> Vector
normalize v = 
  let d = veclength v in
    case d of
        0 -> zero
        _ -> (1/d) *. v

