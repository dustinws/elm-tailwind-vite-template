module Page.Todo exposing
    ( Model
    , Msg
    , Todo
    , init
    , toSession
    , update
    , view
    )

import Browser
import Html
import Html.Attributes as A
import Html.Events as E
import Session



---- MODEL ----
---------------


type alias Todo =
    { content : String
    , done : Bool
    }


type alias Model =
    { session : Session.Session
    , newTodo : String
    , todos : List Todo
    }


init : Session.Session -> ( Model, Cmd Msg )
init session =
    let
        model : Model
        model =
            { session = session
            , newTodo = ""
            , todos = []
            }
    in
    ( model, Cmd.none )


toSession : Model -> Session.Session
toSession =
    .session



---- UPDATE ----
----------------


type Msg
    = NewTodoChanged String
    | TodoCreated String
    | TodoCompleted Todo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTodoChanged newTodo ->
            ( { model | newTodo = newTodo }, Cmd.none )

        TodoCreated content ->
            ( { model | todos = Todo content False :: model.todos }, Cmd.none )

        TodoCompleted todo ->
            let
                newTodos : List Todo
                newTodos =
                    List.map
                        (\t ->
                            if t == todo then
                                { t | done = True }

                            else
                                t
                        )
                        model.todos
            in
            ( { model | todos = newTodos }, Cmd.none )



---- VIEW ----
--------------


view : Model -> Browser.Document Msg
view model =
    { title = "Todos"
    , body =
        [ Html.div
            [ A.class "flex"
            , A.class "flex-col"
            , A.class "h-full min-h-screen"
            , A.class "w-full"
            , A.class "items-center"
            , A.class "p-4"
            , A.class "space-y-4"
            ]
            [ viewTitle
            , viewNewTodoForm model.newTodo
            , Html.div [] (List.map viewTodo model.todos)
            ]
        ]
    }


viewTitle : Html.Html msg
viewTitle =
    Html.div
        [ A.class "text-4xl" ]
        [ Html.text "Todos" ]


viewNewTodoForm : String -> Html.Html Msg
viewNewTodoForm newTodo =
    Html.form
        [ A.class "flex"
        , A.class "space-x-4"
        , E.onSubmit (TodoCreated newTodo)
        ]
        [ Html.input
            [ A.placeholder "New Todo"
            , A.class "border-2"
            , A.value newTodo
            , E.onInput NewTodoChanged
            ]
            []
        , Html.button
            [ A.class "border-2"
            , A.type_ "submit"
            ]
            [ Html.text "Save" ]
        ]


viewTodo : Todo -> Html.Html Msg
viewTodo todo =
    Html.div
        []
        [ Html.input
            [ A.type_ "checkbox"
            , A.checked todo.done
            , E.onCheck (always (TodoCompleted todo))
            ]
            []
        , Html.text todo.content
        ]
