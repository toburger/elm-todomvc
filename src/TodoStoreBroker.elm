port module TodoStoreBroker exposing (..)

import TodoStore exposing (..)


port dispatchCreate : (String -> msg) -> Sub msg


port dispatchComplete : (TodoId -> msg) -> Sub msg


port dispatchDestroy : (TodoId -> msg) -> Sub msg


port dispatchDestroyCompleted : ({} -> msg) -> Sub msg


port dispatchToggleCompleteAll : ({} -> msg) -> Sub msg


port dispatchUndoComplete : (TodoId -> msg) -> Sub msg


port dispatchUpdateText : (( TodoId, String ) -> msg) -> Sub msg


port todoListChanges : (List TodoItem) -> Cmd msg


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ dispatchCreate Create
    , dispatchComplete Complete
    , dispatchDestroy Destroy
    , dispatchDestroyCompleted (always DestroyCompleted)
    , dispatchToggleCompleteAll (always ToggleCompleteAll)
    , dispatchUndoComplete UndoComplete
    , dispatchUpdateText (uncurry UpdateText)
    ]
