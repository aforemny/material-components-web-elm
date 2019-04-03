module Material.Drawer exposing
    ( Config
    , HeaderConfig
    , appContent
    , dismissibleDrawer
    , drawerConfig
    , drawerContent
    , drawerHeader
    , drawerScrim
    , modalDrawer
    , permanentDrawer
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


type alias Config msg =
    { variant : Variant
    , open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


drawerConfig : Config msg
drawerConfig =
    { variant = Permanent
    , open = False
    , additionalAttributes = []
    , onClose = Nothing
    }


type Variant
    = Permanent
    | Dismissible
    | Modal


drawer : Config msg -> List (Html msg) -> Html msg
drawer config nodes =
    Html.node "mdc-drawer"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            , openAttr config
            , closeHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


permanentDrawer : Config msg -> List (Html msg) -> Html msg
permanentDrawer config nodes =
    drawer { config | variant = Permanent } nodes


dismissibleDrawer : Config msg -> List (Html msg) -> Html msg
dismissibleDrawer config nodes =
    drawer { config | variant = Dismissible } nodes


modalDrawer : Config msg -> List (Html msg) -> Html msg
modalDrawer config nodes =
    drawer { config | variant = Modal } nodes


drawerContent : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerContent attributes nodes =
    Html.div (class "mdc-drawer__content" :: attributes) nodes


type alias HeaderConfig msg =
    { title : String
    , subtitle : String
    , additionalAttributes : List (Html.Attribute msg)
    }


drawerHeader : HeaderConfig msg -> Html msg
drawerHeader config =
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
        Permanent ->
            Nothing

        Dismissible ->
            Just (class "mdc-drawer--dismissible")

        Modal ->
            Just (class "mdc-drawer--modal")


openAttr : Config msg -> Maybe (Html.Attribute msg)
openAttr { variant, open } =
    if open && variant /= Permanent then
        Just (Html.Attributes.attribute "open" "")

    else
        Nothing


closeHandler : Config msg -> Maybe (Html.Attribute msg)
closeHandler { onClose } =
    Maybe.map (Html.Events.on "MDCDrawer:close" << Decode.succeed) onClose


contentElt : List (Html msg) -> Html msg
contentElt nodes =
    Html.div [ class "mdc-drawer__content" ] nodes


appContent : Html.Attribute msg
appContent =
    class "mdc-drawer-app-content"


drawerScrim : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerScrim additionalAttributes nodes =
    Html.div ([ class "mdc-drawer-scrim" ] ++ additionalAttributes) nodes
