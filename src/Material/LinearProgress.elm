module Material.LinearProgress exposing
    ( Config
    , Variant(..)
    , linearProgress
    , linearProgressConfig
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { variant : Variant
    , reverse : Bool
    , closed : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


type Variant
    = Indeterminate
    | Determinate Float
    | Buffered Float Float


linearProgressConfig : Config msg
linearProgressConfig =
    { variant = Indeterminate
    , reverse = False
    , closed = False
    , additionalAttributes = []
    }


linearProgress : Config msg -> Html msg
linearProgress config =
    Html.node "mdc-linear-progress"
        (List.filterMap identity
            [ rootCs
            , roleAttr
            , variantCs config
            , progressAttr config
            , bufferAttr config
            ]
            ++ config.additionalAttributes
        )
        [ bufferingDotsElt
        , bufferElt
        , primaryBarElt
        , secondaryBarElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-linear-progress")


roleAttr : Maybe (Html.Attribute msg)
roleAttr =
    Just (Html.Attributes.attribute "role" "progressbar")


variantCs : Config msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    case variant of
        Indeterminate ->
            Just (class "mdc-linear-progress--indeterminate")

        _ ->
            Nothing


progressAttr : Config msg -> Maybe (Html.Attribute msg)
progressAttr { variant } =
    case variant of
        Determinate progress ->
            Just (Html.Attributes.attribute "progress" (String.fromFloat progress))

        Buffered progress _ ->
            Just (Html.Attributes.attribute "progress" (String.fromFloat progress))

        _ ->
            Nothing


bufferAttr : Config msg -> Maybe (Html.Attribute msg)
bufferAttr { variant } =
    case variant of
        Buffered _ buffer ->
            Just (Html.Attributes.attribute "buffer" (String.fromFloat buffer))

        _ ->
            Nothing


bufferingDotsElt : Html msg
bufferingDotsElt =
    Html.div [ class "mdc-linear-progress__buffering-dots" ] []


bufferElt : Html msg
bufferElt =
    Html.div [ class "mdc-linear-progress__buffer" ] []


primaryBarElt : Html msg
primaryBarElt =
    Html.div [ class "mdc-linear-progress__primary-bar" ] [ barInnerElt ]


secondaryBarElt : Html msg
secondaryBarElt =
    Html.div [ class "mdc-linear-progress__secondary-bar" ] [ barInnerElt ]


barInnerElt : Html msg
barInnerElt =
    Html.div [ class "mdc-linear-progress__bar-inner" ] []
