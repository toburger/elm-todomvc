import Html exposing (Html)
import TodoStore exposing (initialModel, update)
import TodoStoreView exposing (view)
import StartApp.Simple

main : Signal Html
main =
    StartApp.Simple.start
        { model = initialModel
        , update = update
        , view = view
        }
