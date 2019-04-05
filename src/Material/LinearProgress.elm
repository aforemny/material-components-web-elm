module Material.LinearProgress exposing
    ( Config
    , bufferedLinearProgress
    , determinateLinearProgress
    , indeterminateLinearProgress
    , linearProgressConfig
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)


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
            , displayCss
            , roleAttr
            , variantCs config
            , determinateAttr config
            , progressAttr config
            , bufferAttr config
            , reverseAttr config
            , closedAttr config
            ]
            ++ config.additionalAttributes
        )
        [ bufferingDotsElt
        , bufferElt
        , primaryBarElt
        , secondaryBarElt
        ]


indeterminateLinearProgress : Config msg -> Html msg
indeterminateLinearProgress config =
    linearProgress { config | variant = Indeterminate }


determinateLinearProgress : Config msg -> { progress : Float } -> Html msg
determinateLinearProgress config { progress } =
    linearProgress { config | variant = Determinate progress }


bufferedLinearProgress : Config msg -> { progress : Float, buffered : Float } -> Html msg
bufferedLinearProgress config { progress, buffered } =
    linearProgress { config | variant = Buffered progress buffered }


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-linear-progress")


displayCss : Maybe (Html.Attribute msg)
displayCss =
    Just (style "display" "block")


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


determinateAttr : Config msg -> Maybe (Html.Attribute msg)
determinateAttr { variant } =
    if variant /= Indeterminate then
        Just (Html.Attributes.attribute "determinate" "")

    else
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


reverseAttr : Config msg -> Maybe (Html.Attribute msg)
reverseAttr { reverse } =
    if reverse then
        Just (Html.Attributes.attribute "reverse" "")

    else
        Nothing


closedAttr : Config msg -> Maybe (Html.Attribute msg)
closedAttr { closed } =
    if closed then
        Just (Html.Attributes.attribute "closed" "")

    else
        Nothing


bufferingDotsElt : Html msg
bufferingDotsElt =
    Html.div [ class "mdc-linear-progress__buffering-dots" ] []


bufferElt : Html msg
bufferElt =
    Html.div [ class "mdc-linear-progress__buffer" ] []


primaryBarElt : Html msg
primaryBarElt =
    Html.div [ class "mdc-linear-progress__bar mdc-linear-progress__primary-bar" ]
        [ barInnerElt ]


secondaryBarElt : Html msg
secondaryBarElt =
    Html.div [ class "mdc-linear-progress__bar mdc-linear-progress__secondary-bar" ]
        [ barInnerElt ]


barInnerElt : Html msg
barInnerElt =
    Html.div [ class "mdc-linear-progress__bar-inner" ] []
