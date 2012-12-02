part of scaleapp;

abstract class Module {
  Sandbox sandBox;
  bool isRunning;
  
  Module(Sandbox this.sandBox);
  void start() {
    this.isRunning = true; 
  }
  
  void stop() {
    this.isRunning = false; 
  }
  
  void receiveMessage(String channelName, String eventName, data);
  
  void subscribeToEventsInChannels(Map<String, List<String>> channelEventMapping) {
    for (String channelName in channelEventMapping.keys) {
      channelEventMapping[channelName].forEach((String eventName) {
        this.subscribe(channelName, eventName);
      });
    }
  }
  
  void unsubscribeFromEventsInChannels(Map<String, List<String>> channelEventMapping) {
    for (String channelName in channelEventMapping.keys) {
      channelEventMapping[channelName].forEach((String eventName) {
        this.unsubscribe(channelName, eventName);
      });
    }
  }
  
  void subscribe(String channelName, String eventName) {
    this.sandBox.mediator.subscribe(channelName, eventName, this);
  }
  
  void unsubscribe(String channelName, String eventName) {
    this.sandBox.mediator.unsubscribe(channelName, eventName, this);
  }
}
