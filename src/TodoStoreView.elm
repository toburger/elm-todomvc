module TodoStoreView (..) where

import Html exposing (..)
import Html.Events exposing (onClick, on, targetValue)
import Html.Attributes exposing (..)
import TodoStore exposing (..)


todos : Signal.Address Action -> Model -> List Html
todos address model =
  List.map
    (\todoItem ->
      div
        []
        [ input
            [ attribute "type" "checkbox"
            , checked todoItem.complete
            , onClick
                address
                ((if todoItem.complete then
                    UndoComplete
                  else
                    Complete
                 )
                  todoItem.id
                )
            ]
            []
        , input
            [ value todoItem.text
            , on "input" targetValue (Signal.message address << UpdateText todoItem.id)
            ]
            []
        , button [ onClick address (Destroy todoItem.id) ] [ text "delete" ]
        ]
    )
    model.todos


header : Signal.Address Action -> List Html
header address =
  [ button [ onClick address (Create "") ] [ text "add" ]
  , button [ onClick address ToggleCompleteAll ] [ text "complete all" ]
  , button [ onClick address DestroyCompleted ] [ text "delete completed" ]
  ]


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ div [] (header address)
    , div [] (todos address model)
    ]
