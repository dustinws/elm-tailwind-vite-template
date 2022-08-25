module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class, href)
import Route
import Url



---- PROGRAM ----


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


type alias Model =
    { navKey : Nav.Key
    , route : Route.Route
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( { navKey = navKey
      , route = Route.fromUrl url
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest


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


view : Model -> Browser.Document Msg
view model =
    { title = "Cadence"
    , body =
        [ renderLayout
            [ renderNavLinks
            , div
                [ class "m-96"
                , class "text-4xl"
                ]
                [ renderPage model.route
                ]
            ]
        ]
    }


renderLayout : List (Html Msg) -> Html Msg
renderLayout =
    div
        [ class "flex"
        , class "flex-col"
        , class "h-screen"
        , class "items-center"
        ]


renderNavLinks : Html Msg
renderNavLinks =
    div
        [ class "flex"
        , class "m-4"
        , class "space-x-16"
        , class "text-2xl"
        ]
        [ a [ href "/", class "hover:text-slate-400" ] [ text "Landing" ]
        , a [ href "/about", class "hover:text-slate-400" ] [ text "About" ]
        , a [ href "/contact", class "hover:text-slate-400" ] [ text "Contact" ]
        ]


renderPage : Route.Route -> Html Msg
renderPage route =
    case route of
        Route.Landing ->
            text "Landing Page"

        Route.About ->
            text "About Page"

        Route.Contact ->
            text "Contact Page"

        Route.NotFound ->
            text "404 Not Found Page"
