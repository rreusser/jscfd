window.variables = new Object;

var Var = function( name, n, plot ) {
  var x;

  if( typeof(n) == "number" ) {
    // Assume 1-D:

    // Allocate
    x = new Array(n);
    x.name = name;

    // Initialize
    for(var i=0; i<n; i++) {
      x[i] = 0.0;
    }

    if(plot) {
      window.Plotter.register(x);
    }
      
    window.variables[name] = x;

  } else {
    if( n.length == 2 ) {
      // Assume 2-D

      // Allocate
      x = new Array(n[0]);
      x.name = name;

      // Initialize
      for(var i=0; i<n[0]; i++) {
        x[i] = new Array(n[1]);

        for(var j=0; j<n[1]; j++) {
          x[i][j] = 0.0;
        }
      }
    } else {
      console.error('Var only allocates 1D or 2D arrays.')
    }
  }

  window.variables[name] = x;

  return x;
}


