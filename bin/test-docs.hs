{-# LANGUAGE ScopedTypeVariables #-}

import Control.Exception
import Data.List
import System.IO
import System.IO.Temp
import System.Process
import Text.Pandoc.JSON


main = toJSONFilter testDocs


data CodeException = CodeException String deriving Show


instance Exception CodeException


testDocs (CodeBlock meta@(_, ["scss"], _) code) = pure (CodeBlock meta code)

testDocs (CodeBlock meta code) = do
  CodeBlock meta <$> try [trySnippet, tryFull, tryDefinition]
  where
    try (f:fs) = catch (compile f) (\(_::IOError) -> continue fs)
    continue [] = throw (CodeException code)
    continue fs = try fs
    compile f = withTempFile "." "XXXXXX.elm" (f code)

testDocs x = pure x


tryFull code tempFile h = do
  writePrelude h
  hPutStrLn h (noImports code)
  hClose h
  compile tempFile


tryDefinition code tempFile h = do
  writePrelude h
  hPutStrLn h "main = text \"\""
  hPutStrLn h (noImports code)
  hClose h
  compile tempFile


trySnippet code tempFile h = do
  writePrelude h
  hPutStrLn h "type CardClicked = CardClicked"
  hPutStrLn h "type ActionButtonClicked a = ActionButtonClicked a"
  hPutStrLn h "type Dismissed a = Dismissed a"
  hPutStrLn h "type Clicked = Clicked"
  hPutStrLn h "type FabClicked = FabClicked"
  hPutStrLn h ""
  hPutStrLn h "main = text \"\""
  hPutStrLn h ""
  hPutStrLn h "typecheck ="
  hPutStrLn h (indent (noImports code))
  hClose h
  compile tempFile


compile file = do
    sh ("elm make --output /dev/null " ++ file ++ " 2>/dev/null")


sh cmd =
  readCreateProcess (shell cmd) ""


indent =
  unlines . map ("    "++) . lines


noImports =
  unlines . filter (not . isPrefixOf "import ") . lines


writePrelude h = do
  hPutStrLn h "module Main exposing (main)"
  hPutStrLn h ""
  hPutStrLn h "import Html.Attributes exposing (style, class)"
  hPutStrLn h "import Html.Events"
  hPutStrLn h "import Html exposing (Html, text)"
  hPutStrLn h ""
  hPutStrLn h "import Material.Button as Button"
  hPutStrLn h "import Material.Card as Card"
  hPutStrLn h "import Material.Checkbox as Checkbox"
  hPutStrLn h "import Material.Chip.Choice as ChoiceChip"
  hPutStrLn h "import Material.Chip.Filter as FilterChip"
  hPutStrLn h "import Material.Chip.Input as InputChip"
  hPutStrLn h "import Material.DataTable as DataTable"
  hPutStrLn h "import Material.Dialog as Dialog"
  hPutStrLn h "import Material.Drawer.Dismissible as DismissibleDrawer"
  hPutStrLn h "import Material.Drawer.Modal as ModalDrawer"
  hPutStrLn h "import Material.Drawer.Permanent as PermanentDrawer"
  hPutStrLn h "import Material.Elevation as Elevation"
  hPutStrLn h "import Material.Fab as Fab"
  hPutStrLn h "import Material.Fab.Extended as ExtendedFab"
  hPutStrLn h "import Material.FormField as FormField"
  hPutStrLn h "import Material.HelperText as HelperText"
  hPutStrLn h "import Material.Icon as Icon"
  hPutStrLn h "import Material.IconButton as IconButton"
  hPutStrLn h "import Material.IconToggle as IconToggle"
  hPutStrLn h "import Material.ImageList as ImageList"
  hPutStrLn h "import Material.ImageList.Item as ImageListItem"
  hPutStrLn h "import Material.LayoutGrid as LayoutGrid"
  hPutStrLn h "import Material.LinearProgress as LinearProgress"
  hPutStrLn h "import Material.List as List"
  hPutStrLn h "import Material.List.Divider as ListDivider"
  hPutStrLn h "import Material.List.Item as ListItem"
  hPutStrLn h "import Material.Menu as Menu"
  hPutStrLn h "import Material.Radio as Radio"
  hPutStrLn h "import Material.Ripple as Ripple"
  hPutStrLn h "import Material.Select as Select"
  hPutStrLn h "import Material.Select.Item as SelectItem"
  hPutStrLn h "import Material.Slider as Slider"
  hPutStrLn h "import Material.Snackbar as Snackbar"
  hPutStrLn h "import Material.Switch as Switch"
  hPutStrLn h "import Material.Tab as Tab"
  hPutStrLn h "import Material.TabBar as TabBar"
  hPutStrLn h "import Material.TextArea as TextArea"
  hPutStrLn h "import Material.TextField as TextField"
  hPutStrLn h "import Material.Theme as Theme"
  hPutStrLn h "import Material.TopAppBar as TopAppBar"
  hPutStrLn h "import Material.Typography as Typography"
  hPutStrLn h ""
  hPutStrLn h "import Testing.Browser as Browser"
  hPutStrLn h ""
