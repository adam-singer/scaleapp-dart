part of scaleAppTodoExample;

Function ToDoListItemTemplate = (int id, String text) {
  return new Element.html('<li><div id="todo-${id}"><span>${text}</span><a class="icon-remove" href="#"/></div></li>');
}; 
