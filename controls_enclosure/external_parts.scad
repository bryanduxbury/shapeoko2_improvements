module spindle_power_supply() {
  color("gray")
  difference() {
    cube(size=[215, 115, 50], center=true);
    translate([215/2, 0, 25]) cube(size=[40, 111, 60], center=true);
    
    for (x=[-1,1],y=[-1,1]) {
      // TODO: was it 53 or 43 hole to hole?
      translate([x * (150 / 2), y * (50 / 2), -25]) 
        #cylinder(r=2, h=15, center=true);
    }
  }
}

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

module motor_power_supply() {
  color("black")
  cube(size=[150, 60, 33], center=true);
}

module mains_plug_connector() {
  color("gray") {
    translate([0, -3.25/2, 0]) 
    cube(size=[31.25, 3.25, 24], center=true);

    translate([0, 16/2, 0]) 
    cube(size=[26.75, 16, 19.95], center=true);
  }
}

module led_holder(args) {
  color("green")
  cylinder(r=19/64 * 25.4 / 2, h=10, center=true);
}

module toggle_switch() {
  rotate([15, 0, 0]) translate([0, 0, 5]) cylinder(r=2, h=10, center=true);
  translate([0, 0, -15/2 - 7]) cube(size=[15, 25, 15], center=true);
  translate([0, 0, -7/2]) cylinder(r=5, h=7, center=true);
}

module square_momentary() {
  color("red")
  translate([0, 0, 4]) 
  cube(size=[10, 10, 8], center=true);
}