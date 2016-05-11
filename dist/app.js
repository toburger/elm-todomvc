var defaultValues = {
  dispatchCreate: "",
  dispatchComplete: 0,
  dispatchDestroy: 0,
  dispatchDestroyCompleted: [],
  dispatchToggleCompleteAll: [],
  dispatchUndoComplete: 0,
  dispatchUpdateText: [0, ""]
};

var ports = Elm.Main.worker().ports;

ports.todoListChanges.subscribe(function(updatedTodoList) {
  _todos = {};

  updatedTodoList.forEach(function(item) {
    _todos[item.id] = item;
  });

  var $el = document.getElementById('todos');
  $el.innerText = JSON.stringify(_todos);
});

setTimeout(function () {
  ports.dispatchCreate.send("Gotta port more JS to Elm!");
  ports.dispatchUpdateText.send([1, "Ported!"]);
  ports.dispatchComplete.send(1);
  ports.dispatchUndoComplete.send(1);
  ports.dispatchDestroyCompleted.send([]);
}, 0);
