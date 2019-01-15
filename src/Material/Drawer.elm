module Material.Drawer exposing
    ( Config
    , HeaderConfig
    , Variant(..)
    , appContent
    , content
    , drawer
    , drawerConfig
    , header
    , scrim
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { variant : Variant
    , open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


drawerConfig : Config msg
drawerConfig =
    { variant = Default
    , open = False
    , additionalAttributes = []
    }


type Variant
    = Default
    | Dismissable
    | Modal


drawer : Config msg -> List (Html msg) -> Html msg
drawer config nodes =
    Html.node "mdc-drawer"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            , openCs config
            ]
            ++ config.additionalAttributes
        )
        nodes


content : List (Html.Attribute msg) -> List (Html msg) -> Html msg
content attributes nodes =
    Html.div (class "mdc-drawer__content" :: attributes) nodes


type alias HeaderConfig msg =
    { title : String
    , subtitle : String
    , additionalAttributes : List (Html.Attribute msg)
    }


header : HeaderConfig msg -> Html msg
header config =
    Html.div (class "mdc-drawer__header" :: config.additionalAttributes)
        [ titleElt config
        , subtitleElt config
        ]


titleElt : HeaderConfig msg -> Html msg
titleElt { title } =
    Html.h3 [ class "mdc-drawer__title" ] [ text title ]


subtitleElt : HeaderConfig msg -> Html msg
subtitleElt { subtitle } =
    Html.h6 [ class "mdc-drawer__subtitle" ] [ text subtitle ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-drawer")


variantCs : Config msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    case variant of
        Default ->
            Nothing

        Dismissable ->
            Just (class "mdc-drawer--dismissable")

        Modal ->
            Just (class "mdc-drawer--modal")


openCs : Config msg -> Maybe (Html.Attribute msg)
openCs { open } =
    if open then
        Just (class "mdc-drawer--open")

    else
        Nothing


contentElt : List (Html msg) -> Html msg
contentElt nodes =
    Html.div [ class "mdc-drawer__content" ] nodes


appContent : Html.Attribute msg
appContent =
    class "mdc-drawer-app-content"


scrim : Html.Attribute msg
scrim =
    class "mdc-drawer-scrim"
