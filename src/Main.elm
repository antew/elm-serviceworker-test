module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Http
import Process
import Task



---- MODEL ----


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Ping"
    , Process.sleep 1000
        |> Task.perform (\_ -> SendPing)
    )


ping : Cmd Msg
ping =
    Http.send GotText <|
        Http.getString "/ping"



---- UPDATE ----


type Msg
    = SendPing
    | GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText (Ok str) ->
            ( str, Cmd.none )

        GotText (Err str) ->
            ( "Error", Cmd.none )

        SendPing ->
            ( model, ping )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
