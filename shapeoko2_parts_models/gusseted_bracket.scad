module gusseted_bracket() {
  color("green")
  translate([15, 0, -15]) 
  rotate([-90, 0, 0]) 
  difference() {
    cube(size=[30, 30, 20], center=true);
    translate([4.5, 4.5, 0]) 
    cube(size=[30, 30, 20 - 4.5*2], center=true);
    translate([30/2, 30/2 + 4.5, 0]) rotate([0, 0, 45])
      cube(size=[30 * sqrt(2), 30 * sqrt(2), 21], center=true);
  }
}