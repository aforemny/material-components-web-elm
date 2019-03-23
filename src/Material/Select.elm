module Material.Select exposing
    ( Config
    , OptionConfig
    , Variant(..)
    , option
    , optionConfig
    , select
    , selectConfig
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)



-- TODO: native control? (styling)


type alias Config msg =
    { label : String
    , variant : Variant
    , additionalAttributes : List (Html.Attribute msg)
    }


selectConfig : Config msg
selectConfig =
    { label = ""
    , variant = Default
    , additionalAttributes = []
    }


type Variant
    = Default
    | Outlined
    | Box


select : Config msg -> List (Html msg) -> Html msg
select config nodes =
    Html.node "mdc-select"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            ]
            ++ config.additionalAttributes
        )
        [ dropdownIconElt
        , nativeControlElt nodes
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-select")


variantCs : Config msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    case variant of
        Default ->
            Nothing

        Outlined ->
            Just (class "mdc-select--outlined")

        Box ->
            Just (class "mdc-select--box")


dropdownIconElt : Html msg
dropdownIconElt =
    Html.i [ class "mdc-select__dropdown-icon" ] []


nativeControlElt : List (Html msg) -> Html msg
nativeControlElt nodes =
    Html.select [ nativeControlCs ] nodes


nativeControlCs : Html.Attribute msg
nativeControlCs =
    class "mdc-select__native-control"


type alias OptionConfig msg =
    { selected : Bool
    , disabled : Bool
    , value : String
    , additionalAttributes : List (Html.Attribute msg)
    }


optionConfig : OptionConfig msg
optionConfig =
    { selected = False
    , disabled = False
    , value = ""
    , additionalAttributes = []
    }


option : OptionConfig msg -> List (Html msg) -> Html msg
option config nodes =
    Html.option
        ([ selectedAttr config
         , disabledAttr config
         , valueAttr config
         ]
            ++ config.additionalAttributes
        )
        nodes


selectedAttr : OptionConfig msg -> Html.Attribute msg
selectedAttr { selected } =
    Html.Attributes.selected selected


disabledAttr : OptionConfig msg -> Html.Attribute msg
disabledAttr { disabled } =
    Html.Attributes.disabled disabled


valueAttr : OptionConfig msg -> Html.Attribute msg
valueAttr { value } =
    Html.Attributes.value value
