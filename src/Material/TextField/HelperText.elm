module Material.TextField.HelperText exposing
    ( Config
    , helperText
    , helperTextConfig
    , rootCs
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { persistent : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


helperTextConfig : Config msg
helperTextConfig =
    { persistent = False
    , additionalAttributes = []
    }


helperText : Config msg -> String -> Html msg
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


persistentCs : Config msg -> Maybe (Html.Attribute msg)
persistentCs config =
    if config.persistent then
        Just (class "mdc-text-field-helper-text--persistent")

    else
        Nothing


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")
