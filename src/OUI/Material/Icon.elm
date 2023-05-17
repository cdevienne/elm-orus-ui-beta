module OUI.Material.Icon exposing (render)

import Element exposing (Attribute, Element)
import OUI
import OUI.Icon exposing (Icon, Renderer(..))
import OUI.Material.Color
import Svg


render : OUI.Material.Color.Scheme -> List (Attribute msg) -> Icon -> Element msg
render colorscheme attrs icon =
    let
        size =
            icon.size |> Maybe.withDefault 24

        color =
            OUI.Material.Color.getColor
                (icon.color |> Maybe.withDefault OUI.Primary)
                colorscheme
    in
    (case icon.renderer of
        OUI.Icon.Html renderHtml ->
            renderHtml size color
                |> Element.html
                |> Element.map never

        OUI.Icon.Svg renderSvg ->
            renderSvg size color
                |> List.singleton
                |> Svg.svg []
                |> Element.html
                |> Element.map never
    )
        |> Element.el attrs