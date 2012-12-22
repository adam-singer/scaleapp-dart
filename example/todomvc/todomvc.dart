library scaleAppTodoMVC;
import 'dart:html';
import '../../lib/scaleapp.dart';

part 'dart/model/ToDo.dart';
part 'dart/model/ToDoStorage.dart';

part 'dart/template/ContactTemplate.dart';
part 'dart/template/AboutTemplate.dart';
part 'dart/template/ToDoListTemplate.dart';
part 'dart/template/ToDoListItemTemplate.dart';

part 'dart/modules/ContactModule.dart';
part 'dart/modules/NavigationModule.dart';
part 'dart/modules/AboutModule.dart';
part 'dart/modules/LayoutScriptsModule.dart';
part 'dart/modules/ToDoListModule.dart';
part 'dart/TodoMVCSandbox.dart';

class TodoMVCExampleApplication extends Core {
  void run() {
   TodoMVCSandbox sandBox = new TodoMVCSandbox(this);
   
   this.registerModule(new NavigationModule(sandBox), "NavigationModule");
   this.registerModule(new AboutModule(sandBox), "AboutModule");
   this.registerModule(new ContactModule(sandBox), "ContactModule");
   this.registerModule(new ToDoListModule(sandBox), "ToDoListModule");
   this.registerModule(new LayoutScriptsModule(sandBox), "LayoutScriptsModule");
   
   this.getModule("NavigationModule").start();
   this.getModule("AboutModule").start();
   this.getModule("ContactModule").start();
   this.getModule("ToDoListModule").start();
   this.getModule("LayoutScriptsModule").start();
   
   this.mediator.publish('ui', 'layout');
   this.mediator.publish('module', 'navigation-run');
   this.mediator.publish('module', 'todolist-run');
  }
}

main() => new TodoMVCExampleApplication().run();
