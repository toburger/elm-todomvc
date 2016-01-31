module TodoStoreBroker (..) where

import TodoStore exposing (..)


port dispatchCreate : Signal String
port dispatchComplete : Signal TodoId
port dispatchDestroy : Signal TodoId
port dispatchDestroyCompleted : Signal ()
port dispatchToggleCompleteAll : Signal ()
port dispatchUndoComplete : Signal TodoId
port dispatchUpdateText : Signal ( TodoId, String )


actions : Signal Action
actions =
  Signal.mergeMany
    [ Signal.map Create dispatchCreate
    , Signal.map Complete dispatchComplete
    , Signal.map Destroy dispatchDestroy
    , Signal.map (always DestroyCompleted) dispatchDestroyCompleted
    , Signal.map (always ToggleCompleteAll) dispatchToggleCompleteAll
    , Signal.map UndoComplete dispatchUndoComplete
    , Signal.map (\( id, text ) -> UpdateText id text) dispatchUpdateText
    ]


modelChanges : Signal Model
modelChanges =
  Signal.foldp update initialModel actions


port todoListChanges : Signal (List TodoItem)
port todoListChanges =
  Signal.dropRepeats (Signal.map .todos modelChanges)
