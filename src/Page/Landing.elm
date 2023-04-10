module Page.Landing exposing (view)

import Browser
import Html
import Html.Attributes as A



---- VIEW ----
--------------


view : Browser.Document msg
view =
    { title = ""
    , body =
        [ Html.div
            [ A.class "flex"
            , A.class "flex-col"
            , A.class "h-full min-h-screen"
            , A.class "w-full"
            , A.class "items-center"
            , A.class "justify-center"
            , A.class "space-y-4"
            ]
            [ Html.div
                [ A.class "text-4xl" ]
                [ Html.text "Landing Page" ]
            , Html.a
                [ A.href "/todos"
                , A.class "text-xl"
                , A.class "text-blue-400"
                , A.class "underline"
                ]
                [ Html.text "Todos Page" ]
            ]
        ]
    }
