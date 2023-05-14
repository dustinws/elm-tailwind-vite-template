module Main exposing (Model, Msg, main)

import Browser
import Browser.Navigation as Nav
import Html
import Html.Attributes as Attributes
import Route
import Url



---- PROGRAM ----
-----------------


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }



---- MODEL ----
---------------


type alias Model =
    { navKey : Nav.Key
    , route : Route.Route
    }



---- INIT ----
--------------


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        model : Model
        model =
            { navKey = navKey
            , route = Route.fromUrl url
            }
    in
    ( model, Cmd.none )



---- MSG ----
-------------


type Msg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest



---- UPDATE ----
----------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangedUrl url ->
            ( { model | route = Route.fromUrl url }, Cmd.none )

        ClickedLink (Browser.Internal url) ->
            ( model, Nav.pushUrl model.navKey (Url.toString url) )

        ClickedLink (Browser.External href) ->
            ( model, Nav.load href )



---- VIEW ----
--------------


view : Model -> Browser.Document Msg
view _ =
    { title = "Elm Vite Template"
    , body =
        [ Html.div
            [ Attributes.class "font-bold" ]
            [ Html.text "Elm Vite Template w/ Tailwind" ]
        ]
    }
