var defaultValues = {
  dispatchCreate: "",
  dispatchComplete: 0,
  dispatchDestroy: 0,
  dispatchDestroyCompleted: [],
  dispatchToggleCompleteAll: [],
  dispatchUndoComplete: 0,
  dispatchUpdateText: [0, ""]
};

var ports = Elm.worker(Elm.TodoStoreBroker, defaultValues).ports;

ports.todoListChanges.subscribe(function(updatedTodoList) {
  // Convert from the flat list we're using in Elm
  // to the keyed-by-id object the JS code expects.
  _todos = {};

  updatedTodoList.forEach(function(item) {
    _todos[item.id] = item;
  });

  var $el = document.getElementById('todos');
  $el.innerText = JSON.stringify(_todos);

  //TodoStore.emitChange();
});

ports.dispatchCreate.send("Gotta port more JS to Elm!");
ports.dispatchUpdateText.send([1, "Ported!"]);
ports.dispatchComplete.send(1);
ports.dispatchUndoComplete.send(1);
ports.dispatchDestroyCompleted.send([]);

// Register callback to handle all updates
// AppDispatcher.register(function(action) {
// });
