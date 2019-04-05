module Material.Select exposing
    ( SelectConfig
    , SelectOption
    , SelectOptionConfig
    , filledSelect
    , outlinedSelect
    , selectConfig
    , selectOption
    , selectOptionConfig
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


type alias SelectConfig msg =
    { label : String
    , value : Maybe String
    , variant : Variant
    , additionalAttributes : List (Html.Attribute msg)
    , onChange : Maybe (String -> msg)
    }


selectConfig : SelectConfig msg
selectConfig =
    { label = ""
    , value = Nothing
    , variant = Filled
    , additionalAttributes = []
    , onChange = Nothing
    }


type Variant
    = Filled
    | Outlined


select : SelectConfig msg -> List (SelectOption msg) -> Html msg
select config nodes =
    Html.node "mdc-select"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            ]
            ++ config.additionalAttributes
        )
        (List.concat
            [ [ dropdownIconElt
              , nativeControlElt config nodes
              ]
            , if config.variant == Outlined then
                [ notchedOutlineElt config ]

              else
                [ floatingLabelElt config
                , lineRippleElt
                ]
            ]
        )


filledSelect : SelectConfig msg -> List (SelectOption msg) -> Html msg
filledSelect config nodes =
    select { config | variant = Filled } nodes


outlinedSelect : SelectConfig msg -> List (SelectOption msg) -> Html msg
outlinedSelect config nodes =
    select { config | variant = Outlined } nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-select")


variantCs : SelectConfig msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    if variant == Outlined then
        Just (class "mdc-select--outlined")

    else
        Nothing


valueAttr : SelectConfig msg -> Maybe (Html.Attribute msg)
valueAttr { value } =
    Maybe.map Html.Attributes.value value


dropdownIconElt : Html msg
dropdownIconElt =
    Html.i [ class "mdc-select__dropdown-icon" ] []


nativeControlElt : SelectConfig msg -> List (SelectOption msg) -> Html msg
nativeControlElt config nodes =
    Html.select
        (List.filterMap identity
            [ nativeControlCs
            , valueAttr config
            , changeHandler config
            ]
        )
        (List.map (\(SelectOption f) -> f config) nodes)


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-select__native-control")


type alias SelectOptionConfig msg =
    { disabled : Bool
    , value : String
    , additionalAttributes : List (Html.Attribute msg)
    }


selectOptionConfig : SelectOptionConfig msg
selectOptionConfig =
    { disabled = False
    , value = ""
    , additionalAttributes = []
    }


type SelectOption msg
    = SelectOption (SelectConfig msg -> Html msg)


selectOption : SelectOptionConfig msg -> List (Html msg) -> SelectOption msg
selectOption config nodes =
    SelectOption
        (\topConfig ->
            Html.option
                ([ selectedAttr topConfig config
                 , disabledAttr config
                 , optionValueAttr config
                 ]
                    ++ config.additionalAttributes
                )
                nodes
        )


selectedAttr : SelectConfig msg -> SelectOptionConfig msg -> Html.Attribute msg
selectedAttr topConfig config =
    Html.Attributes.selected (Maybe.withDefault "" topConfig.value == config.value)


disabledAttr : SelectOptionConfig msg -> Html.Attribute msg
disabledAttr { disabled } =
    Html.Attributes.disabled disabled


optionValueAttr : SelectOptionConfig msg -> Html.Attribute msg
optionValueAttr { value } =
    Html.Attributes.value value


changeHandler : SelectConfig msg -> Maybe (Html.Attribute msg)
changeHandler { onChange } =
    Maybe.map
        (\f ->
            Html.Events.preventDefaultOn "change"
                (Decode.map (\s -> ( f s, True )) Html.Events.targetValue)
        )
        onChange


floatingLabelElt : SelectConfig msg -> Html msg
floatingLabelElt { label, value } =
    Html.label
        [ if Maybe.withDefault "" value /= "" then
            class "mdc-floating-label mdc-floating-label--float-above"

          else
            class "mdc-floating-label"
        ]
        [ text label ]


lineRippleElt : Html msg
lineRippleElt =
    Html.label [ class "mdc-line-ripple" ] []


notchedOutlineElt : SelectConfig msg -> Html msg
notchedOutlineElt { label } =
    Html.div [ class "mdc-notched-outline" ]
        [ Html.div [ class "mdc-notched-outline__leading" ] []
        , Html.div [ class "mdc-notched-outline__notch" ]
            [ Html.label [ class "mdc-floating-label" ] [ text label ]
            ]
        , Html.div [ class "mdc-notched-outline__trailing" ] []
        ]
