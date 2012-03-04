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
    @jmin = Math.max(j1,j2)
    @jmax = Math.min(j1,j2)

  draw: =>
    @ctx.strokeStyle = "#000000"
    @ctx.lineWidth=1
    @ctx.beginPath()
    @ctx.moveTo @imin,@jmax-10
    @ctx.lineTo @imin,@jmin
    @ctx.lineTo @imax+10,@jmin
    @ctx.stroke()

    @ctx.beginPath()
    @ctx.moveTo @imax+10,@jmin-3
    @ctx.lineTo @imax+20,@jmin
    @ctx.lineTo @imax+10,@jmin+3
    @ctx.lineTo @imax+10,@jmin-3
    @ctx.fill()

    @ctx.beginPath()
    @ctx.moveTo @imin-3,@jmax-10
    @ctx.lineTo @imin,  @jmax-20
    @ctx.lineTo @imin+3,@jmax-10
    @ctx.lineTo @imin-3,@jmax-10
    @ctx.fill()

    @draw_xtics()
    @draw_ytics()

    @draw_time()

  pos: (x,y) =>
    i = @imin + x/(@xmax-@xmin)*(@imax-@imin)
    j = @jmin + y/(@ymax-@ymin)*(@jmax-@jmin)
    [i,j]

  onetwofive: (x) =>
    floor = Math.pow(10,Math.floor(Math.log(x) / Math.log(10)))
    error = 100
    for otf in [0.5,1,2,5,10,20]
      test = Math.abs(x/floor - otf)
      if test<error
        error=test
        result=otf
    result*floor

  draw_xtics: =>
    @ctx.strokeStyle = "#000000"
    xspacing = @onetwofive((@xmax-@xmin)/((@imax-@imin) / 50))
    x=@xmin+xspacing
    i=1
    while x<@xmax+xspacing/2
      # Grid lines
      @ctx.strokeStyle = "#dddddd"
      @line x, @ymin, x, @ymax

      # Tics
      p1 = @pos(x,@ymin)
      @ctx.beginPath()
      @ctx.strokeStyle = "#000000"
      @ctx.moveTo p1[0], p1[1]
      @ctx.lineTo p1[0], p1[1]-7
      @ctx.stroke()

      # Labels
      @ctx.font = "15px sans-serif"
      @ctx.fillText "#{x.toFixed(2)}", p1[0]-15, p1[1]+20
      i++
      x=@xmin+xspacing*i

  draw_ytics: =>
    yspacing = @onetwofive((@ymax-@ymin)/((@jmin-@jmax) / 50))
    y=@ymin+yspacing
    i=1
    while y<@ymax+yspacing/2
      # Grid lines
      @ctx.strokeStyle = "#dddddd"
      @line @xmin, y, @xmax, y

      # Tics
      p1 = @pos(@xmin,y)
      @ctx.strokeStyle = "#000000"
      @ctx.beginPath()
      @ctx.moveTo p1[0], p1[1]
      @ctx.lineTo p1[0]+7, p1[1]
      @ctx.stroke()
      
      # Labels
      @ctx.font = "15px sans-serif"
      @ctx.fillText "#{y.toFixed(2)}", p1[0]-30, p1[1]+7
      i++
      y=@ymin+yspacing*i

  plot: (variable) =>
    #console.log("Axis.plot(#{variable.name})")
    @ctx.strokeStyle = "#000000"
    x = [@xmin + (@xmax-@xmin)*i/(variable.length-1) for i in [0...variable.length]][0]
    @polyline(x,variable)

  moveTo: (xy) =>
    @ctx.moveTo xy[0], xy[1]

  lineTo: (xy) =>
    @ctx.lineTo xy[0], xy[1]

  draw_time: () =>
    if window.t
      @ctx.font = "15px sans-serif"
      @ctx.fillText "t = #{window.t.toExponential(3)}", @imax-55, @jmax-15
    

    
  line: (x1,y1,x2,y2) =>
    @ctx.beginPath()
    @moveTo @pos(x1,y1)
    @lineTo @pos(x2,y2)
    @ctx.stroke()
    
  polyline: (x,y) =>
    #console.log(x)
    #console.log(y)
    if x.length != y.length
      console.error('Polyline must have same number of points in x and y')
    else
      @ctx.strokeStyle = "#000000"
      @ctx.beginPath()
      @moveTo @pos(x[0],y[0])
      for i in [1...x.length]
        @lineTo @pos(x[i],y[i])
      @ctx.stroke()

      for i in [0...x.length]
        @ctx.beginPath()
        p = @pos(x[i],y[i])
        @ctx.arc(p[0],p[1],2,0,2*Math.PI,true)
        @ctx.fill()




class Plotter
  constructor: (@id, @var) ->
    @canvas = document.getElementById(id)
    @jcanvas = $('#'+@id)
    @ctx = @canvas.getContext('2d')
    @set_padding(35)
    @resize()
    @plotvars = {}


  register: (x) =>
    @plotvars[x.name] = x

  draw: =>
    @ctx.clearRect(0,0,@width,@height)
    @axis.draw()
    for k,v of @plotvars
      @axis.plot(v)

  set_padding: (@padding) =>


  resize: =>
    @ctx = @canvas.getContext('2d')
    @width = $('#'+@id).parent().width()
    @height = $('#'+@id).parent().height()
    @ctx.canvas.width = @width
    @ctx.canvas.height = @height
    $('#'+@id).width(@width)
    $('#'+@id).height(@height)

    @axis = new Axis @ctx
    @axis.set_x_limits( 0.0, 1.0 )
    @axis.set_y_limits( 0.0, 0.2 )
    @axis.set_i_limits( @padding, @width-@padding )
    @axis.set_j_limits( @height-@padding, @padding )
    


$(document).ready () ->
  window.Plotter = new Plotter('canvas')

  $(window).resize () ->
    window.Plotter.resize()
    window.Plotter.draw()

  window.Plotter.draw()


  
