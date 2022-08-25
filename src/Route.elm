module Route exposing (Route(..), fromUrl)

import Url
import Url.Parser as Parser exposing (Parser)



---- ROUTES ----


type Route
    = Landing
    | About
    | Contact
    | NotFound



---- PUBLIC API ----


fromUrl : Url.Url -> Route
fromUrl =
    Parser.parse parser >> Maybe.withDefault NotFound



---- PRIVATE API ----


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Landing Parser.top
        , Parser.map About (Parser.s "about")
        , Parser.map Contact (Parser.s "contact")
        ]
