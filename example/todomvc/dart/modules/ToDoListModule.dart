part of scaleAppTodoMVC;

class ToDoListModule extends Module {
  
  List<String> _sampleData = ["Buy Fruits", "Call Mom", "Somewhat else"];

  Map<Element, ToDo> data = new Map<Element, ToDo>();
  
  ToDoListModule(Sandbox sandbox) : super(sandbox) {
    this.onItemDeleteClicked = (MouseEvent event) {
      event.preventDefault();
      Element element = event.toElement.parent.parent;
      this.data.remove(element);
      element.remove();
    };
  }
  
  DivElement moduleView;
  Element todoListElement;
  
  ButtonElement todoAddButtonElement;
  InputElement todoNameInputElement;
  
  void start () {
    super.start();
    
    this.subscribeToEventsInChannels({'module' : ['todolist-run', 'todolist-stop']});
  }
  
  void receiveMessage(String channelName, String eventName, data) {
    if (channelName == 'module') {
      switch (eventName) {
        case 'todolist-run':
          if (this.moduleView == null) {
            DivElement viewPort = this.sandBox.obtain('viewport');
            this.moduleView = new Element.html('''
              <div id="module-todolist" class="container">
                  <ul></ul>
                  <form>
                      <input type="text" size="30"/><button class="btn btn-success">Add</button>
                  </form>
              </div>
            ''');
            viewPort.elements.add(this.moduleView);
            
            this.todoListElement = this.moduleView.query("ul");
            this.todoNameInputElement = this.moduleView.query("form > input");
            this.todoNameInputElement.on.keyUp.add((KeyEvent event) {
              if (event.keyCode == KeyCode.ENTER) {
                if (this.todoNameInputElement.value.length > 0) {
                  this.addToList(this.todoNameInputElement.value);
                  this.todoNameInputElement.value = "";
                }
              }
            });
            
            this.todoAddButtonElement = this.moduleView.query("form > button");
            this.todoAddButtonElement.on.click.add((MouseEvent event) {
              event.preventDefault();
              if (this.todoNameInputElement.value.length > 0) {
                this.addToList(this.todoNameInputElement.value);
                this.todoNameInputElement.value = "";
              }
            });
            
            this._sampleData.forEach(this.addToList);
          }     
          break;
        case 'todolist-stop':
          if (this.moduleView != null) {
            this.moduleView.remove();  
          }
          break;
      }
    }
  }
  
  void addToList(String item) {
    ToDo record = new ToDo(item);
    Element newListItem = new Element.html('<li><div>${record.text} <a class="icon-remove" href="#"/><a class="icon-pencil" href="#"/></div></li>');
    this.data[newListItem] = record;
    newListItem.query('a.icon-remove').on.click.add(this.onItemDeleteClicked);
    this.todoListElement.children.add(newListItem);
  }
  
  EventListener onItemDeleteClicked;
}
