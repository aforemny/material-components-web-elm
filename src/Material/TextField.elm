module Material.TextField exposing (Config, textField, textFieldConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { label : String
    , fullwidth : Bool
    , textarea : Bool
    , rows : Maybe Int
    , cols : Maybe Int
    , outlined : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


textFieldConfig : Config msg
textFieldConfig =
    { label = ""
    , fullwidth = False
    , textarea = False
    , rows = Nothing
    , cols = Nothing
    , outlined = False
    , disabled = False
    , additionalAttributes = []
    }


textField : Config msg -> Html msg
textField config =
    Html.node "mdc-text-field"
        (List.filterMap identity
            [ rootCs
            , fullwidthCs config
            , textareaCs config
            ]
            ++ config.additionalAttributes
        )
        (if config.fullwidth then
            if config.textarea then
                [ inputElt config
                , notchedOutlineElt config
                ]

            else if config.outlined then
                [ inputElt config
                , notchedOutlineElt config
                ]

            else
                [ inputElt config
                , lineRippleElt
                ]

         else if config.textarea then
            [ inputElt config
            , notchedOutlineElt config
            ]

         else if config.outlined then
            [ inputElt config
            , notchedOutlineElt config
            ]

         else
            [ inputElt config
            , labelElt config
            , lineRippleElt
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-text-field")


fullwidthCs : Config msg -> Maybe (Html.Attribute msg)
fullwidthCs { fullwidth } =
    if fullwidth then
        Just (class "mdc-text-field--fullwidth")

    else
        Nothing


textareaCs : Config msg -> Maybe (Html.Attribute msg)
textareaCs { textarea } =
    if textarea then
        Just (class "mdc-text-field--textarea")

    else
        Nothing


disabledCs : Config msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-text-field--disabled")

    else
        Nothing


inputElt : Config msg -> Html msg
inputElt config =
    (if config.textarea then
        Html.textarea

     else
        Html.input
    )
        (List.filterMap identity
            [ inputCs
            , rowsAttr config
            , colsAttr config
            , disabledAttr config
            ]
        )
        []


inputCs : Maybe (Html.Attribute msg)
inputCs =
    Just (class "mdc-text-field__input")


rowsAttr : Config msg -> Maybe (Html.Attribute msg)
rowsAttr { textarea, rows } =
    if textarea then
        Maybe.map Html.Attributes.rows rows

    else
        Nothing


colsAttr : Config msg -> Maybe (Html.Attribute msg)
colsAttr { textarea, cols } =
    if textarea then
        Maybe.map Html.Attributes.cols cols

    else
        Nothing


disabledAttr : Config msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    Just (Html.Attributes.disabled disabled)


labelElt : Config msg -> Html msg
labelElt { label } =
    Html.div [ class "mdc-floating-label" ] [ text label ]


lineRippleElt : Html msg
lineRippleElt =
    Html.div [ class "mdc-line-ripple" ] []


notchedOutlineElt : Config msg -> Html msg
notchedOutlineElt config =
    Html.div [ class "mdc-notched-outline" ]
        [ notchedOutlineLeadingElt
        , notchedOutlineNotchElt config
        , notchedOutlineTrailingElt
        ]


notchedOutlineLeadingElt : Html msg
notchedOutlineLeadingElt =
    Html.div [ class "mdc-notched-outline__leading" ] []


notchedOutlineTrailingElt : Html msg
notchedOutlineTrailingElt =
    Html.div [ class "mdc-notched-outline__trailing" ] []


notchedOutlineNotchElt : Config msg -> Html msg
notchedOutlineNotchElt config =
    Html.div [ class "mdc-notched-outline__notch" ] [ labelElt config ]
