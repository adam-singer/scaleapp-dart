import '../packages/unittest/unittest.dart';
import '../lib/scaleapp.dart';

main() {

  Core core = new Core();
  Sandbox sandBox = new TestSandbox(core);

  test('Test start / stop', () {
    TestModule module = new TestModule(sandBox);

    module.start();
    expect(module.isRunning, true, reason:"Module is running");

    module.stop();
    expect(module.isRunning, false, reason:"Module is not running");
  });

  test('Test register / unregister', () {
    TestModule module = new TestModule(sandBox);

    core.registerModule(module, "TestModule");
    expect(core.getModule("TestModule") == module, true, reason:"Module was registered");

    core.unregisterModule("TestModule");
    expect(core.getModule("TestModule") == null, true, reason:"Module was unregistered");
  });
}

class TestSandbox extends Sandbox {
  TestSandbox(Core core) : super(core);
  
  dynamic obtain(String objectName, {dynamic optArgs}) {
    return null;
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

  TestModule(Sandbox sandBox) : super(sandBox);

  void receiveMessage(String channelName, String eventName,  {dynamic data}) {
    this.lastChannel = channelName;
    this.lastEventName = eventName;
    
    if (?data) {
      this.lastData = data;
    } 
  }
}
