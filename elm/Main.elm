module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Events
import Remote


initialModel : flags -> ( Model, Cmd Msg )
initialModel _ =
    ( { count = 1 }, Cmd.none )


type Msg
    = Increment
    | Decrement
    | NoOp


type alias Model =
    { count : Int
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Increment ->
            ( { model | count = model.count + 1 }
            , model.count
                |> Remote.Count
                |> Remote.outgoingValue
                |> Remote.outgoing
            )

        Decrement ->
            ( { model | count = model.count + 1 }
            , model.count
                |> Remote.Count
                |> Remote.outgoingValue
                |> Remote.outgoing
            )


view : Model -> Html Msg
view { count } =
    Html.div []
        [ Html.button [ Html.Events.onClick Increment ] [ Html.text "+1" ]
        , Html.div [] [ Html.text <| String.fromInt count ]
        , Html.button [ Html.Events.onClick Decrement ] [ Html.text "-1" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
