module Material.Button exposing
    ( Config, config
    , setOnClick
    , setIcon, setTrailingIcon
    , setDisabled
    , setDense
    , setHref, setTarget
    , setAdditionalAttributes
    , text, outlined, raised, unelevated
    )

{-| Buttons allow users to take actions, and make choices, with a single tap.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
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

    import Material.Button as Button

    type Msg
        = Clicked

    main =
        Button.text
            (Button.config
                |> Button.setOnClick Clicked
            )
            "Text"


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setIcon, setTrailingIcon
@docs setDisabled
@docs setDense
@docs setHref, setTarget
@docs setAdditionalAttributes


# Button Variants

Buttons may appear in different variants. Use eatext`or`outlined`if you want
a button that is flush with the surface, and`raised`or`unelevated\` for a
button that is contained.

@docs text, outlined, raised, unelevated


# Button with Icons

To add an icon to a button, use its `setIcon` configuration option to set the
name of a [Material Icon](https://material.io/icons). If you want the icon to
be positioned after the button's label, also use the `trailingIcon`
configuration option.


## Button with Leading Icon

    Button.text
        (Button.config
            |> Button.setIcon "favorite"
        )
        "Like"


## Button with Trailing Icon

    Button.text
        (Button.config
            |> Button.setIcon "favorite"
            |> Button.setTrailingIcon True
        )
        "Like"


# Disabled Button

To disable a button, use its `setDisabled` configuration option. Disabled
buttons cannot be interacted with and have no visual interaction effect.

    Button.text
        (Button.config
            |> Button.disabled
        )
        "Disabled"


# Dense Button

To make a button's text and container margins slightly smaller, use its `setDense`
configuration option.

    Button.text
        (Button.config
            |> Button.dense
        )
        "Dense"


# Link Button

To make a button essentially behave like a HTML anchor element, use its
`setHref` configution option. You may use its `setTarget` configuration option
to specify a target.

    Button.text
        (Button.config
            |> Button.setHref "https://elm-lang.org"
        )
        "Visit"

Note that link buttons cannot be disabled.

-}

import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events
import Json.Encode as Encode
import Material.Button.Internal exposing (Config(..))


{-| Configuration of a button
-}
type alias Config msg =
    Material.Button.Internal.Config msg


{-| Default configuration of a button
-}
config : Config msg
config =
    Config
        { icon = Nothing
        , trailingIcon = False
        , disabled = False
        , dense = False
        , href = Nothing
        , target = Nothing
        , additionalAttributes = []
        , onClick = Nothing
        }


{-| Set the icon of a button
-}
setIcon : String -> Config msg -> Config msg
setIcon icon (Config config_) =
    Config { config_ | icon = Just icon }


{-| Specify whether a button's icon is a _trailing icon_, ie. whether it is
displayed at the end
-}
setTrailingIcon : Config msg -> Config msg
setTrailingIcon (Config config_) =
    Config { config_ | trailingIcon = True }


{-| Make a button disabled
-}
setDisabled : Config msg -> Config msg
setDisabled (Config config_) =
    Config { config_ | disabled = True }


{-| Make a button dense
-}
setDense : Config msg -> Config msg
setDense (Config config_) =
    Config { config_ | dense = True }


{-| Make a button a link button
-}
setHref : String -> Config msg -> Config msg
setHref href (Config config_) =
    Config { config_ | href = Just href }


{-| Specify the target for a link button
-}
setTarget : String -> Config msg -> Config msg
setTarget target (Config config_) =
    Config { config_ | target = Just target }


{-| Specify additional attributes
-}
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify message when the user clicks a button
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


type Variant
    = Text
    | Raised
    | Unelevated
    | Outlined


button : Variant -> Config msg -> String -> Html msg
button variant ((Config { additionalAttributes, href }) as config_) label =
    Html.node "mdc-button"
        (List.filterMap identity [ disabledProp config_ ])
        [ (if href /= Nothing then
            Html.a

           else
            Html.button
          )
            (List.filterMap identity
                [ rootCs
                , variantCs variant
                , denseCs config_
                , disabledAttr config_
                , tabIndexProp config_
                , hrefAttr config_
                , targetAttr config_
                , clickHandler config_
                ]
                ++ additionalAttributes
            )
            (List.filterMap identity
                [ leadingIconElt config_
                , labelElt label
                , trailingIconElt config_
                ]
            )
        ]


{-| Text button variant (flush without outline)
-}
text : Config msg -> String -> Html msg
text config_ label =
    button Text config_ label


{-| Outlined button variant (flush with outline)
-}
outlined : Config msg -> String -> Html msg
outlined config_ label =
    button Outlined config_ label


{-| Raised button variant (contained with elevation)
-}
raised : Config msg -> String -> Html msg
raised config_ label =
    button Raised config_ label


{-| Unelevated button variant (contained without elevation)
-}
unelevated : Config msg -> String -> Html msg
unelevated config_ label =
    button Unelevated config_ label


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-button")


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


disabledAttr : Config msg -> Maybe (Html.Attribute msg)
disabledAttr (Config { disabled }) =
    Just (Html.Attributes.disabled disabled)


tabIndexProp : Config msg -> Maybe (Html.Attribute msg)
tabIndexProp (Config { disabled }) =
    if disabled then
        Just (Html.Attributes.property "tabIndex" (Encode.int -1))

    else
        Just (Html.Attributes.property "tabIndex" (Encode.int 0))


hrefAttr : Config msg -> Maybe (Html.Attribute msg)
hrefAttr (Config { href }) =
    Maybe.map Html.Attributes.href href


targetAttr : Config msg -> Maybe (Html.Attribute msg)
targetAttr (Config { href, target }) =
    if href /= Nothing then
        Maybe.map Html.Attributes.target target

    else
        Nothing


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
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


denseCs : Config msg -> Maybe (Html.Attribute msg)
denseCs (Config { dense }) =
    if dense then
        Just (class "mdc-button--dense")

    else
        Nothing


iconElt : Config msg -> Maybe (Html msg)
iconElt (Config { icon }) =
    Maybe.map
        (\iconName ->
            Html.i
                [ class "mdc-button__icon material-icons"
                , Html.Attributes.attribute "aria-hidden" "true"
                ]
                [ Html.text iconName ]
        )
        icon


leadingIconElt : Config msg -> Maybe (Html msg)
leadingIconElt ((Config { trailingIcon }) as config_) =
    if not trailingIcon then
        iconElt config_

    else
        Nothing


trailingIconElt : Config msg -> Maybe (Html msg)
trailingIconElt ((Config { trailingIcon }) as config_) =
    if trailingIcon then
        iconElt config_

    else
        Nothing


labelElt : String -> Maybe (Html msg)
labelElt label =
    Just (Html.span [ class "mdc-button__label" ] [ Html.text label ])
