module Material.Elevation exposing
    ( z
    , z0
    , z1
    , z10
    , z11
    , z12
    , z13
    , z14
    , z15
    , z16
    , z17
    , z18
    , z19
    , z2
    , z20
    , z21
    , z22
    , z23
    , z24
    , z3
    , z4
    , z5
    , z6
    , z7
    , z8
    , z9
    )

import Html
import Html.Attributes exposing (class)


z0 : Html.Attribute msg
z0 =
    z 0


z1 : Html.Attribute msg
z1 =
    z 1


z2 : Html.Attribute msg
z2 =
    z 2


z3 : Html.Attribute msg
z3 =
    z 3


z4 : Html.Attribute msg
z4 =
    z 4


z5 : Html.Attribute msg
z5 =
    z 5


z6 : Html.Attribute msg
z6 =
    z 6


z7 : Html.Attribute msg
z7 =
    z 7


z8 : Html.Attribute msg
z8 =
    z 8


z9 : Html.Attribute msg
z9 =
    z 9


z10 : Html.Attribute msg
z10 =
    z 10


z11 : Html.Attribute msg
z11 =
    z 11


z12 : Html.Attribute msg
z12 =
    z 12


z13 : Html.Attribute msg
z13 =
    z 13


z14 : Html.Attribute msg
z14 =
    z 14


z15 : Html.Attribute msg
z15 =
    z 15


z16 : Html.Attribute msg
z16 =
    z 16


z17 : Html.Attribute msg
z17 =
    z 17


z18 : Html.Attribute msg
z18 =
    z 18


z19 : Html.Attribute msg
z19 =
    z 19


z20 : Html.Attribute msg
z20 =
    z 20


z21 : Html.Attribute msg
z21 =
    z 21


z22 : Html.Attribute msg
z22 =
    z 22


z23 : Html.Attribute msg
z23 =
    z 23


z24 : Html.Attribute msg
z24 =
    z 24


z : Int -> Html.Attribute msg
z n =
    class ("mdc-elevation--z" ++ String.fromInt n)
