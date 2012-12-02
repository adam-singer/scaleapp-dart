import '../packages/unittest/unittest.dart';
import '../lib/scaleapp.dart';

main() {
 TestSandbox sandBox = new TestSandbox();
 Mediator mediator = new Mediator();
 
 test('Test simple subscribe / unsubscribe', () {
   TestModule module = new TestModule(sandBox, mediator);
   
   module.subscribe("channel", "event");
   expect(mediator.channels["channel"]["event"][0] == module, true, reason:"Module was subscribed");
   
   module.unsubscribe("channel", "event");
   expect(mediator.channels["channel"]["event"].length, 0, reason:"Module was unsubscribed");
 });
 
 test('Test nested subscribe / unsubscribe', () {
   TestModule module = new TestModule(sandBox, mediator);
   
   module.subscribeToEventsInChannels({"channel1" : ["event1", "event2"], "channel2" : ["event1", "event2"]});
   expect(mediator.channels["channel1"]["event1"][0] == module, true, reason:"Module was subscribed");
   expect(mediator.channels["channel1"]["event2"][0] == module, true, reason:"Module was subscribed");
   expect(mediator.channels["channel2"]["event1"][0] == module, true, reason:"Module was subscribed");
   expect(mediator.channels["channel2"]["event2"][0] == module, true, reason:"Module was subscribed");
   
   module.unsubscribeFromEventsInChannels({"channel1" : ["event1", "event2"], "channel2" : ["event1", "event2"]});
   expect(mediator.channels["channel1"]["event1"].length, 0, reason:"Module was unsubscribed");
   expect(mediator.channels["channel1"]["event2"].length, 0, reason:"Module was unsubscribed");
   expect(mediator.channels["channel2"]["event1"].length, 0, reason:"Module was unsubscribed");
   expect(mediator.channels["channel2"]["event2"].length, 0, reason:"Module was unsubscribed");
 });
 
 test('Test publish & receive Message', () {
   TestModule module = new TestModule(sandBox, mediator);
   module.subscribe("channel", "event");
   var data = {"message" : "data"};
   
   mediator.publish("channel", "event", data);
   expect(module.lastChannel == "channel", true, reason:"Received message on 'channel'");
   expect(module.lastEventName == "event", true, reason:"Received message 'event'");
   expect(module.lastData == data, true, reason:"Received dataobject withing message");
   
   module.lastChannel = null;
   module.lastEventName = null;
   module.lastData = null;
   
   module.unsubscribe("channel", "event");
   mediator.publish("channel", "event", data);
   
   expect(module.lastChannel == null, true, reason:"Unsubscribed from 'channel'");
   expect(module.lastEventName == null, true, reason:"Unsubscribed from 'event'");
   expect(module.lastData == null, true, reason:"Unsubscribed from 'channel'");
 });
 
 test('Test nested publish & receive Message', () {
   TestModule module = new TestModule(sandBox, mediator);
   module.subscribeToEventsInChannels({"channel1" : ["event1", "event2"], "channel2" : ["event1", "event2"]});
   var data = {"message" : "data"};
   
   mediator.publish("channel1", "event1", data);
   expect(module.lastChannel == "channel1", true, reason:"Received message on 'channel1'");
   expect(module.lastEventName == "event1", true, reason:"Received message 'event1'");
   expect(module.lastData == data, true, reason:"Received dataobject withing message");
   
   mediator.publish("channel1", "event2", data);
   expect(module.lastChannel == "channel1", true, reason:"Received message on 'channel1'");
   expect(module.lastEventName == "event2", true, reason:"Received message 'event2'");
   expect(module.lastData == data, true, reason:"Received dataobject withing message");
   
   mediator.publish("channel2", "event1", data);
   expect(module.lastChannel == "channel2", true, reason:"Received message on 'channel2'");
   expect(module.lastEventName == "event1", true, reason:"Received message 'event1'");
   expect(module.lastData == data, true, reason:"Received dataobject withing message");
   
   mediator.publish("channel2", "event2", data);
   expect(module.lastChannel == "channel2", true, reason:"Received message on 'channel2'");
   expect(module.lastEventName == "event2", true, reason:"Received message 'event2'");
   expect(module.lastData == data, true, reason:"Received dataobject withing message");
   
   module.lastChannel = null;
   module.lastEventName = null;
   module.lastData = null;
   
   module.unsubscribeFromEventsInChannels({"channel1" : ["event2"], "channel2" : ["event2"]});
   mediator.publish("channel1", "event2", data);
   
   expect(module.lastChannel == null, true, reason:"Unsubscribed from 'channel1' event");
   expect(module.lastEventName == null, true, reason:"Unsubscribed from 'event2'");
   expect(module.lastData == null, true, reason:"Unsubscribed from 'channel'");
   
   mediator.publish("channel2", "event2", data);
   
   expect(module.lastChannel == null, true, reason:"Unsubscribed from 'channel2' event");
   expect(module.lastEventName == null, true, reason:"Unsubscribed from 'event2'");
   expect(module.lastData == null, true, reason:"Unsubscribed from 'channel'");
 });
}

class TestSandbox extends Sandbox{
  obtain(String objectName) {}
}

class TestModule extends Module{
  String lastChannel, lastEventName, lastMessage;
  dynamic lastData;
  
  void stop() {
    super.stop();
    this.lastMessage = "stoped";
  }
  
  void start() {
    super.start();
    this.lastMessage = "started";
  }
  
  TestModule(Sandbox sandBox, Mediator mediator) : super(sandBox, mediator);
  
  void receiveMessage(String channelName, String eventName, data) {
    this.lastChannel = channelName;
    this.lastEventName = eventName;
    this.lastData = data;
  }
}