module estop() {
  translate([0, 0, 37/2]) 
  color("red")
  cylinder(r=39/2, h=5, center=true);

  translate([0, 0, 34/2]) 
  color("red")
  cylinder(r=23/2, h=5, center=true);

  // TODO: -5 is a guess. get the real measurement of inside nut
  color("gray")
  translate([0, 0, -5]) {
    translate([0, 0, 20/2]) 
    cylinder(r=27.5/2, h=20, center=true);

    translate([0, 0, -32.35/2]) 
    cube(size=[37.5, 30, 32.25], center=true);
  }
}