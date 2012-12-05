part of scaleapp;

class Sandbox {
  Core core;
  
  Sandbox(Core this.core);
  
  //just a facade, override to have controll over publishing / subscribtion
  void subscribe(String channelName, String eventName, Module subscriber) => this.core.mediator.subscribe(channelName, eventName, subscriber);
  void unsubscribe(String channelName, String eventName, Module subscriber) => this.core.mediator.unsubscribe(channelName, eventName, subscriber);
  void publish(String channelName, String eventName, data) => this.core.mediator.publish(channelName, eventName, data);
}
