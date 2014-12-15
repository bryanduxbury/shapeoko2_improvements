module spindle_speed_control_pot() {
  color("black")
  translate([0, 0, 9 + 15.2/2]) 
  cylinder(r1=15/2, r2=10/2, h=15.2, center=true);
  
  color("gray") {
    translate([0, 0, 4.5]) 
    cylinder(r=6.7/2, h=9, center=true);

    translate([0, 0, -1.3/2]) 
    hull() {
      cylinder(r=16.25/2, h=1.3, center=true);
      translate([0, -21 + 16.25, 0]) cylinder(r=16.25/2, h=1.3, center=true);
    }

    assign(pot_body_height = 31.5 - 9 - 1.3 - 15.2)
    translate([0, 0, -pot_body_height/2 - 1.3]) 
    cylinder(r=16.25/2, h=pot_body_height, center=true);
  }
}
