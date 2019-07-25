module Material.Elevation exposing
    ( z0, z1, z2, z3, z4, z5, z6, z7, z8
    , z9, z10, z11, z12, z13, z14, z15, z16
    , z17, z18, z19, z20, z21, z22, z23, z24
    )

{-|

@docs z0, z1, z2, z3, z4, z5, z6, z7, z8
@docs z9, z10, z11, z12, z13, z14, z15, z16
@docs z17, z18, z19, z20, z21, z22, z23, z24

-}

import Html
import Html.Attributes exposing (class)


{-| TODO
-}
z0 : Html.Attribute msg
z0 =
    z 0


{-| TODO
-}
z1 : Html.Attribute msg
z1 =
    z 1


{-| TODO
-}
z2 : Html.Attribute msg
z2 =
    z 2


{-| TODO
-}
z3 : Html.Attribute msg
z3 =
    z 3


{-| TODO
-}
z4 : Html.Attribute msg
z4 =
    z 4


{-| TODO
-}
z5 : Html.Attribute msg
z5 =
    z 5


{-| TODO
-}
z6 : Html.Attribute msg
z6 =
    z 6


{-| TODO
-}
z7 : Html.Attribute msg
z7 =
    z 7


{-| TODO
-}
z8 : Html.Attribute msg
z8 =
    z 8


{-| TODO
-}
z9 : Html.Attribute msg
z9 =
    z 9


{-| TODO
-}
z10 : Html.Attribute msg
z10 =
    z 10


{-| TODO
-}
z11 : Html.Attribute msg
z11 =
    z 11


{-| TODO
-}
z12 : Html.Attribute msg
z12 =
    z 12


{-| TODO
-}
z13 : Html.Attribute msg
z13 =
    z 13


{-| TODO
-}
z14 : Html.Attribute msg
z14 =
    z 14


{-| TODO
-}
z15 : Html.Attribute msg
z15 =
    z 15


{-| TODO
-}
z16 : Html.Attribute msg
z16 =
    z 16


{-| TODO
-}
z17 : Html.Attribute msg
z17 =
    z 17


{-| TODO
-}
z18 : Html.Attribute msg
z18 =
    z 18


{-| TODO
-}
z19 : Html.Attribute msg
z19 =
    z 19


{-| TODO
-}
z20 : Html.Attribute msg
z20 =
    z 20


{-| TODO
-}
z21 : Html.Attribute msg
z21 =
    z 21


{-| TODO
-}
z22 : Html.Attribute msg
z22 =
    z 22


{-| TODO
-}
z23 : Html.Attribute msg
z23 =
    z 23


{-| TODO
-}
z24 : Html.Attribute msg
z24 =
    z 24


z : Int -> Html.Attribute msg
z n =
    class ("mdc-elevation--z" ++ String.fromInt n)
