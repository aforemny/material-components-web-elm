module Main exposing (main)

import Html exposing (Html, text)
import Material.Button exposing (button, buttonConfig)


main : Html msg
main =
    Html.div []
        [ button
            { buttonConfig | label = "Click me" }
        , button
            { buttonConfig
                | label = "Click me"
                , variant = Material.Button.Raised
            }
        , button
            { buttonConfig
                | label = "Click me"
                , variant = Material.Button.Unelevated
            }
        , button
            { buttonConfig
                | label = "Click me"
                , variant = Material.Button.Outlined
            }
        ]
