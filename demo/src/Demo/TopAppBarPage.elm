module Demo.TopAppBarPage exposing (TopAppBarPage, view)

import Html exposing (Html, text)
import Html.Attributes
import Material.Typography as Typography


type alias TopAppBarPage msg =
    { fixedAdjust : Html.Attribute msg
    , topAppBar : Html msg
    }


view : (msg -> topMsg) -> TopAppBarPage msg -> Html topMsg
view lift { topAppBar, fixedAdjust } =
    Html.map lift <|
        Html.div
            [ Html.Attributes.style "height" "200vh"
            , Typography.typography
            ]
            [ topAppBar
            , Html.div [ fixedAdjust ]
                (List.repeat 4 (Html.p [] [ text demoParagraph ]))
            ]


demoParagraph : String
demoParagraph =
    """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
    veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
    commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate
    velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
    cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id
    est laborum.
    """
