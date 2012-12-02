part of scaleapp;

class Mediator {
  final Map<String, Map<String, List<Module>>> channels = new Map<String, Map<String, List<Module>>>();
  
  void subscribe(String channelName, String eventName, Module subscriber) {
    List<Module> subscribers = _getSubscriberList(channelName, eventName);
    
    if (!subscribers.contains(subscriber)) {
      subscribers.add(subscriber);
    }
  }
  
  void unsubscribe(String channelName, String eventName, Module subscriber) {
    List<Module> subscribers = _getSubscriberList(channelName, eventName);
    
    if (subscribers.contains(subscriber)) {
      subscribers.removeAt(subscribers.indexOf(subscriber, 0));
    }
  }
  
  void publish(String channelName, String eventName, data) {
    _getSubscriberList(channelName, eventName).forEach((Module subscriber) {
       subscriber.receiveMessage(channelName, eventName, data);
    });
  }
  
  List<Module> _getSubscriberList(String channelName, String eventName) {
    Map<String, List<Module>> eventMap = null;
    List<Module> subscribers = null;
    
    //if not exists, create the map representing the channel on the spot 
    if (!channels.containsKey(channelName)) {
      eventMap = new Map<String, List<Module>>();
      channels[channelName] = eventMap;
    }
    else {
      eventMap = channels[channelName];
    }
    
    //if the event and its subscriberlist doenst exists, create it
    if (!eventMap.containsKey(eventName)) {
      subscribers = new List<Module>();
      eventMap[eventName] = subscribers;
    }
    else {
      subscribers = eventMap[eventName];
    }
    
    return subscribers;
  }
}
