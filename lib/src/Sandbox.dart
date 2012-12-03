part of scaleapp;

abstract class Sandbox {
  Mediator mediator = new Mediator();
  
  //just a facade, override to have controll over publishing / subscribtion
  void subscribe(String channelName, String eventName, Module subscriber) => mediator.subscribe(channelName, eventName, subscriber);
  void unsubscribe(String channelName, String eventName, Module subscriber) => this.mediator.unsubscribe(channelName, eventName, subscriber);
  void publish(String channelName, String eventName, data) => this.mediator.publish(channelName, eventName, data);
  
  obtain(String objectName);
}
