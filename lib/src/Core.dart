part of scaleapp;

class Core {
  final Map<String, Module> _modules = new Map<String, Module>();
  final Map<String, Sandbox> _sandboxes = new Map<String, Sandbox>();
  final mediator = new Mediator();
  
  void registerModule(Module instance, String moduleId) {
    _modules[moduleId] = instance;
  }
  
  void unregisterModule(String moduleId) {
    _modules.remove(moduleId);
  }
  
  Module getModule(String moduleId) {
    return _modules[moduleId];
  }
  
  void registerSandbox(Sandbox instance, String sandboxId) {
    _sandboxes[sandboxId] = instance;
  }
  
  void unregisterSandbox(String sandboxId) {
    _sandboxes.remove(sandboxId);
  }
  
  Sandbox getSandbox(String sandboxId) {
    return _sandboxes[sandboxId];
  }
}