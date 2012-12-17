part of scaleAppTodoMVC;

class ToDo {
  num id;
  String text;
  
  ToDo (String this.text) {
    this.id = -1;
  }
  
  bool isPhantom() {
    return this.id == -1;
  }
}
