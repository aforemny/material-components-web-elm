module Material.Elevation exposing
    ( z0, z1, z2, z3, z4, z5, z6, z7, z8
    , z9, z10, z11, z12, z13, z14, z15, z16
    , z17, z18, z19, z20, z21, z22, z23, z24
    )

{-| Shadows provide important visual cues about objects’ depth and directional
movement. They are the only visual cue indicating the amount of separation
between surfaces. An object’s elevation determines the appearance of its
shadow. The elevation values are mapped out in a "z-space" and range from 0
(flush with the surface) to 24dp (most elevated).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Elevation](#elevation)


# Resources

  - [Demo: Elevations](https://aforemny.github.io/material-components-web-elm/#elevations)
  - [Material Design Guidelines: Shadows & elevation](https://material.io/go/design-elevation)
  - [MDC Web: Elevation](https://github.com/material-components/material-components-web/tree/master/packages/mdc-elevation)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-elevation#sass-mixins-variables-and-functions)


# Basic Usage

    import Material.Elevation as Elevation

    main =
        Html.div [ Elevation.z8 ] [ text "Elevation" ]


# Elevation

@docs z0, z1, z2, z3, z4, z5, z6, z7, z8
@docs z9, z10, z11, z12, z13, z14, z15, z16
@docs z17, z18, z19, z20, z21, z22, z23, z24

-}

import Html
import Html.Attributes exposing (class)


{-| 0dp elevation (no elevation)
-}
z0 : Html.Attribute msg
z0 =
    z 0


{-| 1dp elevation
-}
z1 : Html.Attribute msg
z1 =
    z 1


{-| 2dp elevation
-}
z2 : Html.Attribute msg
z2 =
    z 2


{-| 3dp elevation
-}
z3 : Html.Attribute msg
z3 =
    z 3


{-| 4dp elevation
-}
z4 : Html.Attribute msg
z4 =
    z 4


{-| 5dp elevation
-}
z5 : Html.Attribute msg
z5 =
    z 5


{-| 6dp elevation
-}
z6 : Html.Attribute msg
z6 =
    z 6


{-| 7dp elevation
-}
z7 : Html.Attribute msg
z7 =
    z 7


{-| 8dp elevation
-}
z8 : Html.Attribute msg
z8 =
    z 8


{-| 9dp elevation
-}
z9 : Html.Attribute msg
z9 =
    z 9


{-| 10dp elevation
-}
z10 : Html.Attribute msg
z10 =
    z 10


{-| 11dp elevation
-}
z11 : Html.Attribute msg
z11 =
    z 11


{-| 12dp elevation
-}
z12 : Html.Attribute msg
z12 =
    z 12


{-| 13dp elevation
-}
z13 : Html.Attribute msg
z13 =
    z 13


{-| 14dp elevation
-}
z14 : Html.Attribute msg
z14 =
    z 14


{-| 15dp elevation
-}
z15 : Html.Attribute msg
z15 =
    z 15


{-| 16dp elevation
-}
z16 : Html.Attribute msg
z16 =
    z 16


{-| 17dp elevation
-}
z17 : Html.Attribute msg
z17 =
    z 17


{-| 18dp elevation
-}
z18 : Html.Attribute msg
z18 =
    z 18


{-| 19dp elevation
-}
z19 : Html.Attribute msg
z19 =
    z 19


{-| 20dp elevation
-}
z20 : Html.Attribute msg
z20 =
    z 20


{-| 21dp elevation
-}
z21 : Html.Attribute msg
z21 =
    z 21


{-| 22dp elevation
-}
z22 : Html.Attribute msg
z22 =
    z 22


{-| 23dp elevation
-}
z23 : Html.Attribute msg
z23 =
    z 23


{-| 24dp elevation
-}
z24 : Html.Attribute msg
z24 =
    z 24


z : Int -> Html.Attribute msg
z n =
    class ("mdc-elevation--z" ++ String.fromInt n)
