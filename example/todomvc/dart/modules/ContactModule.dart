part of scaleAppTodoMVC;

class ContactModule extends Module{
  DivElement moduleView;
  
  ContactModule(Sandbox sandbox) : super(sandbox);
  
  void start () {
    super.start();
    
    this.subscribeToEventsInChannels({'module' : ['contact-run', 'contact-stop']});
  }
  
  void receiveMessage(String channelName, String eventName,  {dynamic data}) { 
    switch (eventName) {
      case 'contact-run':
        DivElement viewPort = this.sandBox.obtain('viewport');
        this.moduleView = this.sandBox.obtain('template-contactview')();
        viewPort.children.add(this.moduleView);
        break;
      case 'contact-stop':
        this.moduleView.remove();
        break;
    }
  }
}
