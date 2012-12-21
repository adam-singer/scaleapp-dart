part of scaleAppTodoMVC;

class ToDoListModule extends Module {
  DivElement moduleView;
  
  Element todoListElement;
  
  ButtonElement todoAddButtonElement;
  InputElement todoNameInputElement;
  
  EventListener onItemDeleteClicked;
  
  Function todoTemplateFunction;
  
  ToDoListModule(Sandbox sandbox) : super(sandbox) {
    this.setupOnItemDeleteClickListener();
  }
  
  void start () {
    super.start();
    
    this.subscribeToEventsInChannels({'module' : ['todolist-run', 'todolist-stop']});
  }
  
  void receiveMessage(String channelName, String eventName, data) {
      switch (eventName) {
        case 'todolist-run':
            DivElement viewPort = this.sandBox.obtain('viewport');
            this.moduleView = this.sandBox.obtain('template-todolistview')();
            
            viewPort.children.add(this.moduleView);
            
            this.todoListElement = this.moduleView.query("ul");
            
            this.setupInputElement();
            this.setupAddButton();
            this.renderStorage();
            
            if (this.todoListElement.children.length == 0) {
              ["Buy Fruits", "Call Mom", "Somewhat else"].forEach(this.addToList);
            }
          break;
        case 'todolist-stop':
            this.moduleView.remove();  
          break;
      }
  }
  
  void addToList(String text) {
    ToDoStorage storage = this.sandBox.obtain('storage-todo');
    ToDo record = storage.create(text);
    
    this.renderToDoListItem(record);
  }
  
  void renderToDoListItem(ToDo record) {
    Element newListItem = this.sandBox.obtain('template-todolistitem')(record.id, record.text);
    newListItem.query('a.icon-remove').on.click.add(this.onItemDeleteClicked);
    this.todoListElement.children.add(newListItem);
  }
  
  void renderStorage() {
    ToDoStorage storage = this.sandBox.obtain('storage-todo');
    List<ToDo> todos = storage.getAll();
    
    for (ToDo record in todos) {
      this.renderToDoListItem(record);
    }
  }
  
  
  
  void setupOnItemDeleteClickListener() {
    this.onItemDeleteClicked = (MouseEvent event) {
      event.preventDefault();
      
      ToDoStorage storage = this.sandBox.obtain('storage-todo');
      
      AnchorElement clickedLink = event.target;
      DivElement idElement = clickedLink.parent;
      int id = int.parse(idElement.id.replaceAll('todo-', ''));
      
      storage.destroy(storage.get(id));
      
      event.toElement.parent.parent.remove();
    };
  }
  
  void setupAddButton() {
    this.todoAddButtonElement = this.moduleView.query("form > button");
    this.todoAddButtonElement.on.click.add((MouseEvent event) {
      event.preventDefault();
      if (this.todoNameInputElement.value.length > 0) {
        this.addToList(this.todoNameInputElement.value);
        this.todoNameInputElement.value = "";
      }
    });
  }
  
  void setupInputElement() {
    this.todoNameInputElement = this.moduleView.query("form > input");
    this.todoNameInputElement.on.keyUp.add((KeyboardEvent event) {
      if (event.keyCode == KeyCode.ENTER && this.todoNameInputElement.value.length > 0) {
        this.addToList(this.todoNameInputElement.value);
        this.todoNameInputElement.value = "";
      }
    });
  }
}
