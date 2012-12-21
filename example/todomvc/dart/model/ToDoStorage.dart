part of scaleAppTodoMVC;

class ToDoStorage {
  
  Map<int, ToDo> data = new Map<int, ToDo>();
  int nextId = 1;
  
  ToDo create(String text) {
    ToDo result = new ToDo(text, this.nextId);
    data[result.id] = result;
    
    this.nextId++;
    
    return result;
  }
  
  void destroy(ToDo item) {
    this.nextId = item.id;
    this.data.remove(item.id);
  }
  
  ToDo get(int id) => this.data[id];
  
  List<ToDo> getAll() => this.data.values;
}
