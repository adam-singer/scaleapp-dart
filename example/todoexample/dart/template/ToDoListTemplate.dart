part of scaleAppTodoExample;

Function ToDoListViewTemplate = () {
  return new Element.html('''
    <div id="module-todolist" class="container">
      <ul></ul>
      <form>
        <input type="text"/><button class="btn btn-success">Add</button>
      </form>
    </div>
  ''');
};
