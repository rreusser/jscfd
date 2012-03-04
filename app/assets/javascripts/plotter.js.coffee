class Axis
  constructor: (@ctx) ->
    
  set_x_limits: (x1,x2) =>
    @xmin = Math.min(x1,x2)
    @xmax = Math.max(x1,x2)

  set_y_limits: (y1,y2) =>
    @ymin = Math.min(y1,y2)
    @ymax = Math.max(y1,y2)

  set_i_limits: (i1,i2) =>
    @imin = Math.min(i1,i2)
    @imax = Math.max(i1,i2)
    
  set_j_limits: (j1,j2) =>
    @jmin = Math.min(j1,j2)
    @jmax = Math.max(j1,j2)
    


class Plotter
  constructor: (@id, @var) ->
    @canvas = document.getElementById(id)
    @jcanvas = $('#'+@id)
    @ctx = @canvas.getContext('2d')
    @resize()

  draw: =>
    @ctx.fillStyle = 'rgb(40,0,0)'
    @ctx.fillRect(10,10,20,20)
    @ctx.fill()

  resize: =>
    @ctx = @canvas.getContext('2d')
    @width = $('#'+@id).parent().width()
    @height = $('#'+@id).parent().height()
    @ctx.canvas.width = @width
    @ctx.canvas.height = @height
    $('#'+@id).width(@width)
    $('#'+@id).height(@height)

    @axis = new Axis @ctx
    


$(document).ready () ->
  @Plotter = new Plotter('canvas')

  $(window).resize () ->
    document.Plotter.resize()
    document.Plotter.draw()

  @Plotter.draw()


  
