module Page.NotFound exposing (view)

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
            ]
            [ Html.div
                [ A.class "text-4xl" ]
                [ Html.text "404 Not Found" ]
            , Html.div
                [ A.class "text-xl" ]
                [ Html.text "This is not the page you seek." ]
            ]
        ]
    }
