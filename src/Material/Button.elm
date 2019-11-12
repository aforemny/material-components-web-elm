module Material.Button exposing
    ( textButton, buttonConfig, ButtonConfig
    , outlinedButton, raisedButton, unelevatedButton
    )

{-| Buttons allow users to take actions, and make choices, with a single tap.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Text Button](#text-button)
  - [Button Variants](#button-variants)
  - [Button with Icons](#button-with-icons)
      - [Button with Leading Icon](#button-with-leading-icon)
      - [Button with Trailing Icon](#button-with-trailing-icon)
  - [Disabled Button](#disabled-button)
  - [Dense Button](#disabled-button)
  - [Link Button](#link-button)


# Resources

  - [Demo: Buttons](https://aforemny.github.io/material-components-web-elm/#buttons)
  - [Material Design Guidelines: Button](https://material.io/go/design-buttons)
  - [MDC Web: Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-button)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-button#sass-mixins)


# Basic Usage

    import Material.Button exposing (buttonConfig, textButton)

    type Msg
        = ButtonClicked

    main =
        textButton
            { buttonConfig | onClick = Just ButtonClicked }
            "Text"


# Text Button

@docs textButton, buttonConfig, ButtonConfig


# Button Variants

Buttons may appear in different variants. Use `textButton` or `outlinedButton`
if you want a button that is flush with the surface, and `raisedButton` or
`unelevatedButton` for a button that is contained.

@docs outlinedButton, raisedButton, unelevatedButton


# Button with Icons

To add an icon to a button, set its `icon` configuration field to the name of a
[Material Icon](https://material.io/icons). If you want the icon to be
positioned after the button's label, also set the `trailingIcon` configuration
field to `True`.


## Button with Leading Icon

    textButton
        { buttonConfig | icon = Just "favorite" }
        "Like"


## Button with Trailing Icon

    textButton
        { buttonConfig
            | icon = Just "favorite"
            , trailingIcon = True
        }
        "Like"


# Disabled Button

To disable a button, set its `disabled` configuration field to `True`. Disabled
buttons cannot be interacted with and have no visual interaction effect.

    textButton { buttonConfig | disabled = True } "Disabled"


# Dense Button

To make a button's text and container margins slightly smaller, set the `dense`
configuration field to `True`.

    textButton { buttonConfig | dense = True } "Dense"


# Link Button

Buttons may specify the `href` configuration field in which case the button essentially behaves like a HTML `a` element. You may specify the configuration field `target` as well.

    textButton { buttonConfig | href = Just "https://elm-lang.org" } "Visit"

Note that link buttons cannot be disabled.

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Encode as Encode


{-| Configuration of a button
-}
type alias ButtonConfig msg =
    { icon : Maybe String
    , trailingIcon : Bool
    , disabled : Bool
    , dense : Bool
    , href : Maybe String
    , target : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a button
-}
buttonConfig : ButtonConfig msg
buttonConfig =
    { icon = Nothing
    , trailingIcon = False
    , disabled = False
    , dense = False
    , href = Nothing
    , target = Nothing
    , additionalAttributes = []
    , onClick = Nothing
    }


type Variant
    = Text
    | Raised
    | Unelevated
    | Outlined


button : Variant -> ButtonConfig msg -> String -> Html msg
button variant config label =
    Html.node "mdc-button"
        (List.filterMap identity [ disabledProp config ])
        [ (if config.href /= Nothing then
            Html.a

           else
            Html.button
          )
            (List.filterMap identity
                [ rootCs
                , variantCs variant
                , denseCs config
                , disabledAttr config
                , tabIndexProp config
                , hrefAttr config
                , targetAttr config
                , clickHandler config
                ]
                ++ config.additionalAttributes
            )
            (List.filterMap identity
                [ leadingIconElt config
                , labelElt label
                , trailingIconElt config
                ]
            )
        ]


{-| Text button variant (flush without outline)
-}
textButton : ButtonConfig msg -> String -> Html msg
textButton config label =
    button Text config label


{-| Outlined button variant (flush with outline)
-}
outlinedButton : ButtonConfig msg -> String -> Html msg
outlinedButton config label =
    button Outlined config label


{-| Raised button variant (contained with elevation)
-}
raisedButton : ButtonConfig msg -> String -> Html msg
raisedButton config label =
    button Raised config label


{-| Unelevated button variant (contained without elevation)
-}
unelevatedButton : ButtonConfig msg -> String -> Html msg
unelevatedButton config label =
    button Unelevated config label


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-button")


disabledProp : ButtonConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


disabledAttr : ButtonConfig msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    Just (Html.Attributes.disabled disabled)


tabIndexProp : ButtonConfig msg -> Maybe (Html.Attribute msg)
tabIndexProp { disabled } =
    if disabled then
        Just (Html.Attributes.property "tabIndex" (Encode.int -1))

    else
        Just (Html.Attributes.property "tabIndex" (Encode.int 0))


hrefAttr : ButtonConfig msg -> Maybe (Html.Attribute msg)
hrefAttr { href } =
    Maybe.map Html.Attributes.href href


targetAttr : ButtonConfig msg -> Maybe (Html.Attribute msg)
targetAttr { href, target } =
    if href /= Nothing then
        Maybe.map Html.Attributes.target target

    else
        Nothing


clickHandler : ButtonConfig msg -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick


variantCs : Variant -> Maybe (Html.Attribute msg)
variantCs variant =
    case variant of
        Text ->
            Nothing

        Raised ->
            Just (class "mdc-button--raised")

        Unelevated ->
            Just (class "mdc-button--unelevated")

        Outlined ->
            Just (class "mdc-button--outlined")


denseCs : ButtonConfig msg -> Maybe (Html.Attribute msg)
denseCs { dense } =
    if dense then
        Just (class "mdc-button--dense")

    else
        Nothing


iconElt : ButtonConfig msg -> Maybe (Html msg)
iconElt { icon } =
    Maybe.map
        (\iconName ->
            Html.i
                [ class "mdc-button__icon material-icons"
                , Html.Attributes.attribute "aria-hidden" "true"
                ]
                [ text iconName ]
        )
        icon


leadingIconElt : ButtonConfig msg -> Maybe (Html msg)
leadingIconElt config =
    if not config.trailingIcon then
        iconElt config

    else
        Nothing


trailingIconElt : ButtonConfig msg -> Maybe (Html msg)
trailingIconElt config =
    if config.trailingIcon then
        iconElt config

    else
        Nothing


labelElt : String -> Maybe (Html msg)
labelElt label =
    Just (Html.span [ class "mdc-button__label" ] [ text label ])
