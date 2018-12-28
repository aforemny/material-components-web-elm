module Material.Button exposing (Config, Variant(..), button, buttonConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


type alias Config msg =
    { variant : Variant
    , icon : Maybe String
    , trailingIcon : Maybe String
    , disabled : Bool
    , dense : Bool
    , onClick : Maybe msg
    , additionalAttributes : List (Html.Attribute msg)
    }


buttonConfig : Config msg
buttonConfig =
    { variant = Text
    , icon = Nothing
    , trailingIcon = Nothing
    , disabled = False
    , dense = False
    , onClick = Nothing
    , additionalAttributes = []
    }


type Variant
    = Text
    | Raised
    | Unelevated
    | Outlined


button : Config msg -> String -> Html msg
button config label =
    Html.node "mdc-button"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            , denseCs config
            , disabledAttr config
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity
            [ iconElt config
            , labelElt label
            , trailingIconElt config
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-button")


disabledAttr : Config msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    Just (Html.Attributes.disabled disabled)


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick


variantCs : Config msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    case variant of
        Text ->
            Nothing

        Raised ->
            Just (class "mdc-button--raised")

        Unelevated ->
            Just (class "mdc-button--unelevated")

        Outlined ->
            Just (class "mdc-button--outlined")


denseCs : Config msg -> Maybe (Html.Attribute msg)
denseCs { dense } =
    if dense then
        Just (class "mdc-button--dense")

    else
        Nothing


iconElt : Config msg -> Maybe (Html msg)
iconElt { icon } =
    icon
        |> Maybe.map
            (\iconName ->
                Html.i
                    [ class "mdc-button__icon"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    ]
                    [ text iconName ]
            )


trailingIconElt : Config msg -> Maybe (Html msg)
trailingIconElt { trailingIcon } =
    trailingIcon
        |> Maybe.map
            (\iconName ->
                Html.i
                    [ class "mdc-button__icon"
                    , Html.Attributes.attribute "aria-hidden" "true"
                    ]
                    [ text iconName ]
            )


labelElt : String -> Maybe (Html msg)
labelElt label =
    Just (Html.span [ class "mdc-button__label" ] [ text label ])
