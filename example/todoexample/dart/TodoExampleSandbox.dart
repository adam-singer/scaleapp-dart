part of scaleAppTodoExample;

class TodoExampleSandbox extends Sandbox{

  ToDoStorage toDoStorage = new ToDoStorage();
  
  TodoExampleSandbox(Core core) : super(core);
  
  dynamic obtain(String objectName, {dynamic optArgs}) {
     switch(objectName) {
       case 'viewport':
         return query('#viewport');
       case 'navbar':
         return query('#navbar');
       case 'storage-todo':
         return this.toDoStorage;
       case 'template-todolistview':
         return ToDoListViewTemplate;
       case 'template-todolistitem':
         return ToDoListItemTemplate;
       case 'template-aboutview':
         return AboutTemplate;
       case 'template-contactview':
         return ContactTemplate;
     }      
  }
}
