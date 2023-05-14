module Route exposing
    ( Route(..)
    , fromUrl
    )

{-| This module contains all of the application routes, as well as some helpers
for interacting with them.


# Types

@docs Route


# Api

@docs fromUrl

-}

import Url
import Url.Parser as Parser exposing (Parser)



---- ROUTES ----


{-| All of the `Route` variants.
-}
type Route
    = NotFound
    | Landing



---- PUBLIC API ----


{-| Given a `Url`, find the corresponding `Route`. If no route can be found,
then the `NotFound` route will be returned.
-}
fromUrl : Url.Url -> Route
fromUrl =
    Parser.parse parser >> Maybe.withDefault NotFound



---- PRIVATE API ----


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Landing Parser.top
        ]
