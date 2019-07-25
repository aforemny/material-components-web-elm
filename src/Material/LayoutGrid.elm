module Material.LayoutGrid exposing
    ( layoutGrid, layoutGridInner, layoutGridCell
    , span1, span2, span3, span4, span5, span6, span7, span8, span9, span10, span11, span12
    , alignLeft, alignRight
    , alignTop, alignMiddle, alignBottom
    , Device(..)
    )

{-|

@docs layoutGrid, layoutGridInner, layoutGridCell

@docs span1, span2, span3, span4, span5, span6, span7, span8, span9, span10, span11, span12

@docs alignLeft, alignRight

@docs alignTop, alignMiddle, alignBottom

@docs Device

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)


{-| TODO docs
-}
type Device
    = Desktop
    | Tablet
    | Phone


{-| TODO docs
-}
layoutGrid : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGrid attributes nodes =
    Html.node "mdc-layout-grid"
        (class "mdc-layout-grid" :: style "display" "block" :: attributes)
        nodes


{-| TODO docs
-}
layoutGridInner : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGridInner attributes nodes =
    Html.div (class "mdc-layout-grid__inner" :: attributes) nodes


{-| TODO docs
-}
layoutGridCell : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGridCell attributes nodes =
    Html.div (class "mdc-layout-grid__cell" :: attributes) nodes


{-| TODO docs
-}
alignBottom : Html.Attribute msg
alignBottom =
    class "mdc-layout-grid__cell--align-bottom"


{-| TODO docs
-}
alignLeft : Html.Attribute msg
alignLeft =
    class "mdc-layout-grid--align-left"


{-| TODO docs
-}
alignRight : Html.Attribute msg
alignRight =
    class "mdc-layout-grid--align-right"


{-| TODO docs
-}
alignMiddle : Html.Attribute msg
alignMiddle =
    class "mdc-layout-grid__cell--align-middle"


{-| TODO docs
-}
alignTop : Html.Attribute msg
alignTop =
    class "mdc-layout-grid__cell--align-top"


span : Int -> Html.Attribute msg
span n =
    class ("mdc-layout-grid__cell--span-" ++ String.fromInt n)


{-| TODO docs
-}
span1 : Html.Attribute msg
span1 =
    span 1


{-| TODO docs
-}
span2 : Html.Attribute msg
span2 =
    span 2


{-| TODO docs
-}
span3 : Html.Attribute msg
span3 =
    span 3


{-| TODO docs
-}
span4 : Html.Attribute msg
span4 =
    span 4


{-| TODO docs
-}
span5 : Html.Attribute msg
span5 =
    span 5


{-| TODO docs
-}
span6 : Html.Attribute msg
span6 =
    span 6


{-| TODO docs
-}
span7 : Html.Attribute msg
span7 =
    span 7


{-| TODO docs
-}
span8 : Html.Attribute msg
span8 =
    span 8


{-| TODO docs
-}
span9 : Html.Attribute msg
span9 =
    span 9


{-| TODO docs
-}
span10 : Html.Attribute msg
span10 =
    span 10


{-| TODO docs
-}
span11 : Html.Attribute msg
span11 =
    span 11


{-| TODO docs
-}
span12 : Html.Attribute msg
span12 =
    span 12
