module Material.Drawer exposing
    ( DrawerConfig, drawerConfig
    , permanentDrawer
    , drawerContent, appContent
    , DrawerHeaderContent
    , drawerHeader
    , dismissibleDrawer
    , modalDrawer, drawerScrim
    )

{-|

@docs DrawerConfig, drawerConfig
@docs permanentDrawer
@docs drawerContent, appContent

@docs DrawerHeaderContent
@docs drawerHeader

@docs dismissibleDrawer

@docs modalDrawer, drawerScrim

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


{-| TODO
-}
type alias DrawerConfig msg =
    { variant : Variant
    , open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


{-| TODO
-}
drawerConfig : DrawerConfig msg
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


drawer : DrawerConfig msg -> List (Html msg) -> Html msg
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


{-| TODO
-}
permanentDrawer : DrawerConfig msg -> List (Html msg) -> Html msg
permanentDrawer config nodes =
    drawer { config | variant = Permanent } nodes


{-| TODO
-}
dismissibleDrawer : DrawerConfig msg -> List (Html msg) -> Html msg
dismissibleDrawer config nodes =
    drawer { config | variant = Dismissible } nodes


{-| TODO
-}
modalDrawer : DrawerConfig msg -> List (Html msg) -> Html msg
modalDrawer config nodes =
    drawer { config | variant = Modal } nodes


{-| TODO
-}
drawerContent : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerContent attributes nodes =
    Html.div (class "mdc-drawer__content" :: attributes) nodes


{-| TODO
-}
type alias DrawerHeaderContent =
    { title : String
    , subtitle : String
    }


{-| TODO
-}
drawerHeader : List (Html.Attribute msg) -> DrawerHeaderContent -> Html msg
drawerHeader additionalAttributes content =
    Html.div (class "mdc-drawer__header" :: additionalAttributes)
        [ titleElt content
        , subtitleElt content
        ]


titleElt : DrawerHeaderContent -> Html msg
titleElt { title } =
    Html.h3 [ class "mdc-drawer__title" ] [ text title ]


subtitleElt : DrawerHeaderContent -> Html msg
subtitleElt { subtitle } =
    Html.h6 [ class "mdc-drawer__subtitle" ] [ text subtitle ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-drawer")


variantCs : DrawerConfig msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    case variant of
        Permanent ->
            Nothing

        Dismissible ->
            Just (class "mdc-drawer--dismissible")

        Modal ->
            Just (class "mdc-drawer--modal")


openAttr : DrawerConfig msg -> Maybe (Html.Attribute msg)
openAttr { variant, open } =
    if open && variant /= Permanent then
        Just (Html.Attributes.attribute "open" "")

    else
        Nothing


closeHandler : DrawerConfig msg -> Maybe (Html.Attribute msg)
closeHandler { onClose } =
    Maybe.map (Html.Events.on "MDCDrawer:close" << Decode.succeed) onClose


contentElt : List (Html msg) -> Html msg
contentElt nodes =
    Html.div [ class "mdc-drawer__content" ] nodes


{-| TODO
-}
appContent : Html.Attribute msg
appContent =
    class "mdc-drawer-app-content"


{-| TODO
-}
drawerScrim : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerScrim additionalAttributes nodes =
    Html.div ([ class "mdc-drawer-scrim" ] ++ additionalAttributes) nodes
