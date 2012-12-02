import '../packages/unittest/unittest.dart';
import '../lib/scaleapp.dart';

main() {
  TestSandbox sandBox = new TestSandbox();
  Application app = new Application();
  
  test('Test start / stop', () {
    TestModule module = new TestModule(sandBox);
    
    module.start();
    expect(module.isRunning, true, reason:"Module is running");
    
    module.stop();
    expect(module.isRunning, false, reason:"Module is not running");
  });
  
  test('Test register / unregister', () {
    TestModule module = new TestModule(sandBox);
    
    app.registerModule(module, "TestModule");
    expect(app.getModule("TestModule") == module, true, reason:"Module was registered");
    
    app.unregisterModule("TestModule");
    expect(app.getModule("TestModule") == null, true, reason:"Module was unregistered");
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
  
  TestModule(Sandbox sandBox) : super(sandBox);
  
  void receiveMessage(String channelName, String eventName, data) {
    this.lastChannel = channelName;
    this.lastEventName = eventName;
    this.lastData = data;
  }
}