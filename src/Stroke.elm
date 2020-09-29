module Stroke exposing (Stroke, withConstantRotationAndPressure)

import CoordinateSpace exposing (..)
import CubicSpline2d exposing (CubicSpline2d)


type Stroke
    = Stroke Details


type alias ConstantStrokeInput =
    { path : CubicSpline2d StdUnits StdCoords
    , penAngle : Direction
    }


withConstantRotationAndPressure : ConstantStrokeInput -> Stroke
withConstantRotationAndPressure { path, penAngle } =
    { path = path
    , penAngle = ConstantRotation penAngle
    , pressure = ConstantPressure 1.0
    }
        |> Stroke


type alias Details =
    { path : CubicSpline2d StdUnits StdCoords
    , penAngle : Rotation
    , pressure : Pressure
    }


type Rotation
    = ConstantRotation Direction


type Pressure
    = ConstantPressure Float
