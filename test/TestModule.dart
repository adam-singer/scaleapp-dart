import '../packages/unittest/unittest.dart';
import '../lib/scaleapp.dart';

main() {
  TestSandbox sandBox = new TestSandbox();
  Mediator mediator = new Mediator();
  
  test('Test start / stop', () {
    TestModule module = new TestModule(sandBox, mediator);
    
    module.start();
    expect(module.isRunning, true, reason:"Module is running");
    
    module.stop();
    expect(module.isRunning, false, reason:"Module is not running");
  });
  
  test('Test register / unregister', () {
    TestModule module = new TestModule(sandBox, mediator);
    
    Module.registerModule(module, "TestModule");
    expect(Module.getModule("TestModule") == module, true, reason:"Module was registered");
    
    Module.unregisterModule("TestModule");
    expect(Module.getModule("TestModule") == null, true, reason:"Module was unregistered");
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