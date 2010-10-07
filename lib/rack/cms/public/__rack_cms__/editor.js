;(function($){
  
  $('*[ctitle]').live('click', function(){
    var el = $(this);
    if (el.data('locked')) return;
    
    el.data({ original: el.html(), locked: true });
    var edit = $('<input type="text" />')
                  .val(el.html())
                  .css({
                    width: el.width(),
                    height: el.height()
                  })
                  .focus()
                  .blur(function(){
                    var control = $(this);
                    // JS-fu is weak now
                    var payload = {};
                    payload[el.attr('ctitle')] = control.val();
                    
                    $.ajax({
                      url: '/__update__',
                      type: 'PUT',
                      data: payload,
                      complete: function() {
                        el.html(control.val());
                      }
                    })
                  });
    el.html(edit);
  });
  
})(jQuery)