module Material.HelperText exposing
    ( Config, config
    , setPersistent
    , setAdditionalAttributes
    , helperText
    , helperLine, characterCounter
    )

{-| Helper text gives context about a field’s input, such as how the input will
be used. It should be visible either persistently or only on focus.


# Table of Contents

  - [Resources](#resources)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Basic Usage](#basic-usage)
  - [Helper Text](#helper-text)
  - [Persistent Helper Text](#persisten-helper-text)
  - [Helper Text with Character Counter](#helper-text-with-character-counter)


# Resources

  - [Demo: Text fields](https://aforemny.github.io/material-components-web-elm/#text-field)
  - [Material Design Guidelines: Text Fields Layout](https://material.io/go/design-text-fields#text-fields-layout)
  - [MDC Web: Text Field Helper Text](https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield/helper-text)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield/helper-text#sass-mixins)


# Basic Usage

    import Material.HelperText as HelperText
    import Material.TextField as TextField

    main =
        Html.div
            [ TextField.textField
                (TextField.config
                    |> TextField.setLabel "Your name"
                )
            , HelperText.helperText HelperText.config "Please fill this"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setPersistent
@docs setAdditionalAttributes


# Helper Text

The helper line is expected to be a direct sibling of the text field it belongs
to and the helper text is expected to be a direct child of the helper text
line.

@docs helperText


# Persistent Helper Text

A text field's helper text may show unconditionally by using its
`setPersistent` configuration option. By default a text field's helper text
only shows when the text field has focus.


# Helper Text with Character Counter

To have a text field or text area display a character counter, set specify its
`setMaxLength` configuration option, and also add a `characterCounter` as a
child of `helperLine`.

    [ textField
        { textFieldConfig
            | maxLength = Just 18
        }
    , helperLine [] [ characterCounter [] ]
    ]

@docs helperLine, characterCounter

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Configuration of a helper text
-}
type Config msg
    = Config
        { persistent : Bool
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default configuration of a helper text
-}
config : Config msg
config =
    Config
        { persistent = False
        , additionalAttributes = []
        }


{-| Make a helper text persistent
-}
setPersistent : Bool -> Config msg -> Config msg
setPersistent persistent (Config config_) =
    Config { config_ | persistent = persistent }


{-| Specify additional attributes
-}
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Helper text view function

The helper text is expected to be a direct child of the text line.

-}
helperText : Config msg -> String -> Html msg
helperText ((Config { additionalAttributes }) as config_) string =
    Html.div
        (List.filterMap identity
            [ helperTextCs
            , persistentCs config_
            , ariaHiddenAttr
            ]
            ++ additionalAttributes
        )
        [ text string ]


{-| Helper text line view function

The text line is expected to be the wrapping element of the helper text. It is
expected to be a direct sibling of the text field that it belongs to.

-}
helperLine : List (Html.Attribute msg) -> List (Html msg) -> Html msg
helperLine additionalAttributes nodes =
    Html.div (helperLineCs :: additionalAttributes) nodes


helperTextCs : Maybe (Html.Attribute msg)
helperTextCs =
    Just (class "mdc-text-field-helper-text")


helperLineCs : Html.Attribute msg
helperLineCs =
    class "mdc-text-field-helper-line"


persistentCs : Config msg -> Maybe (Html.Attribute msg)
persistentCs (Config config_) =
    if config_.persistent then
        Just (class "mdc-text-field-helper-text--persistent")

    else
        Nothing


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")


{-| Character counter view function
-}
characterCounter : List (Html.Attribute msg) -> Html msg
characterCounter additionalAttributes =
    Html.div (characterCounterCs :: additionalAttributes) []


characterCounterCs : Html.Attribute msg
characterCounterCs =
    class "mdc-text-field-character-counter"
