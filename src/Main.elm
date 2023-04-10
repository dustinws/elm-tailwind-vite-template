module Main exposing (Model, Msg, main)

import Browser
import Browser.Navigation as Nav
import Html
import Page.Landing
import Page.NotFound
import Page.Redirect
import Page.Todo
import Route
import Session
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


type Model
    = Redirect Session.Session
    | NotFound Session.Session
    | Landing Session.Session
    | Todo Page.Todo.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    changeRouteTo url (Redirect (Session.guest navKey))


toSession : Model -> Session.Session
toSession model =
    case model of
        Redirect session ->
            session

        NotFound session ->
            session

        Landing session ->
            session

        Todo subModel ->
            Page.Todo.toSession subModel


toNavKey : Model -> Nav.Key
toNavKey =
    toSession >> Session.toNavKey



---- UPDATE ----


type Msg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | TodoMsg Page.Todo.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( model, msg ) of
        ( _, ChangedUrl url ) ->
            changeRouteTo url model

        ( _, ClickedLink (Browser.Internal url) ) ->
            ( model
            , Nav.pushUrl
                (toNavKey model)
                (Url.toString url)
            )

        ( _, ClickedLink (Browser.External href) ) ->
            ( model, Nav.load href )

        ( Todo subModel, TodoMsg subMsg ) ->
            Page.Todo.update subMsg subModel
                |> updateWith Todo TodoMsg

        _ ->
            ( model, Cmd.none )


changeRouteTo : Url.Url -> Model -> ( Model, Cmd Msg )
changeRouteTo url model =
    case Route.fromUrl url of
        Route.NotFound ->
            ( NotFound (toSession model), Cmd.none )

        Route.Landing ->
            ( Landing (toSession model), Cmd.none )

        Route.Todos ->
            Page.Todo.init (toSession model)
                |> updateWith Todo TodoMsg


updateWith :
    (model -> Model)
    -> (msg -> Msg)
    -> ( model, Cmd msg )
    -> ( Model, Cmd Msg )
updateWith toModel toMsg ( model, cmd ) =
    ( toModel model, Cmd.map toMsg cmd )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    case model of
        Redirect _ ->
            Page.Redirect.view

        NotFound _ ->
            Page.NotFound.view

        Landing _ ->
            Page.Landing.view

        Todo subModel ->
            Page.Todo.view subModel
                |> viewWith TodoMsg


viewWith : (msg -> Msg) -> Browser.Document msg -> Browser.Document Msg
viewWith toMsg { title, body } =
    { title = title
    , body = List.map (Html.map toMsg) body
    }
