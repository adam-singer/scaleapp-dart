part of scaleapp;

class Sandbox {
  Application app;
  
  Sandbox(Application this.app);
  
  //just a facade, override to have controll over publishing / subscribtion
  void subscribe(String channelName, String eventName, Module subscriber) => this.app.mediator.subscribe(channelName, eventName, subscriber);
  void unsubscribe(String channelName, String eventName, Module subscriber) => this.app.mediator.unsubscribe(channelName, eventName, subscriber);
  void publish(String channelName, String eventName, data) => this.app.mediator.publish(channelName, eventName, data);
}
