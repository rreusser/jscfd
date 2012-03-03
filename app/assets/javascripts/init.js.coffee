$(document).ready () ->
  @myCodeMirror = new Object
  for editor in ['snippet_functions','snippet_init','snippet_iteration']
    @myCodeMirror[editor] = CodeMirror.fromTextArea $("##{editor}")[0], {
        smartIndent: false,
        lineNumbers: true,
        matchBrackets: true,
        fixedGutter: true
      }

  $('#tabpane .tab').hide().eq(0).show()
  $('#tabpane .tabselect').on 'click','li', () ->
    t = $('#tabpane .tabselect li').index($(this))
    $('#tabpane .tab').eq(t).css('z-index',101).fadeIn(200,() ->
      $('#tabpane .tab').not(':eq('+t+')').css('z-index',99).hide()
      $('#tabpane .tab').eq(t).css('z-index',100)
    )
    $('#tabpane .tabselect li').removeClass('active')
    $(this).addClass('active')

  $('#save').click () ->
    $('#new_snippet, .edit_snippet').submit()

