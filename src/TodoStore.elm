module TodoStore exposing (..)

import String


type alias TodoId =
  Int


type Msg
  = Create String
  | Complete TodoId
  | Destroy TodoId
  | DestroyCompleted
  | ToggleCompleteAll
  | UndoComplete TodoId
  | UpdateText TodoId String


type alias TodoItem =
  { id : TodoId
  , text : String
  , complete : Bool
  }


type alias Model =
  { todos : List TodoItem
  , uid : Int
  }


initialModel : Model
initialModel =
  { todos = []
  , uid = 1
  }


withComplete : Bool -> TodoId -> TodoItem -> TodoItem
withComplete complete id item =
  if item.id == id then
    { item | complete = complete }
  else
    item


update : Msg -> Model -> Model
update action model =
  case action of
    Create untrimmedText ->
      let
        text =
          String.trim untrimmedText
      in
        {- if String.isEmpty text then
               model
           else
        -}
        { model
          | todos = model.todos ++ [ TodoItem model.uid text False ]
          , uid = model.uid + 1
        }

    Complete id ->
      { model | todos = List.map (withComplete True id) model.todos }

    UndoComplete id ->
      { model | todos = List.map (withComplete False id) model.todos }

    Destroy id ->
      let
        todosWithoutId =
          List.filter (\item -> item.id /= id) model.todos
      in
        { model | todos = todosWithoutId }

    ToggleCompleteAll ->
      { model | todos = List.map (\item -> { item | complete = True }) model.todos }

    DestroyCompleted ->
      { model | todos = List.filter (\item -> not item.complete) model.todos }

    UpdateText id untrimmedText ->
      let
        text =
          String.trim untrimmedText
      in
        { model
          | todos =
              List.map
                (\item ->
                  { item
                    | text =
                        if item.id == id then
                          text
                        else
                          item.text
                  }
                )
                model.todos
        }
