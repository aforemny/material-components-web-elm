module Material.Button exposing (Variant(..), button, buttonConfig)

import Html exposing (Html, span, text)
import Html.Attributes exposing (attribute, class)


type alias Config msg =
    { variant : Variant
    , label : String
    , icon : Maybe String
    , trailingIcon : Maybe String
    , disabled : Bool
    , dense : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


buttonConfig : Config msg
buttonConfig =
    { variant = Default
    , label = "button"
    , icon = Nothing
    , trailingIcon = Nothing
    , disabled = False
    , dense = False
    , additionalAttributes = []
    }


type Variant
    = Default
    | Raised
    | Unelevated
    | Outlined


button : Config msg -> Html msg
button config =
    let
        variantClass =
            case config.variant of
                Default ->
                    Nothing

                Raised ->
                    Just (class "mdc-button--raised")

                Unelevated ->
                    Just (class "mdc-button--unelevated")

                Outlined ->
                    Just (class "mdc-button--outlined")

        denseClass =
            if config.dense then
                Just (class "mdc-button--dense")

            else
                Nothing

        icon =
            config.icon
                |> Maybe.map
                    (\iconName ->
                        Html.i
                            [ class "mdc-button__icon"
                            , attribute "aria-hidden" "true"
                            ]
                            [ text iconName ]
                    )

        trailingIcon =
            config.trailingIcon
                |> Maybe.map
                    (\iconName ->
                        Html.i
                            [ class "mdc-button__icon"
                            , attribute "aria-hidden" "true"
                            ]
                            [ text iconName ]
                    )

        label =
            span [ class "mdc-button__label" ] [ text config.label ]
    in
    Html.node "mdc-button"
        (List.filterMap identity
            [ Just (class "mdc-button")
            , variantClass
            , Just (Html.Attributes.disabled config.disabled)
            , denseClass
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity
            [ icon
            , Just label
            , trailingIcon
            ]
        )
