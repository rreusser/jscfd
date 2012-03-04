$(document).ready () ->

  $('.header').noisy({intensity:0.3})
  $('.sidebar').noisy()
  $('.tabselect').noisy()


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


  $('.sidebar').on 'click','ul > li', () ->
    $(this).children().not(':first-child').toggle(100)
    $(this).siblings().children().not(':first-child').hide(100)

  $('.sidebar ul li').children().not(':first-child').toggle()

  save = () ->
    write_to_text_areas()
    $('#save').parent().removeClass('needssave')
    $('#new_snippet, .edit_snippet').submit()

  
  $('#save').click () ->
    save()

  #$(".sidebar").bind "mousewheel", (ev, delta) ->
    #scrollTop = $(this).scrollTop()
    #$(this).scrollTop(scrollTop-Math.round(delta))

  write_to_text_areas = () ->
    document.myCodeMirror[e].save() for e in editors

  execute = (code) =>
    eval(code) if code
  
  window.running = false;

  window.initialized = false

  window.run = () =>
    if window.initialized == true
      write_to_text_areas()
      execute $('.iteration textarea')[0].value
      window.Plotter.draw()
      if( window.running==true )
        setTimeout(
          () -> window.run(),
          10
        )
      
  window.pause = () =>
    console.log('Pausing')
    window.running = false
    $('#init').removeClass('inactive')


  window.step = () =>
    if window.initialized==true
      $('#init').removeClass('inactive')
      if(window.running==true)
        window.running = false
      else
        write_to_text_areas()
        console.log('Steppping')
        execute $('.iteration textarea')[0].value
        window.Plotter.draw()

  window.init = () =>
    if window.running == false
      $('#run').removeClass('inactive')
      $('#pause').removeClass('inactive')
      $('#step').removeClass('inactive')
      window.Plotter.plotvarnames = []
      window.Plotter.plotvars = []
      write_to_text_areas()
      console.log('Initializing')
      execute $('.functions textarea')[0].value
      execute $('.init textarea')[0].value
      window.initialized=true
      window.Plotter.draw()
    else
      console.error("Please stop simulation before reinitializing.")


  $('#init').click () -> init()

  $('#pause').click () -> pause()

  $('#step').parent().on('click','', () ->
    window.step()
  )

  $('#run').addClass('inactive')
  $('#pause').addClass('inactive')
  $('#step').addClass('inactive')

  runbutton = () ->
    if( window.running==false )
      $('#init').addClass('inactive')
      window.running = true
      window.run()

  $('#run').parent().on('click','',() -> runbutton())


  $(window).keydown (e) ->
    #console.log("#{e.which} #{e.shiftKey} #{e.metaKey}")
    if e.metaKey
      switch e.which
        when 49 then e.preventDefault(); init()
        when 50 then e.preventDefault(); pause()
        when 51 then e.preventDefault(); step()
        when 52 then e.preventDefault(); runbutton()

        when 83 then e.preventDefault(); save()
