module Material.TabBar exposing (Config, tabBar, tabBarConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.TabScroller exposing (tabScroller, tabScrollerConfig)



-- TODO: move tab, tabConfig here


type alias Config msg =
    { tabScrollerConfig : Material.TabScroller.Config msg
    , additionalAttributes : List (Html.Attribute msg)
    }


tabBarConfig : Config msg
tabBarConfig =
    { tabScrollerConfig = tabScrollerConfig
    , additionalAttributes = []
    }


tabBar : Config msg -> List (Html msg) -> Html msg
tabBar config nodes =
    Html.node "mdc-tab-bar"
        (List.filterMap identity
            [ rootCs
            , tablistRoleAttr
            ]
            ++ config.additionalAttributes
        )
        [ tabScroller config.tabScrollerConfig nodes
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-tab-bar")


tablistRoleAttr : Maybe (Html.Attribute msg)
tablistRoleAttr =
    Just (Html.Attributes.attribute "role" "tablist")
