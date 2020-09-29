module Pen exposing (Mark, Pen, fixedWidth, mark, variableWidth)

import CoordinateSpace exposing (..)
import Ellipse2d exposing (Ellipse2d)
import Length


type Pen
    = Pen Details


type alias FixedWidthInput =
    { height : Float
    , width : Float
    }


fixedWidth : FixedWidthInput -> Pen
fixedWidth { height, width } =
    { profileMinPressure =
        { radiusX = width
        , radiusY = height
        }
    , profileMaxPressure =
        { radiusX = width
        , radiusY = height
        }
    }
        |> Pen


type alias VariableWidthInput =
    { height : Float
    , widthMin : Float
    , widthMax : Float
    }


variableWidth : VariableWidthInput -> Pen
variableWidth { height, widthMin, widthMax } =
    { profileMinPressure =
        { radiusX = widthMin
        , radiusY = height
        }
    , profileMaxPressure =
        { radiusX = widthMax
        , radiusY = height
        }
    }
        |> Pen


type alias Details =
    { profileMinPressure : Profile
    , profileMaxPressure : Profile
    }


type alias Profile =
    { radiusX : Float
    , radiusY : Float
    }


type alias MarkInput =
    { position : Point
    , angle : Direction
    , pressure : Float
    }


type Mark
    = Mark (Ellipse2d StdUnits StdCoords)


mark : Pen -> MarkInput -> Mark
mark (Pen { profileMinPressure, profileMaxPressure }) { position, angle, pressure } =
    let
        xRadius : Float
        xRadius =
            interpolate profileMinPressure.radiusX profileMaxPressure.radiusX pressure

        yRadius : Float
        yRadius =
            interpolate profileMinPressure.radiusY profileMaxPressure.radiusY pressure
    in
    Ellipse2d.with
        { centerPoint = position
        , xDirection = angle
        , xRadius = Length.millimeters xRadius
        , yRadius = Length.millimeters yRadius
        }
        |> Mark


interpolate : Float -> Float -> Float -> Float
interpolate min max interpolator =
    let
        clampedInterpolator =
            clamp min max interpolator
    in
    (min * (1.0 - clampedInterpolator))
        + (max * clampedInterpolator)
