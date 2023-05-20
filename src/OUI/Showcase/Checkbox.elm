module OUI.Showcase.Checkbox exposing (book)

import Element exposing (Element)
import OUI
import OUI.Checkbox as Checkbox
import OUI.Explorer as Explorer
import OUI.Icon exposing (clear)
import OUI.Material as Material
import OUI.Material.Theme exposing (defaultTheme)


book =
    Explorer.book "Checkbox"
        |> Explorer.withStaticChapter checkbox


onChange : String -> Bool -> Explorer.BookMsg
onChange name checked =
    Explorer.event <|
        name
            ++ " changes to "
            ++ (if checked then
                    "'checked'"

                else
                    "'unchecked'"
               )


checkbox : Element Explorer.BookMsg
checkbox =
    Element.column [ Element.spacing 30 ]
        [ Element.text "Checkbox"
        , Element.row [ Element.spacing 30 ]
            [ Checkbox.new
                |> Checkbox.onChange (onChange "unchecked")
                |> Checkbox.withChecked False
                |> Material.renderCheckbox defaultTheme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "checked")
                |> Checkbox.withChecked True
                |> Material.renderCheckbox defaultTheme []
            , Checkbox.new
                |> Checkbox.disabled
                |> Checkbox.withChecked False
                |> Material.renderCheckbox defaultTheme []
            , Checkbox.new
                |> Checkbox.disabled
                |> Checkbox.withChecked True
                |> Material.renderCheckbox defaultTheme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "custom icon")
                |> Checkbox.withChecked True
                |> Checkbox.withIcon clear
                |> Material.renderCheckbox defaultTheme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "unchecked error")
                |> Checkbox.withChecked False
                |> Checkbox.withColor OUI.Error
                |> Material.renderCheckbox defaultTheme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "checked error")
                |> Checkbox.withChecked True
                |> Checkbox.withColor OUI.Error
                |> Material.renderCheckbox defaultTheme []
            ]
        ]
