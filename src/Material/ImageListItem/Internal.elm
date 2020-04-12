module Material.ImageListItem.Internal exposing (Config(..), ImageListItem(..))

import Html


type Config msg
    = Config
        { label : Maybe String
        , href : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , image : String
        }


type ImageListItem msg
    = ImageListItem (Config msg)
