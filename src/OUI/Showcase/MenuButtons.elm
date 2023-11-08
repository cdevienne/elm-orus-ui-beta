module OUI.Showcase.MenuButtons exposing (Model, Msg, book)

import Dict exposing (Dict)
import Effect exposing (Effect)
import Element exposing (Element)
import OUI.Button as Button exposing (Button)
import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Helpers
import OUI.Icon
import OUI.Material
import OUI.Menu as Menu
import OUI.MenuButton as MenuButton


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Menu Buttons"
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
        |> Explorer.withChapter chapter


chapter : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
chapter shared model =
    Element.row [ Element.spacing 10 ]
        [ MenuButton.new (MenuButtonMsg "menu1")
            (OnSelect "menu1")
            (Button.new
                "click me"
                |> Button.outlinedButton
            )
            (Menu.new identity
                |> Menu.withItems [ "One", "Two", "Three" ]
                |> Menu.withIcon
                    (\i ->
                        if i /= "Two" then
                            Just OUI.Icon.check

                        else
                            Nothing
                    )
            )
            |> OUI.Material.menuButton shared.theme model.menu1State []
        , MenuButton.new (MenuButtonMsg "menu2")
            (OnSelect "menu2")
            (Button.new
                "click me"
                |> Button.withIcon OUI.Icon.check
                |> Button.iconButton
            )
            (Menu.new identity
                |> Menu.withItems [ "One", "Two", "Three" ]
                |> Menu.withIcon
                    (\i ->
                        if i /= "Two" then
                            Just OUI.Icon.check

                        else
                            Nothing
                    )
            )
            |> MenuButton.alignRight
            |> OUI.Material.menuButton shared.theme model.menu2State []
        ]
        |> Element.map Explorer.bookMsg


type alias Model =
    { menu1State : MenuButton.State
    , menu2State : MenuButton.State
    }


type Msg
    = OnSelect String String
    | MenuButtonMsg String (MenuButton.Msg Msg)


init : Explorer.Shared themeExt -> ( Model, Effect Explorer.SharedMsg Msg )
init _ =
    ( { menu1State = MenuButton.init "menu1"
      , menu2State = MenuButton.init "menu2"
      }
    , Effect.none
    )


subscriptions : Explorer.Shared themeExt -> Model -> Sub Msg
subscriptions _ model =
    Sub.batch
        [ MenuButton.onOutsideClick (MenuButtonMsg "menu1") model.menu1State
        , MenuButton.onOutsideClick (MenuButtonMsg "menu2") model.menu2State
        ]


update : Explorer.Shared themeExt -> Msg -> Model -> ( Model, Effect Explorer.SharedMsg Msg )
update _ msg model =
    case msg of
        MenuButtonMsg id menuMsg ->
            case id of
                "menu1" ->
                    let
                        ( state, cmd ) =
                            MenuButton.update menuMsg model.menu1State
                    in
                    { model
                        | menu1State = state
                    }
                        |> Effect.withCmd cmd

                "menu2" ->
                    let
                        ( state, cmd ) =
                            MenuButton.update menuMsg model.menu2State
                    in
                    { model
                        | menu2State = state
                    }
                        |> Effect.withCmd cmd

                _ ->
                    model
                        |> Effect.withNone

        OnSelect id entry ->
            model
                |> Effect.with
                    (Explorer.logEffect (id ++ "/" ++ entry))