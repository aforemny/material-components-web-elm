module Material.IconToggle exposing (iconToggle, iconToggleConfig, IconToggleConfig)

{-| Icon toggles allow users to take actions, and make choices, with a single
tap.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Icon Toggle](#icon-toggle)
  - [On Icon Toggle](#on-icon-toggle)
  - [Disabled Icon Toggle](#disabled-icon-toggle)
  - [Labeled Icon Toggle](#labeled-icon-toggle)


# Resources

  - [Demo: Icon buttons](https://aforemny.github.io/material-components-web-elm/#icon-buttons)
  - [Material Design Guidelines: Toggle buttons](https://material.io/go/design-buttons#toggle-button)
  - [MDC Web: Icon Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button#sass-mixins)


# Basic Usage

If you are looking for a button that has an icon as well as text, refer to
[Button](Material-Button).

    import Material.IconToggle
        exposing
            ( iconToggle
            , iconToggleConfig
            )

    type Msg
        = IconToggleClicked

    main =
        iconToggle
            { iconToggleConfig
                | on = True
                , onClick = Just IconToggleClicked
            }
            { offIcon = "favorite_outlined"
            , onIcon = "favorite"
            }


# Icon Toggle

Icon toggles are a variant of icon buttons that change their state when
clicked.

    iconToggle { iconToggleConfig | on = True }
        { offIcon = "favorite_border", onIcon = "favorite" }

@docs iconToggle, iconToggleConfig, IconToggleConfig


# On Icon Toggle

To set the state of a icon toggle, set its on configuration field to a Bool
value. State only applies to the icon toggle variant, icon buttons ignore this
configuration field.

    iconToggle { iconToggleConfig | on = True }
        { offIcon = "favorite_border", onIcon = "favorite" }


# Disabled Icon Toggle

To disable a icon toggle, set its disabled configuration field to True.
Disabled icon buttons cannot be interacted with and have no visual interaction
effect.

    iconToggle { iconButtonConfig | disabled = True }
        { offIcon = "favorite_border", onIcon = "favorite" }


# Labeled Icon Toggle

To set the `arial-label` attribute of a icon toggle, set its label
configuration field to a String.

    iconToggle
        { iconButtonConfig | label = "Add to favorites" }
        { offIcon = "favorite_border", onIcon = "favorite" }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


{-| Icon toggle configuration
-}
type alias IconToggleConfig msg =
    { on : Bool
    , disabled : Bool
    , label : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default icon toggle configuration
-}
iconToggleConfig : IconToggleConfig msg
iconToggleConfig =
    { on = False
    , disabled = False
    , label = Nothing
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Icon toggle view function
-}
iconToggle : IconToggleConfig msg -> { onIcon : String, offIcon : String } -> Html msg
iconToggle config { onIcon, offIcon } =
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
        [ Html.i (List.filterMap identity [ materialIconsCs, onIconCs ]) [ text onIcon ]
        , Html.i (List.filterMap identity [ materialIconsCs, iconCs ]) [ text offIcon ]
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-icon-button")


onAttr : IconToggleConfig msg -> Maybe (Html.Attribute msg)
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


ariaPressedAttr : IconToggleConfig msg -> Maybe (Html.Attribute msg)
ariaPressedAttr { on } =
    Just
        (Html.Attributes.attribute "aria-pressed"
            (if on then
                "true"

             else
                "false"
            )
        )


ariaLabelAttr : IconToggleConfig msg -> Maybe (Html.Attribute msg)
ariaLabelAttr { label } =
    Maybe.map (Html.Attributes.attribute "aria-label") label


clickHandler : IconToggleConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map Html.Events.onClick config.onClick


disabledAttr : IconToggleConfig msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    Just (Html.Attributes.disabled disabled)
