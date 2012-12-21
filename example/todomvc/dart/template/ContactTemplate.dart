part of scaleAppTodoMVC;

Function ContactTemplate = () {
  return new Element.html('''
    <div id="module-contact" class="container">
      <div class="container">
        <h2>Any questions ?</h2>
        <p>Chances are, that they're a lot questions about the sense of this lib.<br>
        Feel free to ask! :)</p>
        <div class="row-fluid">
          <div class="span4">
            <img src="img/profilbild.jpg">
           </div>
           <div class="span8">
              <a href="mailto:martyglaubitz@gmail.com">martyglaubitz@gmail.com</a><br>
              <a href="https://plus.google.com/116535705146536015279">Marty Glaubitz on Google Plus</a>
           </div>
        </div>
      </div>
    </div>
  ''');
};
