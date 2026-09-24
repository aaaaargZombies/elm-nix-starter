port module Remote exposing (OutMsg(..), outgoing, outgoingValue)

import Json.Encode exposing (Value)


type OutMsg
    = Count Int


outgoingValue : OutMsg -> { tag : String, data : Value }
outgoingValue msg =
    case msg of
        Count n ->
            { tag = "COUNT", data = Json.Encode.int n }


port outgoing : { tag : String, data : Json.Encode.Value } -> Cmd msg
