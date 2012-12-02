import '../packages/unittest/unittest.dart';
import '../lib/scaleapp.dart';

main() {
 TestSandbox sandBox = new TestSandbox();
 Mediator mediator = new Mediator();
 test('Test start / stop', () {
   TestModule module = new TestModule(sandBox, mediator);
   
   module.start();
   expect(module.isRunning, true, reason:"Module is started");
   
   module.stop();
   expect(module.isRunning, false, reason:"Module is stoped");
 });
}

class TestSandbox extends Sandbox{
  obtain(String objectName) {
    print("Try to obtain ".concat(objectName));
  }
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