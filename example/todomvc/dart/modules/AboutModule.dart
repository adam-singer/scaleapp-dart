part of scaleAppTodoMVC;

class AboutModule extends Module{
  DivElement moduleView;
  
  AboutModule(Sandbox sandbox) : super(sandbox);
  
  void start () {
    super.start();
    
    this.subscribeToEventsInChannels({'module' : ['about-run', 'about-stop']});
  }
  
  void receiveMessage(String channelName, String eventName,  {dynamic data}) {
    switch (eventName) {
      case 'about-run':
        DivElement viewPort = this.sandBox.obtain('viewport');
        this.moduleView = this.sandBox.obtain('template-aboutview')();
        viewPort.children.add(this.moduleView);
        break;
      case 'about-stop':
        this.moduleView.remove();
        break;
    }
  }
}
