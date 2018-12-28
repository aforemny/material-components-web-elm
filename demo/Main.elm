module Main exposing (main)

import Html exposing (Html, text)
import Material.Button exposing (button, buttonConfig)
import Material.Card
import Material.Icon


main : Html msg
main =
    Html.div []
        [ Html.div []
            [ button
                buttonConfig
                "Click me"
            , button
                { buttonConfig | variant = Material.Button.Raised }
                "Click me"
            , button
                { buttonConfig | variant = Material.Button.Unelevated }
                "Click me"
            , button
                { buttonConfig | variant = Material.Button.Outlined }
                "Click me"
            ]
        , Html.div []
            [ button
                denseConfig
                "Click me"
            , button
                { denseConfig | variant = Material.Button.Raised }
                "Click me"
            , button
                { denseConfig | variant = Material.Button.Unelevated }
                "Click me"
            , button
                { denseConfig | variant = Material.Button.Outlined }
                "Click me"
            ]
        ]


denseConfig =
    { buttonConfig | dense = True }
