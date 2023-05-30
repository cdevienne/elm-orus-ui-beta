module OUI.Showcase.Menus exposing (..)

import Element exposing (Element)
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Material
import OUI.Menu as Menu


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Menu"
        |> Explorer.withChapter chapter


chapter : Explorer.Shared themeExt -> () -> Element (Explorer.BookMsg msg)
chapter shared _ =
    Element.wrappedRow [ Element.spacing 50 ]
        [ Menu.new identity
            |> Menu.withItems [ "one", "two", "three" ]
            |> Menu.onClick (\i -> Explorer.logEvent <| "clicked menu1/" ++ i)
            |> OUI.Material.menu shared.theme []
        , Menu.new identity
            |> Menu.onClick (\i -> Explorer.logEvent <| "clicked menu2/" ++ i)
            |> Menu.withIcon
                (\i ->
                    if i == "two" then
                        Just OUI.Icon.clear

                    else
                        Nothing
                )
            |> Menu.withTrailingIcon
                (\i ->
                    if i == "one" then
                        Just OUI.Icon.check

                    else
                        Nothing
                )
            |> Menu.withItems [ "one", "two", "three", "a longer entry" ]
            |> OUI.Material.menu shared.theme []
        ]
