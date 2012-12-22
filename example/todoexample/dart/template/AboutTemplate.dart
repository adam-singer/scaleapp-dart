part of scaleAppTodoExample;

Function AboutTemplate = () {
  return new Element.html('''
    <div id="module-about" class="container">
      <h3>Why not MVC ?</h3>
      <p>You might have used one or several of those MVC Libraries which seperate your App in
      Models, Views and Controllers.<br>Well as often they have their advantages - as often they’re
      just in your way.<br>For instance: when does the logic leave off from the view and when is it 
      completely in the controller ?<br>You’ll find yourself sometimes to be tempt to have logic in
      the views or even in the model.<br>Another problem: how do you fire up logic in another controller ?
      As soon as one controller directly uses a reference to a another controller,<br>you created a tight
      coupling between your controllers and your app might break as soon as you change/remove this 
      referenced controller.</p>

      <h3>Ok and Modules will help with that ?</h3>
      <p>That depends on your case. If you have an application which displays data/information to the user
      in a typical CRUD (Create / Read / Update / Delete) way,<br>the MVC approach will most likely fit your 
      needs and you maybe just understood the MVC pattern or your library good enough.<br>But in some cases 
      you just want to seperate functionality in appropriate units - Modules. Each module has a specific 
      task it has to do - and nothing more.<br>If it needs then to bind directly to some views to add event 
      listeners or change styles - then be it so.<br>Here we avoid some layer between our functionality and 
      the UI.</p>

      <h3>So what is a Module ?</h3>
      <p>Its just a object which can be started and stopped. It has a reference to a sandbox object which 
      it can ask for resources it needs to do its job.<br>Furthermore it can send messages through the mediator 
      of the sandbox and subscribe to channels/events and react to messages it received through them.<br>If the 
      Module has a UI, it’ll ask the sandbox for a place to put its own view in. It’ll only operate and 
      manipulate this view - staying away from the rest of the ones.<br>Need to make a HttpRequest ? Having 
      to store data ? Ask the sandbox where/how to do it!</p>

     <h3>Why this Sandbox thing ?</h3>
     <p>Well, first off all: you modules shouldn’t have to much knowledge of what’s going on in the
     rest of the app and where they are...<br>They also shouldn’t search through the entire DOM, changing it in 
     various places or directly use libraries and methods available in the runtime.<br>They’ll have to ask the 
     sandbox for objects / functions they can use. This allows your to put proxys behind this objects and 
     functions or completely mock their behaviour -<br>great for unit test or security.</p>
    </div>
  ''');
};
