module spindle_speed_controller() {
  scale(25.4)
  translate([0, 0, 1.5]) {
    color("gray")
    translate([0, 0, -0.75]) 
    difference() {
      cube(size=[3, 2, 1.5], center=true);
      for (x=[-3:3]) {
        translate([x * 3 / 7, 0, -0.75]) {
          cube(size=[3/2/7 - 0.125, 2.5, 2.5], center=true);
        }
      }
      for (y=[-1,1]) {
        translate([0.5 + .125/2, y * (44 / 25.4 / 2), 0]) 
        #cylinder(r=.125/2, h=3, center=true, $fn=12);
      }
    }

    color("green")
    translate([-0.5, 0, 0.275]) 
    cube(size=[2, 2, 0.0625], center=true);

    color("black")
    translate([0, 0.5, 0.275 + 0.75]) 
    cylinder(r=0.5, h=1.5, center=true, $fn=36);
  }
}