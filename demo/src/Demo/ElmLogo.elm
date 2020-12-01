module Demo.ElmLogo exposing (elmLogo)

import Svg exposing (Svg)
import Svg.Attributes


elmLogo : List (Svg msg)
elmLogo =
    [ Svg.polygon
        [ Svg.Attributes.fill "#5A6378"
        , Svg.Attributes.points "0,2 48,50 0,98"
        ]
        []
    , Svg.polygon
        [ Svg.Attributes.fill "#7FD13B"
        , Svg.Attributes.points
            "2,0 25.585786437626904,23.585786437626904 71.58578643762691,23.585786437626904 48,0"
        ]
        []
    , Svg.polygon
        [ Svg.Attributes.fill "#7FD13B"
        , Svg.Attributes.points
            "2,0 25.585786437626904,23.585786437626904 71.58578643762691,23.585786437626904 48,0"
        ]
        []
    , Svg.polygon
        [ Svg.Attributes.fill "#F0AD00"
        , Svg.Attributes.points
            "28.414213562373096,26.414213562373096 71.58578643762691,26.414213562373096 50,48"
        ]
        []
    , Svg.polygon
        [ Svg.Attributes.fill "#60B5CC"
        , Svg.Attributes.points "52,0 100,0 100,48"
        ]
        []
    , Svg.polygon
        [ Svg.Attributes.fill "#F0AD00"
        , Svg.Attributes.points "100,52 77,75 100,98"
        ]
        []
    , Svg.polygon
        [ Svg.Attributes.fill "#60B5CC"
        , Svg.Attributes.points "2,100 50,52 98,100"
        ]
        []
    , Svg.polygon
        [ Svg.Attributes.fill "#7FD13B"
        , Svg.Attributes.points "52,50 75,27 98,50 75,73"
        ]
        []
    ]
