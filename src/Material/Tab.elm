module Material.Tab exposing (Config, Content, tab, tabConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { active : Bool
    , stacked : Bool
    , minWidth : Bool
    , indicatorSpansContent : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


tabConfig : Config msg
tabConfig =
    { active = False
    , stacked = False
    , minWidth = False
    , indicatorSpansContent = False
    , additionalAttributes = []
    }


tab : Config msg -> Content -> Html msg
tab config content =
    Html.node "mdc-tab"
        (List.filterMap identity
            [ rootCs
            , tabRoleAttr
            , tabindexAttr
            , activeCs config
            , stackedCs config
            , minWidthCs config
            , selectedAriaAttr config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity <|
            if config.indicatorSpansContent then
                [ contentElt config content
                , rippleElt
                ]

            else
                [ contentElt config content
                , indicatorElt config
                , rippleElt
                ]
        )


type alias Content =
    { label : String
    , icon : Maybe String
    }


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-tab")


activeCs : Config msg -> Maybe (Html.Attribute msg)
activeCs { active } =
    if active then
        Just (class "mdc-tab--active")

    else
        Nothing


stackedCs : Config msg -> Maybe (Html.Attribute msg)
stackedCs { stacked } =
    if stacked then
        Just (class "mdc-tab--stacked")

    else
        Nothing


minWidthCs : Config msg -> Maybe (Html.Attribute msg)
minWidthCs { minWidth } =
    if minWidth then
        Just (class "mdc-tab--min-width")

    else
        Nothing


tabRoleAttr : Maybe (Html.Attribute msg)
tabRoleAttr =
    Just (Html.Attributes.attribute "role" "tab")


selectedAriaAttr : Config msg -> Maybe (Html.Attribute msg)
selectedAriaAttr { active } =
    Just
        (Html.Attributes.attribute "aria-selected"
            (if active then
                "true"

             else
                "false"
            )
        )


tabindexAttr : Maybe (Html.Attribute msg)
tabindexAttr =
    Just (Html.Attributes.tabindex -1)


contentElt : Config msg -> Content -> Maybe (Html msg)
contentElt config content =
    Just
        (Html.div [ class "mdc-tab__content" ]
            (if config.indicatorSpansContent then
                List.filterMap identity
                    [ iconElt content
                    , textLabelElt content
                    , indicatorElt config
                    ]

             else
                List.filterMap identity
                    [ iconElt content
                    , textLabelElt content
                    ]
            )
        )


iconElt : Content -> Maybe (Html msg)
iconElt { icon } =
    Maybe.map
        (\iconName ->
            Html.span
                [ class "mdc-tab__icon material-icons" ]
                [ text iconName ]
        )
        icon


textLabelElt : Content -> Maybe (Html msg)
textLabelElt { label } =
    Just (Html.span [ class "mdc-tab__text-label" ] [ text label ])


indicatorElt : Config msg -> Maybe (Html msg)
indicatorElt config =
    Just
        (Html.span
            (List.filterMap identity
                [ indicatorCs
                , indicatorActiveCs config
                ]
            )
            []
        )


indicatorCs : Maybe (Html.Attribute msg)
indicatorCs =
    Just (class "mdc-tab__indicator")


indicatorActiveCs : Config msg -> Maybe (Html.Attribute msg)
indicatorActiveCs { active } =
    if active then
        Just (class "mdc-tab__indicator--active")

    else
        Nothing


indicatorContentElt : Maybe (Html msg)
indicatorContentElt =
    Just
        (Html.span
            [ class "mdc-tab__indicator-content"
            , class "mdc-tab__indicator-content--underline"
            ]
            []
        )


rippleElt : Maybe (Html msg)
rippleElt =
    Just (Html.span [ class "mdc-tab__ripple" ] [])
