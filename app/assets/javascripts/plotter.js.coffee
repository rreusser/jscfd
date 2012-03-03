$(document).ready () ->
  canvas = document.getElementById("canvas");
  jcanvas = $('#canvas')
  ctx = canvas.getContext('2d')
  canvasWidth = jcanvas.parent().width()
  canvasHeight = jcanvas.parent().height()
  ctx.canvas.width = canvasWidth
  ctx.canvas.height = canvasHeight
  jcanvas.width(canvasWidth)
  jcanvas.height(canvasHeight)

  draw = () ->
    ctx.fillStyle = 'rgb(40,0,0)'
    ctx.fillRect(10,10,20,20)
    ctx.fill()

  canvas_resizer = () ->
    canvasWidth = jcanvas.parent().width()
    canvasHeight = jcanvas.parent().height()
    ctx.canvas.width = canvasWidth
    ctx.canvas.height = canvasHeight
    jcanvas.width(canvasWidth)
    jcanvas.height(canvasHeight)

    draw()
      
  $(window).resize( canvas_resizer )

  draw()
