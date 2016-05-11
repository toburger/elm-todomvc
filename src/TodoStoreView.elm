module TodoStoreView exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput, targetValue)
import Html.Attributes exposing (..)
import TodoStore exposing (..)


todos : Model -> List (Html Msg)
todos model =
  List.map
    (\todoItem ->
      div
        []
        [ input
            [ attribute "type" "checkbox"
            , checked todoItem.complete
            , onClick
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
            , onInput (UpdateText todoItem.id)
            ]
            []
        , button [ onClick (Destroy todoItem.id) ] [ text "delete" ]
        ]
    )
    model.todos


header : List (Html Msg)
header =
  [ button [ onClick (Create "") ] [ text "add" ]
  , button [ onClick ToggleCompleteAll ] [ text "complete all" ]
  , button [ onClick DestroyCompleted ] [ text "delete completed" ]
  ]


view : Model -> Html Msg
view model =
  div
    []
    [ div [] (header)
    , div [] (todos model)
    ]
