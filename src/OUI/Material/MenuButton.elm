module OUI.Material.MenuButton exposing (render)

import Browser.Events as Events
import Element exposing (Attribute, Element)
import Element.Events
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import OUI.Button
import OUI.Material.Button as Button
import OUI.Material.Color exposing (Scheme)
import OUI.Material.Divider as Divider
import OUI.Material.Menu as Menu
import OUI.Material.Typography exposing (Typescale)
import OUI.Menu
import OUI.MenuButton exposing (MenuButton)


render :
    Typescale
    -> Scheme
    -> Button.Theme
    -> Divider.Theme
    -> Menu.Theme
    -> OUI.MenuButton.State
    -> List (Attribute msg)
    -> MenuButton btnC item msg
    -> Element msg
render typescale colorscheme buttonTheme dividerTheme menuTheme state attrs menuBtn =
    let
        props :
            { button : OUI.Button.Button { btnC | hasAction : () } msg
            , menu : OUI.Menu.Menu item msg
            , menuAlign : OUI.MenuButton.Align
            , onKeyDown : OUI.MenuButton.Key -> msg
            , onLoseFocus : msg
            }
        props =
            OUI.MenuButton.properties menuBtn
    in
    Button.render typescale
        colorscheme
        buttonTheme
        (Element.htmlAttribute (Html.Attributes.id state.id)
            :: Element.Events.onLoseFocus props.onLoseFocus
            :: attrs
            ++ (if state.opened then
                    [ Element.below
                        (Menu.render typescale
                            colorscheme
                            dividerTheme
                            menuTheme
                            state.highlighted
                            [ Element.moveDown 1
                            , case props.menuAlign of
                                OUI.MenuButton.AlignLeft ->
                                    Element.alignLeft

                                OUI.MenuButton.AlignRight ->
                                    Element.alignRight
                            ]
                            props.menu
                        )
                    , onKeyDown props.onKeyDown
                    ]

                else
                    []
               )
        )
        props.button


onKeyDown : (OUI.MenuButton.Key -> msg) -> Attribute msg
onKeyDown msg =
    let
        stringToKey : String -> Decode.Decoder OUI.MenuButton.Key
        stringToKey str =
            case str of
                "ArrowDown" ->
                    Decode.succeed OUI.MenuButton.ArrowDown

                "ArrowUp" ->
                    Decode.succeed OUI.MenuButton.ArrowUp

                "Enter" ->
                    Decode.succeed OUI.MenuButton.Enter

                "Escape" ->
                    Decode.succeed OUI.MenuButton.Esc

                _ ->
                    Decode.fail "not used key"

        keyDecoder : Decode.Decoder OUI.MenuButton.Key
        keyDecoder =
            Decode.field "key" Decode.string
                |> Decode.andThen stringToKey
    in
    Html.Events.on "keydown" (Decode.map msg keyDecoder)
        |> Element.htmlAttribute
