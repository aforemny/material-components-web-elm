module Material.FormField exposing
    ( Config, config
    , setOnClick
    , setLabel, setAlignEnd
    , setFor
    , setAttributes
    , formField
    )

{-| FormField aligns a form field (for example, a checkbox) with
its label and makes it RTL-aware. It also activates a ripple effect upon
interacting with the label.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Form Field](#form-field)
  - [Label Position](#label-position)


# Resources

  - [Demo: Checkbox](https://aforemny.github.io/material-components-web-elm/#checkbox)
  - [MDC Web: Form Field](https://github.com/material-components/material-components-web/tree/master/packages/mdc-form-field)


# Basic Usage

    import Material.Checkbox as Checkbox
    import Material.FormField as FormField

    main =
        FormField.formField
            (FormField.config
                |> FormField.setLabel (Just "My checkbox")
            )
            [ Checkbox.checkbox Checkbox.config ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setLabel, setAlignEnd
@docs setFor
@docs setAttributes


# Form Field

@docs formField


# Label Position

If you want to position the label after the form field's control, set its
`setAlignEnd` configuration option to `True`.

    FormField.formField
        (FormField.config |> FormField.setAlignEnd True)
        [ Checkbox.checkbox Checkbox.config ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


{-| Configuration of a form field
-}
type Config msg
    = Config
        { label : Maybe String
        , for : Maybe String
        , alignEnd : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        }


{-| Specify a form field's label
-}
setLabel : Maybe String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify a form field label's HTML5 for attribute
-}
setFor : Maybe String -> Config msg -> Config msg
setFor for (Config config_) =
    Config { config_ | for = for }


{-| Specify whether the form field's label is positioned after its control

This is usefile for, say, checkboxes.

-}
setAlignEnd : Bool -> Config msg -> Config msg
setAlignEnd alignEnd (Config config_) =
    Config { config_ | alignEnd = alignEnd }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user clicks on the label
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Default configuration of a form field
-}
config : Config msg
config =
    Config
        { label = Nothing
        , for = Nothing
        , alignEnd = False
        , additionalAttributes = []
        , onClick = Nothing
        }


{-| Form field view function
-}
formField : Config msg -> List (Html msg) -> Html msg
formField ((Config { additionalAttributes }) as config_) nodes =
    Html.node "mdc-form-field"
        (List.filterMap identity
            [ rootCs
            , alignEndCs config_
            ]
            ++ additionalAttributes
        )
        (nodes ++ [ labelElt config_ ])


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-form-field")


alignEndCs : Config msg -> Maybe (Html.Attribute msg)
alignEndCs (Config { alignEnd }) =
    if alignEnd then
        Just (class "mdc-form-field--align-end")

    else
        Nothing


forAttr : Config msg -> Maybe (Html.Attribute msg)
forAttr (Config { for }) =
    Maybe.map Html.Attributes.for for


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map Html.Events.onClick onClick


labelElt : Config msg -> Html msg
labelElt ((Config { label }) as config_) =
    Html.label
        (List.filterMap identity
            [ forAttr config_
            , clickHandler config_
            ]
        )
        [ text (Maybe.withDefault "" label) ]
