module Material.HelperText exposing (helperText, helperTextConfig, HelperTextConfig)

{-| Helper text gives context about a field’s input, such as how the input will
be used. It should be visible either persistently or only on focus.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Persistent helper text](#persisten-helper-text)


# Resources

  - [Demo: Text fields](https://aforemny.github.io/material-components-elm/#text-fields)
  - [Material Design Guidelines: Text Fields Layout](https://material.io/go/design-text-fields#text-fields-layout)
  - [MDC Web: Text Field Helper Text](https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield/helper-text)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield/helper-text#sass-mixins)


# Basic Usage

    import Material.HelperText exposing (helperText, helperTextConf)
    import Material.TextField exposing (textField, textFieldConf)

    main =
        Html.div
            [ textField { textFieldConf | label = "Your name" }
            , helperText helperTextConf "Please fill this"
            ]

The helper text is expected to be the direct sibling of the text field it belongs to.

@docs helperText, helperTextConfig, HelperTextConfig


# Persistent helper text

A text field's helper text may show unconditionally by setting its `persistent`
configuration field to `True`. By default a text field's helper text only shows
when the text field has focus.

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Configuration of a helper text
-}
type alias HelperTextConfig msg =
    { persistent : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a helper text
-}
helperTextConfig : HelperTextConfig msg
helperTextConfig =
    { persistent = False
    , additionalAttributes = []
    }


{-| Helper text view function
-}
helperText : HelperTextConfig msg -> String -> Html msg
helperText config string =
    Html.node "mdc-helper-text"
        (List.filterMap identity
            [ rootCs
            , persistentCs config
            , ariaHiddenAttr
            ]
            ++ config.additionalAttributes
        )
        [ text string ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-text-field-helper-text")


persistentCs : HelperTextConfig msg -> Maybe (Html.Attribute msg)
persistentCs config =
    if config.persistent then
        Just (class "mdc-text-field-helper-text--persistent")

    else
        Nothing


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")
