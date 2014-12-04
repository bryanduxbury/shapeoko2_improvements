use <makerslide.scad>

t = 3;
r = 1;

w1 = 10;
w2 = 14;
h = 30;
h2 = 10;

m = 5.5;

s1_head_d = 4.4;
s1_shaft_d = 2.1;

module adapter() {
  difference() {
    union() {
      hull() {
        for (x=[-1,1], y=[-1,1]) {
          translate([x * (w1/2 - r), y * (h/2 - r), 0]) 
          circle(r=r, $fn=36);
        }
      }
      hull() {
        for (x=[-1,1], y=[-1,1]) {
          translate([x * (w2/2 - r), -h/2 + h2/2 + y * (h2/2 - r), 0]) 
          circle(r=r, $fn=36);
        }
      }
    }

    translate([0, 10, 0]) 
      circle(r=m/2, $fn=36);

    for (z=[-1,1]) {
      translate([z * (12 / 2 - 2.5 / 2), -h/2 + h2/2 , 0]) 
      difference() {
        circle(r=s1_head_d/2, $fn=36);
        circle(r=s1_shaft_d/2, center=true, $fn=36);
      }
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


translate([-20, 0, 0]) rotate([0, 0, 0]) makerslide();

translate([-10, -20 - 6.5/2 - 3, -5.5]) rotate([-90, 0, 90]) switch();

color("pink")
translate([-10, -20 - 3/2, 0]) 
rotate([90, 0, 0]) 
linear_extrude(height=3, center=true) !adapter();
//
//
// !difference() {
//   circle(r=5, $fn=36);
//   circle(r=5, $fn=12);
// }