$(document).ready () ->
  @myCodeMirror = new Object
  editors = ['snippet_functions','snippet_init','snippet_iteration']
  for editor in editors
    @myCodeMirror[editor] = CodeMirror.fromTextArea $("##{editor}")[0], {
        smartIndent: false,
        lineNumbers: true,
        matchBrackets: true,
        fixedGutter: true
        onChange: () ->
          $('#save').parent().addClass('needssave')
      }

  #refresh = () ->
    #document.myCodeMirror[e].refresh() for e in editors # doesn't work!


  $('#tabpane .ltab').hide().eq(0).show()
  $('#tabpane .tabselect').on 'click','li', () ->
    t = $('#tabpane .tabselect li').index($(this))
    $('#tabpane .ltab').eq(t).css('z-index',101).fadeIn(200,() ->
      #refresh()
      $('#tabpane .ltab').not(':eq('+t+')').css('z-index',99).hide()
      $('#tabpane .ltab').eq(t).css('z-index',100)
    )
    $('#tabpane .tabselect li').removeClass('active')
    $(this).addClass('active')

  
  $('#plotpane .rtab').hide().eq(0).show()
  $('#plotpane .tabselect').on 'click','li', () ->
    t = $('#plotpane .tabselect li').index($(this))
    $('#plotpane .rtab').eq(t).css('z-index',101).fadeIn(200,() ->
      $('#plotpane .rtab').not(':eq('+t+')').css('z-index',99).hide()
      $('#plotpane .rtab').eq(t).css('z-index',100)
    )
    $('#plotpane .tabselect li').removeClass('active')
    $(this).addClass('active')

  save = () ->
    write_to_text_areas()
    $('#save').parent().removeClass('needssave')
    $('#new_snippet, .edit_snippet').submit()

  
  $('#save').click () ->
    save()

  write_to_text_areas = () ->
    document.myCodeMirror[e].save() for e in editors

  execute = (code) ->
    eval(code) if code
  
  run = () ->
    write_to_text_areas()
    execute $('.iteration textarea')[0].value


  init = () ->
    write_to_text_areas()
    execute $('.functions textarea')[0].value
    execute $('.init textarea')[0].value


  $('#init').click () -> init()


  $(window).keydown (e) ->
    #console.log("#{e.which} #{e.shiftKey} #{e.metaKey}")
    if e.metaKey
      switch e.which
        when 83 then e.preventDefault(); save()
        when 38 then e.preventDefault(); init()
        when 39 then e.preventDefault(); run()
