module Material.Theme exposing
    ( primary, secondary, background
    , primaryBg, secondaryBg, surface
    , onPrimary, onSecondary, onSurface
    , textPrimaryOnBackground, textPrimaryOnDark, textPrimaryOnLight
    , textSecondaryOnBackground, textSecondaryOnDark, textSecondaryOnLight
    , textDisabledOnBackground, textDisabledOnDark, textDisabledOnLight
    , textHintOnBackground, textHintOnDark, textHintOnLight
    , textIconOnBackground, textIconOnDark, textIconOnLight
    )

{-|

@docs primary, secondary, background
@docs primaryBg, secondaryBg, surface

@docs onPrimary, onSecondary, onSurface

@docs textPrimaryOnBackground, textPrimaryOnDark, textPrimaryOnLight
@docs textSecondaryOnBackground, textSecondaryOnDark, textSecondaryOnLight
@docs textDisabledOnBackground, textDisabledOnDark, textDisabledOnLight
@docs textHintOnBackground, textHintOnDark, textHintOnLight
@docs textIconOnBackground, textIconOnDark, textIconOnLight

-}

import Html
import Html.Attributes exposing (class)


{-| TODO docs
-}
primary : Html.Attribute msg
primary =
    class "mdc-theme--primary"


{-| TODO docs
-}
secondary : Html.Attribute msg
secondary =
    class "mdc-theme--secondary"


{-| TODO docs
-}
background : Html.Attribute msg
background =
    class "mdc-theme--background"


{-| TODO docs
-}
surface : Html.Attribute msg
surface =
    class "mdc-theme--surface"


{-| TODO docs
-}
onPrimary : Html.Attribute msg
onPrimary =
    class "mdc-theme--on-primary"


{-| TODO docs
-}
onSecondary : Html.Attribute msg
onSecondary =
    class "mdc-theme--on-secondary"


{-| TODO docs
-}
onSurface : Html.Attribute msg
onSurface =
    class "mdc-theme--on-surface"


{-| TODO docs
-}
primaryBg : Html.Attribute msg
primaryBg =
    class "mdc-theme--primary-bg"


{-| TODO docs
-}
secondaryBg : Html.Attribute msg
secondaryBg =
    class "mdc-theme--secondary-bg"


{-| TODO docs
-}
textPrimaryOnLight : Html.Attribute msg
textPrimaryOnLight =
    class "mdc-theme--text-primary-on-light"


{-| TODO docs
-}
textSecondaryOnLight : Html.Attribute msg
textSecondaryOnLight =
    class "mdc-theme--text-secondary-on-light"


{-| TODO docs
-}
textHintOnLight : Html.Attribute msg
textHintOnLight =
    class "mdc-theme--text-hint-on-light"


{-| TODO docs
-}
textDisabledOnLight : Html.Attribute msg
textDisabledOnLight =
    class "mdc-theme--text-disabled-on-light"


{-| TODO docs
-}
textIconOnLight : Html.Attribute msg
textIconOnLight =
    class "mdc-theme--text-icon-on-light"


{-| TODO docs
-}
textPrimaryOnDark : Html.Attribute msg
textPrimaryOnDark =
    class "mdc-theme--text-primary-on-dark"


{-| TODO docs
-}
textSecondaryOnDark : Html.Attribute msg
textSecondaryOnDark =
    class "mdc-theme--text-secondary-on-dark"


{-| TODO docs
-}
textHintOnDark : Html.Attribute msg
textHintOnDark =
    class "mdc-theme--text-hint-on-dark"


{-| TODO docs
-}
textDisabledOnDark : Html.Attribute msg
textDisabledOnDark =
    class "mdc-theme--text-disabled-on-dark"


{-| TODO docs
-}
textIconOnDark : Html.Attribute msg
textIconOnDark =
    class "mdc-theme--text-icon-on-dark"


{-| TODO docs
-}
textPrimaryOnBackground : Html.Attribute msg
textPrimaryOnBackground =
    class "mdc-theme--text-primary-on-background"


{-| TODO docs
-}
textSecondaryOnBackground : Html.Attribute msg
textSecondaryOnBackground =
    class "mdc-theme--text-secondary-on-background"


{-| TODO docs
-}
textHintOnBackground : Html.Attribute msg
textHintOnBackground =
    class "mdc-theme--text-hint-on-background"


{-| TODO docs
-}
textDisabledOnBackground : Html.Attribute msg
textDisabledOnBackground =
    class "mdc-theme--text-disabled-on-background"


{-| TODO docs
-}
textIconOnBackground : Html.Attribute msg
textIconOnBackground =
    class "mdc-theme--text-icon-on-background"
