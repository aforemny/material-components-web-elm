module Material.ImageList.Item.Internal exposing (Config(..), ImageListItem(..))

import Html


type Config msg
    = Config
        { label : Maybe String
        , href : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , image : String
        , imageNode : Maybe (List (Html.Attribute msg))
        }


type ImageListItem msg
    = ImageListItem (Config msg)
