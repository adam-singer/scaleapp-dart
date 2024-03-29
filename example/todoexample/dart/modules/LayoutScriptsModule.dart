part of scaleAppTodoExample;

class LayoutScriptsModule extends Module{
  
  LayoutScriptsModule(Sandbox sandbox) : super(sandbox);
  
  void start() {
    super.start();
    
    this.subscribe("ui", "layout");
  }
  
  void receiveMessage(String channelName, String eventName,  {dynamic data}) {
      switch (eventName) {
        case 'layout':
          DivElement viewPort = this.sandBox.obtain("viewport");
          DivElement navbar = this.sandBox.obtain("navbar");
          viewPort.style.top = "${navbar.clientHeight}px";        
          break;
      }  
  }
}
