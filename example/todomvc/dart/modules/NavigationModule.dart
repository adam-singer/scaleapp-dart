part of scaleAppTodoMVC;

class NavigationModule extends Module {
  DivElement moduleView;
  Element navLinkList;
  
  Function onNavItemClickListener;
  
  String activeModuleName;
  
  NavigationModule(Sandbox sandbox) : super(sandbox) {
    this.setupNavItemClickListener();
  }
  
  void start () {
    super.start();
    
    this.subscribeToEventsInChannels({'module' : ['navigation-run', 'navigation-stop', 
    'about-run', 'about-stop', 'contact-run', 'contact-stop', 'todolist-run', 'todolist-stop']});
  }
  
  void receiveMessage(String channelName, String eventName, data) { 
    switch (eventName) {
      case 'navigation-run':
        this.moduleView = this.sandBox.obtain('navbar');
        this.navLinkList = this.moduleView.query('ul.nav');
        this.navLinkList.queryAll('a').forEach((AnchorElement link) => link.on.click.add(this.onNavItemClickListener));
        
        break;
      case 'navigation-stop':
        break;
      case 'about-run':
      case 'contact-run':
      case 'todolist-run':
        Element activeElement = this.navLinkList.query('li.active');
        if (activeElement != null) {
          activeElement.classes.remove('active');
        }
        
        this.activeModuleName = eventName.replaceAll('-run', '');
        this.navLinkList.query('a[href="#${this.activeModuleName}"]').parent.classes.add('active');
        break;
    }
  }
  
  void setupNavItemClickListener() {
    this.onNavItemClickListener = (MouseEvent event) {
      event.preventDefault();
      AnchorElement navItem = event.toElement;
      
      String moduleName = navItem.href.split('#')[1];
      if (moduleName != this.activeModuleName) {
        this.sandBox.publish('module', '${this.activeModuleName}-stop', null);
        this.sandBox.publish('module', '${moduleName}-run', null);
      }
      
    };
  }
}
