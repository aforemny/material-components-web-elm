module Material.TextField.HelperText exposing
    ( HelperTextConfig, helperTextConfig
    , helperText
    )

{-|

@docs HelperTextConfig, helperTextConfig
@docs helperText

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| TODO docs
-}
type alias HelperTextConfig msg =
    { persistent : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| TODO docs
-}
helperTextConfig : HelperTextConfig msg
helperTextConfig =
    { persistent = False
    , additionalAttributes = []
    }


{-| TODO docs
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
