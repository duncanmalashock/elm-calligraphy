module CoordinateSpace exposing (Direction, Point, StdCoords, StdUnits)

import Direction2d exposing (Direction2d)
import Length
import Point2d exposing (Point2d)


type StdCoords
    = StdCoords


type alias StdUnits =
    Length.Meters


type alias Point =
    Point2d Length.Meters StdCoords


type alias Direction =
    Direction2d StdCoords
