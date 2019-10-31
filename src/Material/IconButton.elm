module Material.IconButton exposing
    ( iconButton, iconButtonConfig, IconButtonConfig
    , customIconButton
    )

{-| Icon buttons allow users to take actions, and make choices, with a single
tap.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Icon Button](#icon-button)
  - [Disabled Icon Button](#disabled-icon-button)
  - [Labeled Icon Button](#labeled-icon-button)


# Resources

  - [Demo: Icon buttons](https://aforemny.github.io/material-components-web-elm/#icon-buttons)
  - [Material Design Guidelines: Toggle buttons](https://material.io/go/design-buttons#toggle-button)
  - [MDC Web: Icon Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button#sass-mixins)


# Basic Usage

If you are looking for a button that has an icon as well as text, refer to
[Button](Material-Button).

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


# Icon Button

@docs iconButton, iconButtonConfig, IconButtonConfig


# Disabled Icon Button

To disable a icon button, set its disabled configuration field to True.
Disabled icon buttons cannot be interacted with and have no visual interaction
effect.

    iconButton
        { iconButtonConfig | disabled = True }
        "favorite"


# Labeled Icon Button

To set the `arial-label` attribute of a icon button, set its label
configuration field to a String.

    iconButton
        { iconButtonConfig | label = "Add to favorites" }
        "favorite"


# Variant: Custom Icon Button

@docs customIconButton

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


{-| Icon button configuration
-}
type alias IconButtonConfig msg =
    { disabled : Bool
    , label : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default icon button configuration
-}
iconButtonConfig : IconButtonConfig msg
iconButtonConfig =
    { disabled = False
    , label = Nothing
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Icon button view function
-}
iconButton : IconButtonConfig msg -> String -> Html msg
iconButton config iconName =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , materialIconsCs
            , tabIndexProp
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
            , tabIndexProp
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-icon-button")


materialIconsCs : Maybe (Html.Attribute msg)
materialIconsCs =
    Just (class "material-icons")


iconCs : Maybe (Html.Attribute msg)
iconCs =
    Just (class "mdc-icon-button__icon")


tabIndexProp : Maybe (Html.Attribute msg)
tabIndexProp =
    Just (Html.Attributes.tabindex 0)


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")


ariaLabelAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
ariaLabelAttr { label } =
    Maybe.map (Html.Attributes.attribute "aria-label") label


clickHandler : IconButtonConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map Html.Events.onClick config.onClick
