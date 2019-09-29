module Material.FormField exposing (formField, formFieldConfig, FormFieldConfig)

{-| FormField aligns a form field (for example, a checkbox) with
its label and makes it RTL-aware. It also activates a ripple effect upon
interacting with the label.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Form Field](#form-field)
  - [Label Position](#label-position)


# Resources

  - [Demo: Checkbox](https://aforemny.github.io/material-components-web-elm/#checkboxes)
  - [MDC Web: Form Field](https://github.com/material-components/material-components-web/tree/master/packages/mdc-form-field)


# Basic Usage

    import Material.Checkbox
        exposing
            ( checkbox
            , checkboxConfig
            )
    import Material.FormField
        exposing
            ( formField
            , formFieldConfig
            )

    main =
        formField { formFieldConfig | label = "My checkbox" }
            [ checkbox checkboxConfig ]


# Form Field

@docs formField, formFieldConfig, FormFieldConfig


# Label Position

If you want to position the label after the form field (ie. checkbox), set its
alignEnd configuration field to True:

    formField { label = "My checkbox", alignEnd = True } [ checkbox checkboxConfig ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


{-| Configuration of a form field
-}
type alias FormFieldConfig msg =
    { label : String
    , for : Maybe String
    , alignEnd : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a form field
-}
formFieldConfig : FormFieldConfig msg
formFieldConfig =
    { label = ""
    , for = Nothing
    , alignEnd = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Form field view function
-}
formField : FormFieldConfig msg -> List (Html msg) -> Html msg
formField config nodes =
    Html.node "mdc-form-field"
        (List.filterMap identity [ rootCs, alignEndCs config ]
            ++ config.additionalAttributes
        )
        (nodes ++ [ labelElt config ])


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-form-field")


alignEndCs : FormFieldConfig msg -> Maybe (Html.Attribute msg)
alignEndCs { alignEnd } =
    if alignEnd then
        Just (class "mdc-form-field--align-end")

    else
        Nothing


forAttr : FormFieldConfig msg -> Maybe (Html.Attribute msg)
forAttr { for } =
    Maybe.map Html.Attributes.for for


clickHandler : FormFieldConfig msg -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick


labelElt : FormFieldConfig msg -> Html msg
labelElt ({ label } as config) =
    Html.label (List.filterMap identity [ forAttr config, clickHandler config ])
        [ text label ]
