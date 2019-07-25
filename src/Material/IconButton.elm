module Material.IconButton exposing
    ( IconButtonConfig, iconButtonConfig
    , iconButton
    , iconToggleConfig, iconToggle
    , customIconButton
    )

{-| Icon buttons allow users to take actions, and make choices, with a single
tap.

  - [Demo: Icon buttons](https://aforemny.github.io/material-components-elm/#icon-buttons)
  - [Material Design Guidelines: Toggle buttons](https://material.io/go/design-buttons#toggle-button)
  - [MDC Web: Icon Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button#sass-mixins)


# Usage

If you are looking for a button that has an icon as well as text, refer to
[Button](Material-Button).


# Example

    import Material.IconButton
        exposing
            ( iconButton
            , iconButtonConfig
            )

    type Msg
        = IconButtonClicked

    main =
        iconButton
            { iconButtonConfig
                | onClick = Just IconButtonClicked
            }
            "favorite"


# Configuration

@docs IconButtonConfig, iconButtonConfig
@docs iconButton


# Variant: Icon Toggle

Icon toggles are a variant of icon buttons that signify a may signify a state
change when clicked.

    iconToggle { iconToggleConfig | on = True }
        { off = "favorite_border", on = "favorite" }

@docs iconToggleConfig, iconToggle


# State

To set the state of a icon toggle, set its on configuration field to a Bool
value. State only applies to the icon toggle variant, icon buttons ignore this
configuration field.

    iconToggle { iconToggleConfig | off = True }
        { off = "favorite_border", on = "favorite" }


# Disabled

To disable a icon button, set its disabled configuration field to True.
Disabled icon buttons cannot be interacted with and have no visual interaction
effect.

    iconButton { iconButtonConfig | disabled = True } "favorite"


# Label

To set the `arial-label` attribute of a icon button, set its label
configuration field to a String.

    iconButton { iconButtonConfig | label = "Add to favorites" } "favorite"


# Variant: Custom icon button

@docs customIconButton

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


{-| Icon button configuration
-}
type alias IconButtonConfig msg =
    { on : Bool
    , disabled : Bool
    , label : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default icon button configuration
-}
iconButtonConfig : IconButtonConfig msg
iconButtonConfig =
    { on = False
    , disabled = False
    , label = Nothing
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Icon button variant
-}
iconButton : IconButtonConfig msg -> String -> Html msg
iconButton config iconName =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , materialIconsCs
            , tabIndexAttr
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        [ text iconName ]


{-| TODO
-}
customIconButton : IconButtonConfig msg -> List (Html msg) -> Html msg
customIconButton config nodes =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , tabIndexAttr
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


{-| Default icon toggle configuration
-}
iconToggleConfig : IconButtonConfig msg
iconToggleConfig =
    iconButtonConfig


{-| Icon toggle variant
-}
iconToggle : IconButtonConfig msg -> { on : String, off : String } -> Html msg
iconToggle config { on, off } =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , onAttr config
            , ariaHiddenAttr
            , ariaPressedAttr config
            , ariaLabelAttr config
            , tabIndexAttr
            , clickHandler config
            , disabledAttr config
            ]
            ++ config.additionalAttributes
        )
        [ Html.i (List.filterMap identity [ materialIconsCs, onIconCs ]) [ text on ]
        , Html.i (List.filterMap identity [ materialIconsCs, iconCs ]) [ text off ]
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-icon-button")


onAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
onAttr { on } =
    if on then
        Just (Html.Attributes.attribute "data-on" "")

    else
        Nothing


materialIconsCs : Maybe (Html.Attribute msg)
materialIconsCs =
    Just (class "material-icons")


iconCs : Maybe (Html.Attribute msg)
iconCs =
    Just (class "mdc-icon-button__icon")


onIconCs : Maybe (Html.Attribute msg)
onIconCs =
    Just (class "mdc-icon-button__icon mdc-icon-button__icon--on")


tabIndexAttr : Maybe (Html.Attribute msg)
tabIndexAttr =
    Just (Html.Attributes.tabindex 0)


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")


ariaPressedAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
ariaPressedAttr { on } =
    Just
        (Html.Attributes.attribute "aria-pressed"
            (if on then
                "true"

             else
                "false"
            )
        )


ariaLabelAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
ariaLabelAttr { label } =
    Maybe.map (Html.Attributes.attribute "aria-label") label


clickHandler : IconButtonConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map Html.Events.onClick config.onClick


disabledAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    Just (Html.Attributes.disabled disabled)
