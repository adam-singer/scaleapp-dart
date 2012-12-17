part of scaleAppTodoMVC;

class TodoMVCSandbox extends Sandbox{
  
  TodoMVCSandbox(Core core) : super(core);
  
  dynamic obtain(String objectName, {dynamic optArgs}) {
     switch(objectName) {
       case 'viewport':
         return query('#viewport');
       case 'navbar':
         return query('#navbar');
     }      
  }
}
