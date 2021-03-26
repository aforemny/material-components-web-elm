# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [7.0.0](https://github.com/aforemny/material-components-web-elm/compare/6.0.0...7.0.0) (2021-03-26)


### ⚠ BREAKING CHANGES

* The signature of `TabBar.tabBar` has changed. It now takes the first tab
as an extra argument to guarantee that the list of tabs passed to it is
non-empty.

Before:
```elm
TabBar.tabBar TabBar.config
    [ Tab.tab Tab.config { … }
    , Tab.tab Tab.config { … }
    ]
```

After:
```elm
TabBar.tabBar TabBar.config
    (Tab.tab Tab.config { … })
    [ Tab.tab Tab.config { … } ]
```

### Features

* Add Button.setMenu and IconButton.setMenu ([43ae4f1](https://github.com/aforemny/material-components-web-elm/commit/43ae4f1a09bd3c01d5c4750545034266f6c76bc7))
* Add setHref and setTarget to IconButton ([e6969cb](https://github.com/aforemny/material-components-web-elm/commit/e6969cb36693a7729a5fa833527fb8ac19818878))
* Link buttons can be disabled ([dd513f6](https://github.com/aforemny/material-components-web-elm/commit/dd513f6a66f70d424a9c4f7eb2bf3736c084096e))


### Bug Fixes

* Guarantee that precisely one tab within a tab bar is active ([540113c](https://github.com/aforemny/material-components-web-elm/commit/540113cc00a3a2f2e3ed2be513c0b6e20a246560))
* IconButtons and IconToggles cannot be disabled ([66d0967](https://github.com/aforemny/material-components-web-elm/commit/66d0967669770c4a74a48f92fcc802ba26b2a0f8))
* Support dynamic tabs ([9878e53](https://github.com/aforemny/material-components-web-elm/commit/9878e539a88f5cf322889d6762cb333bf67ef749))

## [6.0.0](https://github.com/aforemny/material-components-web-elm/compare/5.1.0...6.0.0) (2020-10-08)


### ⚠ BREAKING CHANGES

* The type signature of `chipSet` changed from

```
chipSet : List (Html.Attribute msg) -> List (Chip msg) -> Html msg
```

to

```
chipSet : List (Html.Attribute msg) -> Chip msg -> List (Chip msg) -> Html msg
```

### Features

* **docs:** Add Text area with character counter demo ([a066421](https://github.com/aforemny/material-components-web-elm/commit/a066421331a51d07a1c2dc50ed375576755f9fc8))
* Add component CircularProgress ([19717c2](https://github.com/aforemny/material-components-web-elm/commit/19717c2189dff1e33ae03ae7a97cea79d5f262de))
* Add TextField.setEndAligned ([dd6d0bf](https://github.com/aforemny/material-components-web-elm/commit/dd6d0bf5cc244747e89c89f0a7f313428399b43e))
* Add TextField.setPrefix, TextField.setSuffix ([96d6ca8](https://github.com/aforemny/material-components-web-elm/commit/96d6ca8cc17703071eb13f74002aa4dc876a990a))
* Add Theme.error and Theme.onError to provide CSS error classes ([ff5b9c9](https://github.com/aforemny/material-components-web-elm/commit/ff5b9c95ed0503625393c3bfb13cbc2e9be0b0fb))
* Disallow empty chip sets ([9c514dc](https://github.com/aforemny/material-components-web-elm/commit/9c514dcfc9183da3d49c1b0ae17d3d8f5ea4fd1c))
* Update to MDC 6.0.0 ([a65b371](https://github.com/aforemny/material-components-web-elm/commit/a65b3710795018e8f632316e6a74c1509f24f786))


### Bug Fixes

* Character counters for TextAreas were throwing due to missing maxLength prop ([9902c0e](https://github.com/aforemny/material-components-web-elm/commit/9902c0e4b65e4f08ffb82012ce4d7a581da39d13))
* SvgIcon was not handled by Snackbar ([d179f4a](https://github.com/aforemny/material-components-web-elm/commit/d179f4a44a3db030d69c7704ceb8b9ac01f9a567))

## [5.1.0](https://github.com/aforemny/material-components-web-elm/compare/5.0.0...5.1.0) (2020-09-13)


### Features

* Add HelperText.setValidation ([20b5d4f](https://github.com/aforemny/material-components-web-elm/commit/20b5d4fc41e2b02e9517c4cdc7905b5e82c60310))
* Support MDC Web version 5.1.0 ([963e8e9](https://github.com/aforemny/material-components-web-elm/commit/963e8e9bc1d6ce7ef2c3c210aa3ba122902dcb08))


### Bug Fixes

* Refactor list selection ([25c0929](https://github.com/aforemny/material-components-web-elm/commit/25c09293326ee5c14cc3b0de2e81d2ecfeafe237))
* Remove non-existent .mdc-chip-set--action class ([d482328](https://github.com/aforemny/material-components-web-elm/commit/d482328a24a838fd44be1a583fdb71d474fbc926))
* Unregister body click handler when menu surface is destroyed ([83c997f](https://github.com/aforemny/material-components-web-elm/commit/83c997f34110eece64e3bf1e1a1cb37efa85aac6))

## [5.0.0](https://github.com/aforemny/material-components-web-elm/compare/4.0.0...5.0.0) (2020-08-30)


### ⚠ BREAKING CHANGES

* Generally, how icons are specified in this library changed. When before
we just wrote the Material Icon's /icon name/ as a String, say,
`"favorite"`, now we write `Button.icon "favorite"` for the Material
Icon (for a button). There are functions `Button.customIcon` and
`Button.svgIcon` to support custom icons.

The following modules have been updated to support custom icons:

- ActionChip
- Button
- ChoiceChip
- Fab
- Fab.Extended
- FilterChip
- IconButton
- IconToggle
- InputChip
- Select
- Snackbar
- Tab
- TextField

### Features

* Add support for custom icons. ([110f89e](https://github.com/aforemny/material-components-web-elm/commit/110f89e017022a9497b663076794c78ae3ac150b))

## [4.0.0](https://github.com/aforemny/material-components-web-elm/compare/3.0.3...4.0.0) (2020-07-05)


### ⚠ BREAKING CHANGES

* Native Select and Enhanced Select have been replaced by
a unified Select component. The API changed as follows:

Before:
```elm
import Material.Select as Select
import Material.Select.Option as SelectOption

Select.filled
    (Select.config
        |> Select.setLabel (Just "Fruit")
        |> Select.setValue (Just "")
        |> Select.setOnChange ValueChanged
    )
    [ SelectOption.selectOption
        (SelectOption.config
            |> SelectOption.setValue (Just "")
        )
        [ text "" ]
    , SelectOption.selectOption
        (SelectOption.config
            |> SelectOption.setValue (Just "Apple")
        )
        [ text "Apple" ]
    ]

```

After:
```elm
import Material.Select as Select
import Material.Select.Item as SelectItem

Select.filled
    (Select.config
        |> Select.setSelected (Just "")
        |> Select.setOnChange ValueChanged
    )
    (SelectItem.selectItem
        (SelectItem.config { value = "" })
        [ text "" ]
    )
    [ SelectItem.selectItem
        (SelectItem.config { value = "Apple" })
        [ text "Apple" ]
    ]
```
* Snackbar messages now require you to set a label.

Before:
```elm
Snackbar.message
    |> Snackbar.setLabel "Something happened"
```

After:
```elm
Snackbar.message "Something happened"
```
* Snackbar now offers a simpler interface.

Before:
```elm
type Msg
    = SnackbarMsg (Snackbar.Msg Msg)
    | SomethingHappened

update msg model =
   case msg of
       SnackbarMsg msg_ ->
           let
               ( newQueue, cmd) =
                   Snackbar.update SnackbarMsg msg_ model.queue
           in
           ( { model | queue = newQueue }, cmd )

       SomethingHappened ->
           ( model, Snackbar.addMessage SnackbarMsg Snackbar.message )

view model =
    Snackbar.snackbar SnackbarMsg Snackbar.config model.queue
```

After:
```elm
type Msg
    = SnackbarClosed Snackbar.MessageId
    | SomethingHappened

update msg model =
   case msg of
       SnackbarClosed messageId ->
           { model | queue = Snackbar.close messageId model.queue }

       SomethingHappened ->
           { model | queue = Snackbar.addMessage Snackbar.message model.queue }

view model =
    Snackbar.snackbar (Snackbar.config { onClosed = SnackbarClosed }) model.queue
```
* `List.list` type signature changed.

Before:
```elm
List.list List.config
    [ ListItem.listItem ListItem.config [ text "List Item" ]
    , ListItem.listItem ListItem.config [ text "List Item" ]
    ]
```

After:
```elm
List.list List.config
    (ListItem.listItem ListItem.config [ text "List Item" ])
    [ ListItem.listItem ListItem.config [ text "List Item" ] ]
```
* `Material.Choice.set` was renamed to
`Material.ChipSet.Choice.chipSet`. The same is true for filter and input
chips.
* Choice chip API changed.

Before:

```elm
import Material.Chip.Choice as ChoiceChip

ChoiceChip.set []
    [ ChoiceChip.chip
          (ChoiceChip.config
              |> ChoiceChip.setSelected (Just True)
              |> ChoiceChip.setOnClick (Clicked "Chip")
          )
          "Chip"
    ]
```

After:

```elm
import Material.Chip.Choice as ChoiceChip
improt Material.ChipSet.Choice as ChoiceChipSet

ChoiceChipSet.chipSet
    (ChoiceChipSet.config { toLabel = identity }
        |> ChoiceChipSet.setSelected (Just "Chip")
        |> ChoiceChipSet.setOnChange Clicked
    )
    [ ChoiceChip.chip ChoiceChip.config "Chip" ]
```
* Snackbar's `setTimeout` function now takes a `Maybe
Int` instead of a `Int`.

Before:

```elm
Snackbar.message
    |> Snackbar.setTimeout 4000
```

After:

```elm
Snackbar.message
    |> Snackbar.setTimeout (Just 4000)
```
* Removes `Slider.setOnChange`. Update your sliders to
use `setOnInput` instead.

Before:
```elm
Slider.slider (Slider.config |> Slider.setOnChange Changed)
```

After:
```elm
Slider.slider (Slider.config |> Slider.setOnInput Changed)
```

### Features

* Add focus support to ChipSet ([da373a1](https://github.com/aforemny/material-components-web-elm/commit/da373a1daa443018c14ee3b99ba5810d6f647c51))
* Add Select.setLeadingIcon ([d3aa83f](https://github.com/aforemny/material-components-web-elm/commit/d3aa83fced054b88d1e8ec1ed6f24e5b0c4d6c12))
* Add support for incrased touch target size ([b281c23](https://github.com/aforemny/material-components-web-elm/commit/b281c233d9b13fe8e4cc3c0cd85c00abf68e7259))
* Add support for persistent snackbar messages ([e6cbc50](https://github.com/aforemny/material-components-web-elm/commit/e6cbc50c1c97ac94ea2c3e929d529b2821f0d534))
* List items are guaranteed to have at least one item ([6f7521f](https://github.com/aforemny/material-components-web-elm/commit/6f7521f173692c7615c42d627387faf963cd8604))
* Refactor Select ([57e5a02](https://github.com/aforemny/material-components-web-elm/commit/57e5a022c913650d32d10e542ea85119c6d2e098))
* Remove Snackbar.Msg ([05ac366](https://github.com/aforemny/material-components-web-elm/commit/05ac366143795b6d6d79250bc9cd39ffe675773c))
* Remove Snackbar.setLabel ([e45553d](https://github.com/aforemny/material-components-web-elm/commit/e45553da8471277fa4405ede445c661a570d68b7))
* Update to MDC Web 4.0.0 ([915cdbd](https://github.com/aforemny/material-components-web-elm/commit/915cdbd0e156e6ccfd0498a62bb9a3bff0df80cc))


### Bug Fixes

* Add Slider.setOnInput ([1470dfc](https://github.com/aforemny/material-components-web-elm/commit/1470dfcffb8174e19bef5bf565127ae9b7e6c742))
* TextField's pattern property incorrectly defaulted to the empty pattern ([c2bab28](https://github.com/aforemny/material-components-web-elm/commit/c2bab283951291f4d9eada56bb23cf2524734a17))


* Refactor chips ([2ff6a46](https://github.com/aforemny/material-components-web-elm/commit/2ff6a463b562436b13ac8a0cd614256607e8f38d))

## [3.0.3](https://github.com/aforemny/material-components-web-elm/compare/3.0.2...3.0.3) (2020-06-30)


### Features

* Add support for Browser.Dom.focus ([fae5d07](https://github.com/aforemny/material-components-web-elm/commit/fae5d07cb1fde3dcc0e53091b67cf340add49346))
* Make Text Field compatible with Browser.Dom.focus ([bd04282](https://github.com/aforemny/material-components-web-elm/commit/bd042829538ca6ccebf0a06d0ab75617674508e3))


### Bug Fixes

* (Empty) List throws when dynamically adding first item ([9f7142a](https://github.com/aforemny/material-components-web-elm/commit/9f7142a31a837d703b7df1ae1cfd2ae45f2f9cc0))
* Fix source map locations in assets ([3d29b9e](https://github.com/aforemny/material-components-web-elm/commit/3d29b9eacd89d79b7fb6109cc0722e0754f5ca20))
* Make card's primary action accessible to keyboard navigation ([d0a095a](https://github.com/aforemny/material-components-web-elm/commit/d0a095a11762d028ed3b69c6a9a048ce6e383539))
* Make FABs accessible to keyboard navigation ([cf4e641](https://github.com/aforemny/material-components-web-elm/commit/cf4e64176eab2bc282ed902c5901dab4d7b488fc))
* Remove inline-flex display from mdc-button element ([082f059](https://github.com/aforemny/material-components-web-elm/commit/082f0595e61d0bb91b1705640e58527f2a855e80))

### [3.0.2](https://github.com/aforemny/material-components-web-elm/compare/3.0.1...3.0.2) (2020-06-08)


### Bug Fixes

* Data table rows were being marked as header rows ([639b6f1](https://github.com/aforemny/material-components-web-elm/commit/639b6f1c2263a08374253673cc4709836ef1545b))

### [3.0.1](https://github.com/aforemny/material-components-web-elm/compare/3.0.0...3.0.1) (2020-06-02)


### Bug Fixes

* Snackbar is always empty. Close [#106](https://github.com/aforemny/material-components-web-elm/issues/106) ([6e50300](https://github.com/aforemny/material-components-web-elm/commit/6e50300a7cef8a5c7cd5e0953e17f4a2cc887ca2))

## 3.0.0 (2020-05-11)


### ⚠ BREAKING CHANGES

* This commit implements the _builder pattern_ for
configuration types, replacing record based configuration. In most
cases, migration should be straight-forward. For example,

```elm
import Material.Button exposing (textButton, buttonConfig)

main =
    textButton
        { buttonConfig | icon = Just "favorite" }
        "Add to favorites"
```

becomes

```elm
import Material.Button as Button

main =
    Button.text
        (Button.config |> Button.setIcon "favorite")
        "Add to favorites"
```

If you have trouble migrating some code, please leave a message on
GitHub issues!


### Bug Fixes

* Fix List.subheader type ([4a25c10](https://github.com/aforemny/material-components-web-elm/commit/4a25c103007798f8da482a31a32f053a68de6f57))
* Remove unused dependency elm/url ([984d8e4](https://github.com/aforemny/material-components-web-elm/commit/984d8e4edf32c2eeea85f59eca564e47c7f06668))

### 2.1.2 (2020-03-01)


### Bug Fixes

* **docs:** Fix broken demo links in documentation ([7a0ed82](https://github.com/aforemny/material-components-web-elm/commit/7a0ed82bf02e3214875ea6e36307c2f56b5eed58))
* Distribute non-minified and source map assets via npm ([432b262](https://github.com/aforemny/material-components-web-elm/commit/432b2626002d97c8c6750beb54ea05708f33e92f))
* Fix floating label lowering incorrectly ([acd7c88](https://github.com/aforemny/material-components-web-elm/commit/acd7c8823345238efcb6689a9947c2746ad64b10))
* Fix input chip set incorrectly removing chip on trailing icon interaction ([a7a2d98](https://github.com/aforemny/material-components-web-elm/commit/a7a2d98629c3a048965992aebb575a4342347e03))

### 2.1.1 (2020-02-17)


### Bug Fixes

* Data Table throws error upon destruction ([eaf1649](https://github.com/aforemny/material-components-web-elm/commit/eaf1649680d366d20e260f6cb5019fc98bd71c8a))

## 2.1.0 (2020-01-07)


### Features

* Add Data Table ([4ffdfa4](https://github.com/aforemny/material-components-web-elm/commit/4ffdfa4a6dc5dbecfd4a7680d6f7c70153bbc101))
* Update to MDC Web 3.2.0 ([c01ce82](https://github.com/aforemny/material-components-web-elm/commit/c01ce82da33c8207bd9fcb0d5494a7a1ae1aa861))

### 2.0.1 (2019-11-26)


### Features

* Update to MDC Web v2.3.1 ([7468981](https://github.com/aforemny/material-components-web-elm/commit/746898135eee6f6b714b3959dc74f4a45d33fde1))


### Bug Fixes

* Fix determinate linear progress variants ([e9c3c8c](https://github.com/aforemny/material-components-web-elm/commit/e9c3c8c21b91e113ca93d64e762eca49cbf598d9))
* Fix ripple for buttons ([8d59940](https://github.com/aforemny/material-components-web-elm/commit/8d59940d5cefaf78da6689ab6a5d68a29967943c))
* Fix snackbar crashing when messages cycled very quickly ([c816c5b](https://github.com/aforemny/material-components-web-elm/commit/c816c5bf80ca536366c86353354583a0212f5803))

## 2.0.0 (2019-11-14)


### ⚠ BREAKING CHANGES

* Card.actionIcon now takes a IconButtonConfig instead of
a IconConfig as first argument
* CheckboxConfig.onClick has been renamed to
CheckboxConfig.onChange
* TextFieldConfig.invalid has been replaced by
TextFieldConfig.valid (default to True). The same is true for
TextAreaConfig
* SnackbarConfig has been extended by a field
`closesOnEscape : Bool`. Additionally, Snackbar.Message's configuration
field timeoutMs has been changed from Float to Int
* SliderConfig.step has been changed from taking a `Maybe
Float` to taking a `Float` only
* SwitchConfig.onClick has been renamed to
SwitchConfig.onChange
* The function ripple has been renamed to boundedRipple.
RippleConfig does not contain the field `unbounded` anymore
* Functions listItem, listItemDivider and
listGroupSubheader now return `ListItem msg` instead of `Html msg`. The
function list has been changed accordingly.
* IconToggleConfig.onClick has been renamed to
IconToggleConfig.onChange
* DismissibleDrawerConfig has been extended by a field
`onClose : Maybe msg`. This facilitates the dismissible drawer closing
on pressing the Escape key.
* SelectConfig has been extended by the following boolean
fields: disabled, required and valid

### Features

* Add fields href, target to ButtonConfig ([3c60856](https://github.com/aforemny/material-components-web-elm/commit/3c60856d469a8afac2ada735c6093159978783fc))
* Add href to ListItemConfig ([6773780](https://github.com/aforemny/material-components-web-elm/commit/6773780bd065b05e9ca8e71079b117eb58fae076))
* Card.actionIcon is now based on IconButton ([0a4a5c0](https://github.com/aforemny/material-components-web-elm/commit/0a4a5c0935b2f5a0858355a8204cb213f51b6acf))


### Bug Fixes

* Checkbox no longer plays animation when initially rendered as checked or indeterminate ([0b8f623](https://github.com/aforemny/material-components-web-elm/commit/0b8f6237020053a15d21614f91275c92bbe8690a))
* Dialog applies additionalAttributes ([02fae12](https://github.com/aforemny/material-components-web-elm/commit/02fae12186c22de3a21c1f87be5ee02d3671d064))
* Disabled buttons now work ([97a66f4](https://github.com/aforemny/material-components-web-elm/commit/97a66f4a1db82efa3fd345f95a0b6010899ffecf))


* Update checkbox implementation ([78f99d4](https://github.com/aforemny/material-components-web-elm/commit/78f99d4e66c15c91f0db4a9131383cf6533b6f6d))
* Update drawer implementation ([83aa9d8](https://github.com/aforemny/material-components-web-elm/commit/83aa9d8d185761557cd7903a5ab200c18ec17acf))
* Update icon button implementation ([7fde683](https://github.com/aforemny/material-components-web-elm/commit/7fde6838c8bac6b55250f090c3bce349198353b5))
* Update image list item implementation ([22d3a7d](https://github.com/aforemny/material-components-web-elm/commit/22d3a7d169b1e53d49ee6f5934d347ab1f35fb99))
* Update ripple implementation ([704f9e8](https://github.com/aforemny/material-components-web-elm/commit/704f9e8691ba93b60257c4f9fbd63d936d5e7f35))
* Update select implementation ([94e7a0c](https://github.com/aforemny/material-components-web-elm/commit/94e7a0c31ac957916121ae539d7de3be34f2e283))
* Update slider implementation ([bf7ad91](https://github.com/aforemny/material-components-web-elm/commit/bf7ad9182eb5a8cb43d48edfcafc94e1a0fae9b0))
* Update snackbar implementation ([278ea96](https://github.com/aforemny/material-components-web-elm/commit/278ea96805a21583b9f2f5a2c8d030f7fec76da2))
* Update switch implementation ([11d10a8](https://github.com/aforemny/material-components-web-elm/commit/11d10a8b7835e723eb0328007d69c1089d9469b0))
* Update text field implementation ([b4a73ca](https://github.com/aforemny/material-components-web-elm/commit/b4a73cab6d987664fd79bfef184ec174f3ae8327))

### 1.0.1 (2019-10-27)


### Bug Fixes

* Add ripple to image list items ([1e81d39](https://github.com/aforemny/material-components-web-elm/commit/1e81d392b10cae65c09f5831b2174a11808d682a))
* Add support for Elm 0.19.1 ([94d1137](https://github.com/aforemny/material-components-web-elm/commit/94d113733a35fd2a921f42f6fb81d3e1f8a4b977))
* Permanent drawer destroys foundation ([e7c8bef](https://github.com/aforemny/material-components-web-elm/commit/e7c8bef5fa587a928e820915318f19d8503cd035))

## 1.0.0 (2019-09-29)


### Bug Fixes

* **docs:** Use CDN links in README and examples ([a3859d2](https://github.com/aforemny/material-components-web-elm/commit/a3859d2ba115198dff64148c85bf591aac133705))
