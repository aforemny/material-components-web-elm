module Material.IconToggle exposing
    ( Config, config
    , setOnChange
    , setOn
    , setDisabled
    , setLabel
    , setAttributes
    , iconToggle
    )

{-| Icon toggles allow users to take actions and make choices with a single
tap.


# Table of Contents

  - [Resources](#resources)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Basic Usage](#basic-usage)
  - [Icon Toggle](#icon-toggle)
  - [On Icon Toggle](#on-icon-toggle)
  - [Disabled Icon Toggle](#disabled-icon-toggle)
  - [Labeled Icon Toggle](#labeled-icon-toggle)
  - [Focus an Icon Toggle](#focus-an-icon-toggle)


# Resources

  - [Demo: Icon buttons](https://aforemny.github.io/material-components-web-elm/#icon-button)
  - [Material Design Guidelines: Toggle buttons](https://material.io/go/design-buttons#toggle-button)
  - [MDC Web: Icon Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button#sass-mixins)


# Basic Usage

    import Material.IconToggle as IconToggle

    type Msg
        = Clicked

    main =
        IconToggle.iconToggle
            (IconToggle.config
                |> IconToggle.setOn True
                |> IconToggle.setOnChange Clicked
            )
            { offIcon = "favorite_outlined"
            , onIcon = "favorite"
            }


# Configuration

@docs Config, config


## Configuration Options

@docs setOnChange
@docs setOn
@docs setDisabled
@docs setLabel
@docs setAttributes


# Icon Toggle

Icon toggles are a variant of [icon buttons](Material-IconButton) that change
the icon when their state changes.

    IconToggle.iconToggle
        (IconToggle.config |> IconToggle.setOn True)
        { offIcon = "favorite_border"
        , onIcon = "favorite"
        }

@docs iconToggle


# On Icon Toggle

To set an icon toggle to its on state, set its `setOn` configuration option to
`True`.

    IconToggle.iconToggle
        (IconToggle.config |> IconToggle.setOn True)
        { offIcon = "favorite_border"
        , onIcon = "favorite"
        }


# Disabled Icon Toggle

To disable an icon toggle, set its `setDisabled` configuration option to
`True`.
Disabled icon buttons cannot be interacted with and have no visual interaction
effect.

    IconToggle.iconToggle
        (IconToggle.config |> IconToggle.setDisabled True)
        { offIcon = "favorite_border"
        , onIcon = "favorite"
        }


# Labeled Icon Toggle

To set the HTML5 `arial-label` attribute of an icon toggle, use its `setLabel`
configuration option.

    IconToggle.iconToggle
        (IconToggle.config
            |> IconToggle.setLabel (Just "Add to favorites")
        )
        { offIcon = "favorite_border"
        , onIcon = "favorite"
        }


# Focus an Icon Toggle

You may programatically focus an icon toggle by assigning an id attribute to it
and use `Browser.Dom.focus`.

    IconToggle.iconToggle
        (IconToggle.config
            |> IconToggle.setAttributes
                [ Html.Attributes.id "my-icon-toggle" ]
        )
        { offIcon = "favorite_border"
        , onIcon = "favorite"
        }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Icon toggle configuration
-}
type Config msg
    = Config
        { on : Bool
        , disabled : Bool
        , label : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        }


{-| Default icon toggle configuration
-}
config : Config msg
config =
    Config
        { on = False
        , disabled = False
        , label = Nothing
        , additionalAttributes = []
        , onChange = Nothing
        }


{-| Specify whether an icon toggle is on
-}
setOn : Bool -> Config msg -> Config msg
setOn on (Config config_) =
    Config { config_ | on = on }


{-| Specify whether an icon toggle is disabled

Disabled icon buttons cannot be interacted with and have no visual interaction
effect.

-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Specify the HTML5 aria-label attribute of an icon toggle
-}
setLabel : Maybe String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user changes the icon toggle
-}
setOnChange : msg -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Icon toggle view function
-}
iconToggle : Config msg -> { onIcon : String, offIcon : String } -> Html msg
iconToggle config_ icons =
    Html.node "mdc-icon-button"
        [ displayAttr
        , onProp config_
        ]
        [ iconToggleElt config_ icons ]
 

displayAttr : Html.Attribute msg
displayAttr =
    Html.Attributes.style "display" "contents"


onProp : Config msg -> Html.Attribute msg
onProp (Config { on }) =
    Html.Attributes.property "on" (Encode.bool on)


iconToggleElt : Config msg -> { onIcon : String, offIcon : String } -> Html msg
iconToggleElt ((Config { additionalAttributes }) as config_) { onIcon, offIcon } =
    Html.button
        (List.filterMap identity
            [ iconButtonCs
            , tabIndexProp
            , ariaHiddenAttr
            , ariaPressedAttr config_
            , ariaLabelAttr config_
            , changeHandler config_
            , disabledAttr config_
            ]
            ++ additionalAttributes
        )
        [ Html.i (List.filterMap identity [ materialIconsCs, onIconCs ]) [ text onIcon ]
        , Html.i (List.filterMap identity [ materialIconsCs, iconCs ]) [ text offIcon ]
        ]


iconButtonCs : Maybe (Html.Attribute msg)
iconButtonCs =
    Just (class "mdc-icon-button")


materialIconsCs : Maybe (Html.Attribute msg)
materialIconsCs =
    Just (class "material-icons")


iconCs : Maybe (Html.Attribute msg)
iconCs =
    Just (class "mdc-icon-button__icon")


onIconCs : Maybe (Html.Attribute msg)
onIconCs =
    Just (class "mdc-icon-button__icon mdc-icon-button__icon--on")


tabIndexProp : Maybe (Html.Attribute msg)
tabIndexProp =
    Just (Html.Attributes.tabindex 0)


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")


ariaPressedAttr : Config msg -> Maybe (Html.Attribute msg)
ariaPressedAttr (Config { on }) =
    Just
        (Html.Attributes.attribute "aria-pressed"
            (if on then
                "true"

             else
                "false"
            )
        )


ariaLabelAttr : Config msg -> Maybe (Html.Attribute msg)
ariaLabelAttr (Config { label }) =
    Maybe.map (Html.Attributes.attribute "aria-label") label


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { onChange }) =
    Maybe.map (Html.Events.on "MDCIconButtonToggle:change" << Decode.succeed)
        onChange


disabledAttr : Config msg -> Maybe (Html.Attribute msg)
disabledAttr (Config { disabled }) =
    Just (Html.Attributes.disabled disabled)