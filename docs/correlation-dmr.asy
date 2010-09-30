import graph;

size (400, 300, IgnoreAspect);

file in = input ("docs/dmr-maps-31a-53a.txt").line ();
real[][] a = in.dimension (0, 0);
a = transpose (a);

real[] x = a[0];
real[] y = a[1];

dot (graph (x, y));

xaxis ("Thermodynamic temperature (channel 31a) [K]", BottomTop, LeftTicks);
yaxis ("Thermodynamic temperature (channel 53a) [K]", LeftRight, RightTicks);
