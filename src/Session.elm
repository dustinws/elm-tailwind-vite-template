module Session exposing
    ( Session
    , guest
    , toNavKey
    )

{-| This module contains everything that needs to be globally accessible in the
application.


# Types

@docs Session

#Api

@docs guest

@docs toNavKey

-}

import Browser.Navigation as Nav



---- TYPES ----
---------------


{-| The current session type.
-}
type Session
    = Guest Nav.Key



---- API ----
-------------


{-| Create a guest session.
-}
guest : Nav.Key -> Session
guest =
    Guest


{-| Turn a session into a `Browser.Navigation.Key`.
-}
toNavKey : Session -> Nav.Key
toNavKey session =
    case session of
        Guest navKey ->
            navKey
