library scaleAppTodoMVC;
import 'dart:html';
import '../../lib/scaleapp.dart';

part 'dart/model/ToDo.dart';

part 'dart/modules/LayoutScriptsModule.dart';
part 'dart/modules/ToDoListModule.dart';
part 'dart/TodoMVCSandbox.dart';

class TodoMVCExampleApplication extends Core {
  void run() {
   TodoMVCSandbox sandBox = new TodoMVCSandbox(this);
   
   this.registerModule(new ToDoListModule(sandBox), "ToDoListModule");
   this.registerModule(new LayoutScriptsModule(sandBox), "LayoutScriptsModule");
   
   this.getModule("ToDoListModule").start();
   this.getModule("LayoutScriptsModule").start();
   
   this.mediator.publish('ui', 'layout', null);
   this.mediator.publish('module', 'todolist-run', null);
  }
}

main() => new TodoMVCExampleApplication().run();
