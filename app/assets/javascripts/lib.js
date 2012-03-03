document.variables = new Object;

var Var = function( name, n ) {

  // Allocate
  x = new Array(n);
  x.name = name;

  // Initialize
  for(var i=0; i<n; i++) {
    x[i] = 0.0;
  }
  
  document.variables[name] = x;

  return x;
}


