spacing = 25;
nx = 6;
ny = 6;

for (x=[0:nx-1]) {
  translate([x*spacing, 0, 0]) circle(r=1.5, $fn=12);
}

for (y=[0:ny-1]) {
  translate([0, y*spacing, 0]) circle(r=1.5, $fn=12);
}
