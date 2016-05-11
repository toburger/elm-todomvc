import Html.App as Html
import TodoStore exposing (initialModel, update)
import TodoStoreView exposing (view)
import TodoStoreBroker exposing (subscriptions, todoListChanges)


init =
    ( initialModel, todoListChanges [] )


update msg model =
    let model = TodoStore.update msg model
    in ( model, todoListChanges model.todos )


main: Program Never
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
