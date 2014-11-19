use <makerslide.scad>

t = 3;
r = 1;

w = 20;
h = 40;

m = 5;

module adapter() {
  difference() {
    hull() {
      for (x=[-1,1], y=[-1,1]) {
        translate([x * (w/2 - r) , y * (h/2 - r), 0]) 
          circle(r=r);
      }
    }
    translate([0, 10, 0]) 
      circle(r=m/2, $fn=36);

    for (z=[-1,1]) {
      translate([10.6 / 2 - 6.5 - 2.5/2, - h / 2 + 20 / 2 + 3 + z * (12 / 2 - 2.5 / 2), 0]) 
      rotate([0, 90, 0]) circle(r=1.9/2, h=10, center=true, $fn=12);
    }
  }
}

module switch() {
  color("gray")
  difference() {
    cube(size=[6.5, 10.6, 20], center=true);
    for (z=[-1,1]) {
      translate([0, 10.6 / 2 - 6.5 - 2.4/2, z * (12 / 2 - 2.5 / 2)]) 
      rotate([0, 90, 0]) cylinder(r=2.4/2, h=10, center=true, $fn=12);
    }
  }
  color("gray")
  translate([0, -10.6 / 2 - 2, 0]) 
  cube(size=[3.25, 4, 17], center=true);
  
  color("red")
  translate([0, 20/2, -22/2 + 4.6/2]) 
  rotate([0, 90, 0]) 
  cylinder(r=4.6/2, h=6.2, center=true);
  
  color("gray")
  translate([0, 0, 8]) 
  rotate([9, 0, 0]) 
  translate([0, 10.6/2 + 1/2, -18/2]) 
  cube(size=[4.2, 1, 18], center=true);
}

translate([t + 6.5 / 2, w/2, - h / 2 + 20 / 2 + 3]) 
switch();

color("blue")
translate([t/2, w/2, 0]) 
rotate([90, 0, 90]) 
linear_extrude(height=t, center=true) 
!adapter();

translate([-20, 50, 0]) rotate([90, 0, 0]) makerslide();