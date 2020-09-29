module Pen exposing (..)

import CoordinateSpace exposing (..)
import Ellipse2d exposing (Ellipse2d)


type Pen
    = Pen Details


type alias Details =
    { profileMinPressure : Profile
    , profileMaxPressure : Profile
    }


type alias Profile =
    { radiusX : Float
    , radiusY : Float
    }
