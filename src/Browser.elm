-- Dummy implementation of Browser.sandbox for `./bin/test-docs.hs` for module
-- Material.Snackbar


module Browser exposing (sandbox)

import Html exposing (Html)


sandbox :
    { init : model
    , view : model -> Html msg
    , update : msg -> model -> model
    }
    -> Program () model msg
sandbox r =
    (\() -> sandbox r) ()
