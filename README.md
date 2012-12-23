scaleapp-dart
=============

Official port and variant of the JavaScript framework [scaleApp](https://github.com/flosse/scaleApp).

It’s tiny
=========

Scaleapp is nor a huge MVC kingdom like you would expect from things like  
PureMVC or ExtJS neither comes it with a lot of black magic tools like templating...  
Its all just about having a simple lib to structure your code.  

In fact: you could write such a framework yourself in less than 1 hour,  
but someone already did that - tests and example included ^^

Here’s no MVC !
===============

If you were looking for a **MVC framework**, you’re in the wrong place.  
But you may take a look on these frameworks avalable for dart:
* [HipsterMVC](http://github.com/eee-c/hipster-mvc)
* [PureMVC](http://github.com/PureMVC/puremvc-dart-multicore-framework)

Ok, why not ?
=============

Sometimes you don’t want to bind yourself to a strong Model, View & Controller  
paradigm but just structure your code somehow. Because: how often did you found yourself putting  
logic in views or data into controllers, just because it wasn’t really clear where to put this piece of code ?  

Furthermore: a few of the mechanisms which control things like binding data to views or  
automatically update records on the server and so on - can be somewhat complex and thus add   
a lot of additional code to your application which has to be send over the wire and executed.  
This may be especially on your mind if you’re intending to run on mobile,  where **every single KB of bandwidth counts!**

What instead ?
==============

Instead of splitting your app into Models, Views and Controllers, your use Modules.  
What are Modules ? They’re just classes which you extend from the _Module_ class  
and can be registered in the application core, started and stopped.  
They also can send and receive messages through a message bus - called mediator.

So what does a module do ? Answer: whatever you want!  
Most of the time you want to seperate the functionality of your app into modules.  
Each module does a specific job and nothing more. 

It doesn't have a direct reference to other modules - it uses the mediator to send messages to them.  
Also it doesn’t use the DOM or Ajax whenever it wants. Instead, it has a reference to a Sandbox object  
which it can ask for everything what it needs.

And that really works ?
=======================

Yes! Take a look at the [running example](http://j20964.servers.jiffybox.net/dart/todoexample/index.html)

Enough - show me code!
======================

You can:  take either:  
+ take a look on the [Todo example](https://github.com/martyglaubitz/scaleapp-dart/tree/master/example/todoexample)  
+ look at the next example to create the main components of an modular app.

**The Sandbox**  
This class is responsible to give a module everything it asks for -  
or maybe not because it doesn’t have the permission, thats up to you...

    class ExampleAppSandbox extends Sandbox {
      ExampleAppSandbox(Core core) : super(core);

      dynamic obtain(String objectName, {dynamic optArgs}) { 
        switch(objectName) {
          case 'viewport':
           return query('#viewport');
          case ‘greeting’:
           return new Element.html(“<b>Hello World !</b>”);
        } 
      }
    }



**The Module**  
This class gets managed by the application core, it shall display the greeting  
when it receives the run message and remove it when it receives the stop message. 

    class GreetingModule extends Module {
      DivElement moduleView;

      GreetingModule(Sandbox sandbox) : super(sandbox);

      void start () {
        super.start();
        this.subscribeToEventsInChannels({'module' : ['greeting-run', 'greeting-stop']});
      }

      void receiveMessage(String channelName, String eventName,  {dynamic data}) {
        switch (eventName) {
          case 'greeting-run':
            DivElement viewPort = this.sandBox.obtain(‘greeting’);
            this.moduleView = this.sandBox.obtain('template-aboutview')();
            viewPort.children.add(this.moduleView);
            break;
          case 'greeting-stop':
            this.moduleView.remove();
            break;
        }
      }
    }

The Application
==============

We’re going to subclass the Core object and make it our application the same.  
You could various things in this class, like functions which proxy the DOM access.  

    class HelloWorldApplication extends Core {
      void run() {
        ExampleAppSandbox sandBox = new ExampleAppSandbox(this);
   
        this.registerModule(new GreetingModule(sandBox), "GreetingModule");
        this.getModule("GreetingModule").start();
        this.mediator.publish('module', 'greeting-run');
      }
    }
    
finally we fire everything up

    main() => new HelloWorldApplication().run();
